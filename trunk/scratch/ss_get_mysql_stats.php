<?php

# ============================================================================
# This is a script to retrieve information from a MySQL server for input to a
# Cacti graphing process.
#
# This program is copyright (c) 2007 Baron Schwartz. Feedback and improvements
# are welcome.
#
# THIS PROGRAM IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
# MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, version 2.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, write to the Free Software Foundation, Inc., 59 Temple
# Place, Suite 330, Boston, MA  02111-1307  USA.
# ============================================================================

# ============================================================================
# Define MySQL connection constants in config.php.  Arguments explicitly passed
# in from Cacti will override these.  However, if you leave them blank in Cacti
# and set them here, you can make life easier.  Instead of defining parameters
# here, you can define them in another file named the same as this file, with a
# .cnf extension.
# ============================================================================
$mysql_user = 'cactiuser';
$mysql_pass = 'cactiuser';
$mysql_port = 3306;

$heartbeat  = '';      # db.tbl in case you use mk-heartbeat from Maatkit.
$cache_dir  = '/tmp';  # If set, this uses caching to avoid multiple calls.
$poll_time  = 300;     # Adjust to match your polling interval.
$chk_options = array (
   'innodb' => true,    # Do you want to check InnoDB statistics?
   'master' => true,    # Do you want to check binary logging?
   'slave'  => true,    # Do you want to check slave status?
   'procs'  => true,    # Do you want to check SHOW PROCESSLIST?
);
$use_ss     = FALSE; # Whether to use the script server or not

# ============================================================================
# You should not need to change anything below this line.
# ============================================================================

# ============================================================================
# Include settings from an external config file (issue 39).
# ============================================================================
if ( file_exists(__FILE__ . '.cnf' ) ) {
   require(__FILE__ . '.cnf');
}

# ============================================================================
# TODO items, if anyone wants to improve this script:
# * Make sure that this can be called by the script server.
# * Calculate query cache fragmentation as a percentage, something like
#   $status['Qcache_frag_bytes']
#     = $status['Qcache_free_blocks'] / $status['Qcache_total_blocks']
#        * $status['query_cache_size'];
# * Calculate relay log position lag
# ============================================================================

# ============================================================================
# Define whether you want debugging behavior.
# ============================================================================
$debug = TRUE;
error_reporting($debug ? E_ALL : E_ERROR);

# Make this a happy little script even when there are errors.
$no_http_headers = true;
ini_set('implicit_flush', false); # No output, ever.
ob_start(); # Catch all output such as notices of undefined array indexes.
function error_handler($errno, $errstr, $errfile, $errline) {
   print("$errstr at $errfile line $errline\n");
}
# ============================================================================
# Set up the stuff we need to be called by the script server.
# ============================================================================
if ( $use_ss ) {
   if ( file_exists( dirname(__FILE__) . "/../include/global.php") ) {
      # See issue 5 for the reasoning behind this.
      include_once(dirname(__FILE__) . "/../include/global.php");
   }
   elseif ( file_exists( dirname(__FILE__) . "/../include/config.php" ) ) {
      # Some versions don't have global.php.
      include_once(dirname(__FILE__) . "/../include/config.php");
   }
}

# ============================================================================
# Make sure we can also be called as a script.
# ============================================================================
if (!isset($called_by_script_server)) {
   array_shift($_SERVER["argv"]); # Strip off ss_get_mysql_stats.php
   $options = parse_cmdline($_SERVER["argv"]);
   validate_options($options);
   $result = ss_get_mysql_stats($options);
   if ( !$debug ) {
      # Throw away the buffer, which ought to contain only errors.
      ob_end_clean();
   }
   else {
      ob_end_flush(); # In debugging mode, print out the errors.
   }

   # Split the result up and extract only the desired parts of it.
   $wanted = explode(',', $options['items']);
   $output = array();
   foreach ( explode(' ', $result) as $item ) {
      if ( in_array(substr($item, 0, 2), $wanted) ) {
         $output[] = $item;
      }
   }
   print(implode(' ', $output));
}

# ============================================================================
# Work around the lack of array_change_key_case in older PHP.
# ============================================================================
if ( !function_exists('array_change_key_case') ) {
   function array_change_key_case($arr) {
      $res = array();
      foreach ( $arr as $key => $val ) {
         $res[strtolower($key)] = $val;
      }
      return $res;
   }
}

# ============================================================================
# Validate that the command-line options are here and correct
# ============================================================================
function validate_options($options) {
   $opts = array('host', 'items', 'user', 'pass', 'heartbeat', 'nocache', 'port');
   # Required command-line options
   foreach ( array('host', 'items') as $option ) {
      if ( !isset($options[$option]) || !$options[$option] ) {
         usage("Required option --$option is missing");
      }
   }
   foreach ( $options as $key => $val ) {
      if ( !in_array($key, $opts) ) {
         usage("Unknown option --$key");
      }
   }
}

# ============================================================================
# Print out a brief usage summary
# ============================================================================
function usage($message) {
   global $mysql_user, $mysql_pass, $mysql_port, $heartbeat;

   $usage = <<<EOF
$message
Usage: php ss_get_mysql_stats.php --host <host> --items <item,...> [OPTION]

   --host      Hostname to connect to; use host:port syntax to specify a port
               Use :/path/to/socket if you want to connect via a UNIX socket
   --items     Comma-separated list of the items whose data you want
   --user      MySQL username; defaults to $mysql_user if not given
   --pass      MySQL password; defaults to $mysql_pass if not given
   --heartbeat MySQL heartbeat table; defaults to '$heartbeat' (see mk-heartbeat)
   --nocache   Do not cache results in a file
   --port      MySQL port; defaults to $mysql_port if not given

EOF;
   die($usage);
}

# ============================================================================
# Parse command-line arguments, in the format --arg value --arg value, and
# return them as an array ( arg => value )
# ============================================================================
function parse_cmdline( $args ) {
   $result = array();
   $cur_arg = '';
   foreach ($args as $val) {
      if ( strpos($val, '--') === 0 ) {
         if ( strpos($val, '--no') === 0 ) {
            # It's an option without an argument, but it's a --nosomething so
            # it's OK.
            $result[substr($val, 2)] = 1;
            $cur_arg = '';
         }
         elseif ( $cur_arg ) { # Maybe the last --arg was an option with no arg
            if ( $cur_arg == '--user' || $cur_arg == '--pass' || $cur_arg == '--port' ) {
               # Special case because Cacti will pass these without an arg
               $cur_arg = '';
            }
            else {
               die("No arg: $cur_arg\n");
            }
         }
         else {
            $cur_arg = $val;
         }
      }
      else {
         $result[substr($cur_arg, 2)] = $val;
         $cur_arg = '';
      }
   }
   if ( $cur_arg && ($cur_arg != '--user' && $cur_arg != '--pass' && $cur_arg != '--port') ) {
      die("No arg: $cur_arg\n");
   }
   return $result;
}

# ============================================================================
# This is the main function.  Some parameters are filled in from defaults at the
# top of this file.
# ============================================================================
function ss_get_mysql_stats( $options ) {
   # Process connection options and connect to MySQL.
   global $debug, $mysql_user, $mysql_pass, $heartbeat, $cache_dir, $poll_time,
          $chk_options, $mysql_port;

   # Connect to MySQL.
   $user = isset($options['user']) ? $options['user'] : $mysql_user;
   $pass = isset($options['pass']) ? $options['pass'] : $mysql_pass;
   $port = isset($options['port']) ? $options['port'] : $mysql_port;
   $heartbeat = isset($options['heartbeat']) ? $options['heartbeat'] : $heartbeat;
   # If there is a port, or if it's a non-standard port, we add ":$port" to the
   # hostname.
   $host_str  = $options['host']
              . (isset($options['port']) || $port != 3306 ? ":$port" : '');
   $conn = @mysql_connect($host_str, $user, $pass);
   if ( !$conn ) {
      die("MySQL: " . mysql_error());
   }

   $sanitized_host
       = str_replace(array(":", "/"), array("", "_"), $options['host']);
   $cache_file = "$cache_dir/$sanitized_host-mysql_cacti_stats.txt";

   # First, check the cache.
   $fp = null;
   if ( !isset($options['nocache']) ) {
      # This will block if someone else is accessing the file.
      $result = run_query(
         "SELECT GET_LOCK('cacti_monitoring', $poll_time) AS ok", $conn);
      $row = @mysql_fetch_assoc($result);
      if ( $row['ok'] ) { # Nobody else had the file locked.
         if ( file_exists($cache_file) && filesize($cache_file) > 0
            && filectime($cache_file) + ($poll_time/2) > time() )
         {
            # The file is fresh enough to use.
            $arr = file($cache_file);
            # The file ought to have some contents in it!  But just in case it
            # doesn't... (see issue #6).
            if ( count($arr) ) {
               run_query("SELECT RELEASE_LOCK('cacti_monitoring')", $conn);
               return $arr[0];
            }
            else {
               if ( $debug ) {
                  trigger_error("The function file($cache_file) returned nothing!\n");
               }
            }
         }
      }
      if ( !$fp = fopen($cache_file, 'w+') ) {
         die("Can't open '$cache_file'");
      }
   }

   # Set up variables.
   $status = array( # Holds the result of SHOW STATUS, SHOW INNODB STATUS, etc
      # Define some indexes so they don't cause errors with += operations.
      'transactions'          => null,
      'relay_log_space'       => null,
      'binary_log_space'      => null,
      'current_transactions'  => null,
      'locked_transactions'   => null,
      'active_transactions'   => null,
      'innodb_locked_tables'  => null,
      'innodb_lock_structs'   => null,
      # Values for the 'state' column from SHOW PROCESSLIST (converted to
      # lowercase, with spaces replaced by underscores)
      'State_closing_tables'       => null,
      'State_copying_to_tmp_table' => null,
      'State_end'                  => null,
      'State_freeing_items'        => null,
      'State_init'                 => null,
      'State_locked'               => null,
      'State_login'                => null,
      'State_preparing'            => null,
      'State_reading_from_net'     => null,
      'State_sending_data'         => null,
      'State_sorting_result'       => null,
      'State_statistics'           => null,
      'State_updating'             => null,
      'State_writing_to_net'       => null,
      'State_none'                 => null,
      'State_other'                => null, # Everything not listed above
   );

   # Get SHOW STATUS and convert the name-value array into a simple
   # associative array.
   $result = run_query("SHOW /*!50002 GLOBAL */ STATUS", $conn);
   while ($row = @mysql_fetch_row($result)) {
      $status[$row[0]] = $row[1];
   }

   # Get SHOW VARIABLES and convert the name-value array into a simple
   # associative array.
   $result = run_query("SHOW VARIABLES", $conn);
   while ($row = @mysql_fetch_row($result)) {
      $status[$row[0]] = $row[1];
   }

   # Get SHOW SLAVE STATUS.
   if ( $chk_options['slave'] ) {
      $result = run_query("SHOW SLAVE STATUS", $conn);
      while ($row = @mysql_fetch_assoc($result)) {
         # Must lowercase keys because different versions have different
         # lettercase.
         $row = array_change_key_case($row, CASE_LOWER);
         $status['relay_log_space']  = $row['relay_log_space'];
         $status['slave_lag']        = $row['seconds_behind_master'];

         # Check replication heartbeat, if present.
         if ( $heartbeat ) {
            $result = run_query(
               "SELECT GREATEST(0, UNIX_TIMESTAMP() - UNIX_TIMESTAMP(ts) - 1)"
               . "FROM $heartbeat WHERE id = 1", $conn);
            $row2 = @mysql_fetch_row($result);
            $status['slave_lag'] = $row2[0];
         }

         # Scale slave_running and slave_stopped relative to the slave lag.
         $status['slave_running'] = ($row['slave_sql_running'] == 'Yes')
            ? $status['slave_lag'] : 0;
         $status['slave_stopped'] = ($row['slave_sql_running'] == 'Yes')
            ? 0 : $status['slave_lag'];
      }
   }

   # Get info on master logs. TODO: is there a way to do this without querying
   # mysql again?
   $binlogs = array(0);
   if ( $chk_options['master'] && $status['log_bin'] == 'ON' ) { # See issue #8
      $result = run_query("SHOW MASTER LOGS", $conn);
      while ($row = @mysql_fetch_assoc($result)) {
         $row = array_change_key_case($row, CASE_LOWER);
         # Older versions of MySQL may not have the File_size column in the
         # results of the command.  Zero-size files indicate the user is
         # deleting binlogs manually from disk (bad user! bad!) but we should
         # not croak with a thread-stack error just because of the bad user.
         if ( array_key_exists('file_size', $row) && $row['file_size'] > 0 ) {
            $binlogs[] = $row['file_size'];
         }
         else {
            break;
         }
      }
   }

   # Get SHOW PROCESSLIST and aggregate it.
   if ( $chk_options['procs'] ) {
      $result = run_query('SHOW PROCESSLIST', $conn);
      while ($row = @mysql_fetch_assoc($result)) {
         $state = $row['State'];
         if ( is_null($state) ) {
            $state = 'NULL';
         }
         if ( $state == '' ) {
            $state = 'none';
         }
         $state = str_replace(' ', '_', strtolower($state));
         if ( array_key_exists("State_$state", $status) ) {
            increment($status, "State_$state", 1);
         }
         else {
            increment($status, "State_other", 1);
         }
      }
   }

   # Get SHOW INNODB STATUS and extract the desired metrics from it. See issue
   # #8.
   $innodb_complete = false;
   if ( $chk_options['innodb'] && $status['have_innodb'] == 'YES' ) {
      $result        = run_query("SHOW /*!50000 ENGINE*/ INNODB STATUS", $conn);
      $innodb_array  = @mysql_fetch_assoc($result);
      $flushed_to    = false;
      $spin_waits    = array();
      $spin_rounds   = array();
      $os_waits      = array();

      $istatus_text = $innodb_array['Status'];
      $istatus_vals = get_innodb_array($istatus_text);

      $innodb_complete
         = strpos($innodb_array['Status'], 'END OF INNODB MONITOR OUTPUT');
   }

   if ( !$innodb_complete ) {
      # TODO: Fill in some values with stuff from SHOW STATUS.
   }

   # Derive some values from other values.

   if ( $innodb_txn ) {
         $txn = make_bigint($innodb_txn[0], $innodb_txn[1]);
         $lsn = make_bigint($innodb_lsn[0], $innodb_lsn[1]);
         $flu = make_bigint($flushed_to[0], $flushed_to[1]);
         $prg = make_bigint($innodb_prg[0], $innodb_prg[1]);
      $sql = "SELECT CONCAT('', $txn) AS innodb_transactions, "
           . "CONCAT('', ($txn - $prg)) AS unpurged_txns, "
           . "CONCAT('', $lsn) AS log_bytes_written, "
           . "CONCAT('', $flu) AS log_bytes_flushed, "
           . "CONCAT('', ($lsn - $flu)) AS unflushed_log, "
           . "CONCAT('', " . implode('+', $spin_waits) . ") AS spin_waits, "
           . "CONCAT('', " . implode('+', $spin_rounds) . ") AS spin_rounds, "
           . "CONCAT('', " . implode('+', $os_waits) . ") AS os_waits";
      $result = run_query($sql, $conn);
      while ( $row = @mysql_fetch_assoc($result) ) {
         foreach ( $row as $key => $val ) {
            $status[$key] = $val;
         }
      }
      # TODO: I'm not sure what the deal is here; need to debug this.  But the
      # unflushed log bytes spikes a lot sometimes and it's impossible for it to
      # be more than the log buffer.
      $status['unflushed_log']
         = max($status['unflushed_log'], $status['innodb_log_buffer_size']);
   }

   if (count($binlogs)) {
      $status['binary_log_space'] = sprintf('%u', array_sum($binlogs));
   }

   # Define the variables to output.  I use shortened variable names so maybe
   # it'll all fit in 1024 bytes for Cactid and Spine's benefit.  This list must
   # come right after the word MAGIC_VARS_DEFINITIONS.  The Perl script parses
   # it and uses it as a Perl variable.
   $keys = array(
       'Key_read_requests'          => 'a0',
       'Key_reads'                  => 'a1',
       'Key_write_requests'         => 'a2',
       'Key_writes'                 => 'a3',
       'history_list'               => 'a4',
       'innodb_transactions'        => 'a5',
       'read_views'                 => 'a6',
       'current_transactions'       => 'a7',
       'locked_transactions'        => 'a8',
       'active_transactions'        => 'a9',
       'pool_size'                  => 'aa',
       'free_pages'                 => 'ab',
       'database_pages'             => 'ac',
       'modified_pages'             => 'ad',
       'pages_read'                 => 'ae',
       'pages_created'              => 'af',
       'pages_written'              => 'ag',
       'file_fsyncs'                => 'ah',
       'file_reads'                 => 'ai',
       'file_writes'                => 'aj',
       'log_writes'                 => 'ak',
       'pending_aio_log_ios'        => 'al',
       'pending_aio_sync_ios'       => 'am',
       'pending_buf_pool_flushes'   => 'an',
       'pending_chkp_writes'        => 'ao',
       'pending_ibuf_aio_reads'     => 'ap',
       'pending_log_flushes'        => 'aq',
       'pending_log_writes'         => 'ar',
       'pending_normal_aio_reads'   => 'as',
       'pending_normal_aio_writes'  => 'at',
       'ibuf_inserts'               => 'au',
       'ibuf_merged'                => 'av',
       'ibuf_merges'                => 'aw',
       'spin_waits'                 => 'ax',
       'spin_rounds'                => 'ay',
       'os_waits'                   => 'az',
       'rows_inserted'              => 'b0',
       'rows_updated'               => 'b1',
       'rows_deleted'               => 'b2',
       'rows_read'                  => 'b3',
       'Table_locks_waited'         => 'b4',
       'Table_locks_immediate'      => 'b5',
       'Slow_queries'               => 'b6',
       'Open_files'                 => 'b7',
       'Open_tables'                => 'b8',
       'Opened_tables'              => 'b9',
       'innodb_open_files'          => 'ba',
       'open_files_limit'           => 'bb',
       'table_cache'                => 'bc',
       'Aborted_clients'            => 'bd',
       'Aborted_connects'           => 'be',
       'Max_used_connections'       => 'bf',
       'Slow_launch_threads'        => 'bg',
       'Threads_cached'             => 'bh',
       'Threads_connected'          => 'bi',
       'Threads_created'            => 'bj',
       'Threads_running'            => 'bk',
       'max_connections'            => 'bl',
       'thread_cache_size'          => 'bm',
       'Connections'                => 'bn',
       'slave_running'              => 'bo',
       'slave_stopped'              => 'bp',
       'Slave_retried_transactions' => 'bq',
       'slave_lag'                  => 'br',
       'Slave_open_temp_tables'     => 'bs',
       'Qcache_free_blocks'         => 'bt',
       'Qcache_free_memory'         => 'bu',
       'Qcache_hits'                => 'bv',
       'Qcache_inserts'             => 'bw',
       'Qcache_lowmem_prunes'       => 'bx',
       'Qcache_not_cached'          => 'by',
       'Qcache_queries_in_cache'    => 'bz',
       'Qcache_total_blocks'        => 'c0',
       'query_cache_size'           => 'c1',
       'Questions'                  => 'c2',
       'Com_update'                 => 'c3',
       'Com_insert'                 => 'c4',
       'Com_select'                 => 'c5',
       'Com_delete'                 => 'c6',
       'Com_replace'                => 'c7',
       'Com_load'                   => 'c8',
       'Com_update_multi'           => 'c9',
       'Com_insert_select'          => 'ca',
       'Com_delete_multi'           => 'cb',
       'Com_replace_select'         => 'cc',
       'Select_full_join'           => 'cd',
       'Select_full_range_join'     => 'ce',
       'Select_range'               => 'cf',
       'Select_range_check'         => 'cg',
       'Select_scan'                => 'ch',
       'Sort_merge_passes'          => 'ci',
       'Sort_range'                 => 'cj',
       'Sort_rows'                  => 'ck',
       'Sort_scan'                  => 'cl',
       'Created_tmp_tables'         => 'cm',
       'Created_tmp_disk_tables'    => 'cn',
       'Created_tmp_files'          => 'co',
       'Bytes_sent'                 => 'cp',
       'Bytes_received'             => 'cq',
       'innodb_log_buffer_size'     => 'cr',
       'unflushed_log'              => 'cs',
       'log_bytes_flushed'          => 'ct',
       'log_bytes_written'          => 'cu',
       'relay_log_space'            => 'cv',
       'binlog_cache_size'          => 'cw',
       'Binlog_cache_disk_use'      => 'cx',
       'Binlog_cache_use'           => 'cy',
       'binary_log_space'           => 'cz',
       'innodb_locked_tables'       => 'd0',
       'innodb_lock_structs'        => 'd1',
       'State_closing_tables'       => 'd2',
       'State_copying_to_tmp_table' => 'd3',
       'State_end'                  => 'd4',
       'State_freeing_items'        => 'd5',
       'State_init'                 => 'd6',
       'State_locked'               => 'd7',
       'State_login'                => 'd8',
       'State_preparing'            => 'd9',
       'State_reading_from_net'     => 'da',
       'State_sending_data'         => 'db',
       'State_sorting_result'       => 'dc',
       'State_statistics'           => 'dd',
       'State_updating'             => 'de',
       'State_writing_to_net'       => 'df',
       'State_none'                 => 'dg',
       'State_other'                => 'dh',
       'Handler_commit'             => 'di',
       'Handler_delete'             => 'dj',
       'Handler_discover'           => 'dk',
       'Handler_prepare'            => 'dl',
       'Handler_read_first'         => 'dm',
       'Handler_read_key'           => 'dn',
       'Handler_read_next'          => 'do',
       'Handler_read_prev'          => 'dp',
       'Handler_read_rnd'           => 'dq',
       'Handler_read_rnd_next'      => 'dr',
       'Handler_rollback'           => 'ds',
       'Handler_savepoint'          => 'dt',
       'Handler_savepoint_rollback' => 'du',
       'Handler_update'             => 'dv',
       'Handler_write'              => 'dw',
   );

   # Return the output.
   $output = array();
   foreach ($keys as $key => $short ) {
      # If the value isn't defined, return -1 which is lower than (most graphs')
      # minimum value of 0, so it'll be regarded as a missing value.
      $val      = isset($status[$key]) ? $status[$key] : -1;
      $output[] = "$short:$val";
   }
   $result = implode(' ', $output);
   if ( $fp ) {
      if ( fwrite($fp, $result) === FALSE ) {
         die("Can't write '$cache_file'");
      }
      fclose($fp);
      run_query("SELECT RELEASE_LOCK('cacti_monitoring')", $conn);
   }
   return $result;
}

# ============================================================================
# Given INNODB STATUS text, returns a key-value array of the parsed text.  Each
# line shows a sample of the input for both standard InnoDB as you would find in
# MySQL 5.0, and XtraDB or enhanced InnoDB from Percona if applicable.
# ============================================================================
function get_innodb_array($text) {
   $results  = array();
   $txn_seen = FALSE;
   foreach ( explode("\n", $text) as $line ) {
      $row = explode(' ', $line);

      # SEMAPHORES
      if (strpos($line, 'Mutex spin waits') !== FALSE ) {
         # Mutex spin waits 79626940, rounds 157459864, OS waits 698719
         # Mutex spin waits 0, rounds 247280272495, OS waits 316513438
         $results['spin_waits'][]  = tonum($row[3]);
         $results['spin_rounds'][] = tonum($row[5]);
         $results['os_waits'][]    = tonum($row[8]);
      }
      elseif (strpos($line, 'RW-shared spins') !== FALSE ) {
         # RW-shared spins 3859028, OS waits 2100750; RW-excl spins 4641946, OS waits 1530310
         $results['spin_waits'][] = tonum($row[2]);
         $results['spin_waits'][] = tonum($row[8]);
         $results['os_waits'][]   = tonum($row[5]);
         $results['os_waits'][]   = tonum($row[11]);
      }

      # TRANSACTIONS
      elseif ( strpos($line, 'Trx id counter') !== FALSE ) {
         # The beginning of the TRANSACTIONS section: start counting
         # transactions
         # Trx id counter 0 1170664159
         # Trx id counter 861B144C
         $results['innodb_transactions'] = make_bigint($row[3], $row[4]);
         $txn_seen = TRUE;
      }
      elseif ( strpos($line, 'Purge done for trx') !== FALSE ) {
         # Purge done for trx's n:o < 0 1170663853 undo n:o < 0 0
         # Purge done for trx's n:o < 861B135D undo n:o < 0
         $purged_to = make_bigint(
            $row[7]=='undo' ? tonum($row[6]) : array($row[6], $row[7]));
         $results['unpurged_txns']
            = big_sub($results['innodb_transactions'], $purged_to);
      }
      elseif (strpos($line, 'History list length') !== FALSE ) {
         # History list length 132
         $results['history_list'] = tonum($row[3]);
      }
      elseif ( $txn_seen && strpos($line, '---TRANSACTION') !== FALSE ) {
         # ---TRANSACTION 0, not started, process no 13510, OS thread id 1170446656
         increment($results, 'current_transactions', 1);
         if ( strpos($line, 'ACTIVE') !== FALSE  ) {
            increment($results, 'active_transactions', 1);
         }
      }
      elseif ( $txn_seen && strpos($line, 'LOCK WAIT') !== FALSE  ) {
         # LOCK WAIT 2 lock struct(s), heap size 368
         increment($results, 'locked_transactions', 1);
      }
      elseif ( strpos($line, 'read views open inside') !== FALSE ) {
         # 1 read views open inside InnoDB
         $results['read_views'] = tonum($row[0]);
      }
      elseif ( strpos($line, 'mysql tables in use') !== FALSE  ) {
         # mysql tables in use 2, locked 2
         increment($results, 'innodb_locked_tables', tonum($row[6]));
      }
      elseif ( strpos($line, 'lock struct(s)') !== FALSE ) {
         # 23 lock struct(s), heap size 3024, undo log entries 27
         increment($results, 'innodb_lock_structs', tonum($row[0]));
      }

      # FILE I/O
      elseif (strpos($line, 'OS file reads') !== FALSE ) {
         # 8782182 OS file reads, 15635445 OS file writes, 947800 OS fsyncs
         $results['file_reads']  = tonum($row[0]);
         $results['file_writes'] = tonum($row[4]);
         $results['file_fsyncs'] = tonum($row[8]);
      }
      elseif (strpos($line, 'Pending normal aio') !== FALSE ) {
         # Pending normal aio reads: 0, aio writes: 0,
         $results['pending_normal_aio_reads']  = tonum($row[4]);
         $results['pending_normal_aio_writes'] = tonum($row[7]);
      }
      elseif (strpos($line, 'ibuf aio reads') !== FALSE ) {
         # ibuf aio reads: 0, log i/o's: 0, sync i/o's: 0
         $results['pending_ibuf_aio_reads'] = tonum($row[4]);
         $results['pending_aio_log_ios']    = tonum($row[7]);
         $results['pending_aio_sync_ios']   = tonum($row[10]);
      }
      elseif ( strpos($line, 'Pending flushes (fsync)') !== FALSE ) {
         # Pending flushes (fsync) log: 0; buffer pool: 0
         $results['pending_log_flushes']      = tonum($row[4]);
         $results['pending_buf_pool_flushes'] = tonum($row[7]);
      }

      # INSERT BUFFER AND ADAPTIVE HASH INDEX
      elseif (strpos($line, 'merged recs') !== FALSE ) {
         # 19817685 inserts, 19817684 merged recs, 3552620 merges
         $results['ibuf_inserts'] = tonum($row[0]);
         $results['ibuf_merged']  = tonum($row[2]);
         $results['ibuf_merges']  = tonum($row[5]);
      }

      # LOG
      elseif (strpos($line, "log i/o's done") !== FALSE ) {
         # 3430041 log i/o's done, 17.44 log i/o's/second
         # 520835887 log i/o's done, 17.28 log i/o's/second, 518724686 syncs, 2980893 checkpoints
         # TODO: graph syncs and checkpoints
         $results['log_writes'] = tonum($row[0]);
      }
      elseif (strpos($line, "pending log writes") !== FALSE ) {
         # 0 pending log writes, 0 pending chkp writes
         $results['pending_log_writes']  = tonum($row[0]);
         $results['pending_chkp_writes'] = tonum($row[4]);
      }
      elseif (strpos($line, "Log sequence number") !== FALSE ) {
         # Log sequence number 13093949495856
         # Log sequence number 125 3934414864
         $results['innodb_lsn']
            = isset($row[4]) ? make_bigint($row[3], $row[4])
            : tonum($row[3]);
      }
      elseif (strpos($line, "Log flushed up to") !== FALSE ) {
         # Log flushed up to   13093948219327
         # Log flushed up to   125 3934414864
         $results['flushed_to']
            = isset($row[7]) ? make_bigint($row[6], $row[7])
            : tonum($row[6]);
      }

      # BUFFER POOL AND MEMORY
      elseif (strpos($line, "Buffer pool size ") !== FALSE ) {
         # The " " after size is necessary to avoid matching the wrong line:
         # Buffer pool size        1769471
         # Buffer pool size, bytes 28991012864
         $results['pool_size'] = isset($row[10]) ? tonum($row[10]) : tonum($row[5]);
      }
      elseif (strpos($line, "Free buffers") !== FALSE ) {
         # Free buffers            0
         $results['free_pages'] = tonum($row[2]);
      }
      elseif (strpos($line, "Database pages") !== FALSE ) {
         # Database pages          1696503
         $results['database_pages'] = tonum($row[2]);
      }
      elseif (strpos($line, "Modified db pages") !== FALSE ) {
         # Modified db pages       160602
         $results['modified_pages'] = tonum($row[4]);
      }
      elseif (strpos($line, "Pages read") !== FALSE  ) {
         # Pages read 15240822, created 1770238, written 21705836
         $results['pages_read']    = tonum($row[2]);
         $results['pages_created'] = tonum($row[4]);
         $results['pages_written'] = tonum($row[6]);
      }

      # ROW OPERATIONS
      elseif (strpos($line, 'Number of rows inserted') !== FALSE ) {
         # Number of rows inserted 50678311, updated 66425915, deleted 20605903, read 454561562
         $results['rows_inserted'] = tonum($row[4]);
         $results['rows_updated']  = tonum($row[6]);
         $results['rows_deleted']  = tonum($row[8]);
         $results['rows_read']     = tonum($row[10]);
      }
      elseif (strpos($line, "queries inside InnoDB") !== FALSE ) {
         # 0 queries inside InnoDB, 0 queries in queue
         $results['queries_inside'] = tonum($row[0]);
         $results['queries_queued'] = tonum($row[4]);
      }
   }

   foreach ( array('spin_waits', 'spin_rounds', 'os_waits') as $key ) {
      $results[$key] = sprintf('%u', array_sum($results[$key]));
   }
   return $results;
}

# ============================================================================
# Returns a bigint from two ulint or a single hex number.
# ============================================================================
function make_bigint ($hi, $lo) {
   if ( is_null($hi) ) {
      # Assume it is a hex string representation.
      return base_convert($hi, 16, 10);
   }
   else {
      $hi = $hi ? $hi : '0'; # Handle empty-string or whatnot
      $lo = $lo ? $lo : '0';
      return big_add(big_multiply($hi, 4294967296), $lo);
}

# ============================================================================
# Extracts the numbers from a string.  You can't reliably do this by casting to
# an int, because numbers that are bigger than PHP's int (varies by platform)
# will be truncated.  So this just handles them as a string instead.  Note that
# all bigint math is done by sending values in a query to MySQL!  :-)
# ============================================================================
function tonum ( $str ) {
   global $debug;
   preg_match('{(\d+)}', $str, $m); 
   if ( isset($m[1]) ) {
      return $m[1];
   }
   elseif ( $debug ) {
      print_r(debug_backtrace());
   }
   else {
      return 0;
   }
}

# ============================================================================
# Wrap mysql_query in error-handling
# ============================================================================
function run_query($sql, $conn) {
   global $debug;
   $result = @mysql_query($sql, $conn);
   if ( $debug ) {
      $error = @mysql_error($conn);
      if ( $error ) {
         die("SQL Error $error in $sql");
      }
   }
   return $result;
}

# ============================================================================
# Safely increments a value that might be null.
# ============================================================================
function increment(&$arr, $key, $howmuch) {
   if ( array_key_exists($key, $arr) && isset($arr[$key]) ) {
      $arr[$key] = big_add($arr[$key], $howmuch);
   }
   else {
      $arr[$key] = $howmuch;
   }
}

# ============================================================================
# Multiply two big integers together as accurately as possible with reasonable
# effort.
# ============================================================================
function big_multiply ($left, $right) {
   if ( function_exists("gmp_mul") ) {
      return gmp_strval( gmp_mul( $left, $right ));
   }
   elseif ( function_exists("bcmul") ) {
      return bcmul( $left, $right );
   }
   else {
      return sprintf('%u', $left * $right);
   }
}

# ============================================================================
# Subtract two big integers as accurately as possible with reasonable effort.
# ============================================================================
function big_sub ($left, $right) {
   if ( is_null($left)  ) { $left = 0; }
   if ( is_null($right) ) { $right = 0; }
   if ( function_exists("gmp_sub") ) {
      return gmp_strval( gmp_sub( $left, $right ));
   }
   elseif ( function_exists("bcsub") ) {
      return bcsub( $left, $right );
   }
   else {
      return sprintf('%u', $left - $right);
   }
}

# ============================================================================
# Add two big integers together as accurately as possible with reasonable
# effort.
# ============================================================================
function big_add ($left, $right) {
   if ( is_null($left)  ) { $left = 0; }
   if ( is_null($right) ) { $right = 0; }
   if ( function_exists("gmp_add") ) {
      return gmp_strval( gmp_add( $left, $right ));
   }
   elseif ( function_exists("bcadd") ) {
      return bcadd( $left, $right );
   }
   else {
      return sprintf('%u', $left + $right);
   }
}

?>
