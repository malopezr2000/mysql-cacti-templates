<?php

# ============================================================================
# Define MySQL connection constants in config.php.  Arguments explicitly passed
# will override these.
# ============================================================================
$mysql_user = 'cacti';
$mysql_pass = 'cacti';
$heartbeat  = ''; # db.tbl in case you use mk-heartbeat from Maatkit.
# ============================================================================
# You should not need to change anything below this line.
# ============================================================================

# ============================================================================
# Define whether you want debugging behavior.
# ============================================================================
$debug = false;
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
include_once(dirname(__FILE__) . "/../include/config.php");
include_once(dirname(__FILE__) . "/../lib/snmp.php");

# ============================================================================
# Make sure we can also be called as a script.
# ============================================================================
if (!isset($called_by_script_server)) {
   array_shift($_SERVER["argv"]);
   $result = call_user_func_array("ss_get_mysql_stats", $_SERVER["argv"]);
   if ( !$debug ) {
      # Throw away the buffer, which ought to contain only errors.
      ob_end_clean();
   }
   else {
      ob_end_flush(); # In debugging mode, print out the errors.
   }
   print($result);
}

# ============================================================================
# This is the main function.  Only the $host parameter must be specified.
# Others are filled in from defaults at the top of this file.  If you want to
# specify a port, you must include it in the hostname, like "localhost:3306".
# ============================================================================
function ss_get_mysql_stats( $host, $user = null, $pass = null, $hb_table = null ) {

   # Process connection options and connect to MySQL.
   global $mysql_user, $mysql_pass, $heartbeat;
   $user = isset($user) ? $user : $mysql_user;
   $pass = isset($pass) ? $pass : $mysql_pass;
   $hb_table = isset($hb_table) ? $hb_table : $heartbeat;
   $conn = @mysql_connect($host, $user, $pass);
   if ( !$conn ) {
      die("Can't connect to MySQL: " . mysql_error());
   }

   # Set up variables.
   $status = array( # Holds the result of SHOW STATUS, SHOW INNODB STATUS, etc
      # Define some indexes so they don't cause errors with += operations.
      'transactions'          => 0,
      'relay_log_space'       => 0,
      'binary_log_space'      => 0,
      'current_transactions'  => 0,
      'locked_transactions'   => 0,
      'active_transactions'   => 0,
   );

   # Get SHOW SLAVE STATUS.
   $result = run_query("SHOW SLAVE STATUS", $conn);
   while ($row = @mysql_fetch_assoc($result)) {
      # Must lowercase keys because different versions have different
      # lettercase.
      $row = array_change_key_case($row, CASE_LOWER);
      $status['relay_log_space']       = $row['relay_log_space'];
      $status['seconds_behind_master'] = $row['seconds_behind_master'];
      $status['slave_running'] = ($row['slave_sql_running'] == 'Yes') ? 10 : 0;
      $status['slave_stopped'] = ($row['slave_sql_running'] == 'Yes') ?  0 : 10;
   }

   # Get info on master logs.
   $binlogs = array(0);
   $result = run_query("SHOW MASTER LOGS", $conn);
   while ($row = @mysql_fetch_assoc($result)) {
      $row = array_change_key_case($row, CASE_LOWER);
      $binlogs[] = $row['file_size'];
   }

   # Check replication heartbeat
   if ( $hb_table ) {
      $result = run_query(
         "SELECT GREATEST(0, UNIX_TIMESTAMP() - UNIX_TIMESTAMP(ts) - 1)"
         . "FROM $hb_table WHERE id = 1", $conn);
      $row = @mysql_fetch_row($result);
      $status['slave_lag'] = $row[0];
   }

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

   # TODO: add data to support percentages:
   # MyISAM key cache hit rate
   # InnoDB buffer pool hit rate
   # InnoDB adaptive hash index hit rate
   # Binlog cache hit rate
   # Query cache free blocks/total blocks
   # TODO: calculate relay log position lag

   # Get SHOW INNODB STATUS and extract the desired metrics from it.
   $result        = run_query("SHOW /*!50000 ENGINE*/ INNODB STATUS", $conn);
   $innodb_array  = @mysql_fetch_assoc($result);
   $innodb_txn    = false;
   $flushed_to    = false;
   $innodb_lsn    = false;
   $innodb_prg    = false;
   $spin_waits    = array();
   $spin_rounds   = array();
   $os_waits      = array();
   foreach ( explode("\n", $innodb_array['Status']) as $line ) {
      $row = explode(' ', $line);

      # SEMAPHORES
      if (strstr($line, 'Mutex spin waits')) {
         $spin_waits[]  = tonum($row[3]);
         $spin_rounds[] = tonum($row[5]);
         $os_waits[]    = tonum($row[8]);
      }
      elseif (strstr($line, 'RW-shared spins')) {
         $spin_waits[] = tonum($row[2]);
         $spin_waits[] = tonum($row[8]);
         $os_waits[]   = tonum($row[5]);
         $os_waits[]   = tonum($row[11]);
      }

      # TRANSACTIONS
      # TODO: mysql tables in use 4, locked 4
      # TODO: 16 lock struct(s), heap size 3024, undo log entries 1018
      elseif ( strstr($line, 'Trx id counter')) {
         # The beginning of the TRANSACTIONS section: start counting
         # transactions
         $innodb_txn = array($row[3], $row[4]);
      }
      elseif (strstr($line, 'Purge done for trx')) {
         # PHP can't do big math, so I send it to MySQL.
         $innodb_prg = array($row[6], $row[7]);
      }
      elseif (strstr($line, 'History list length')) {
         $status['history_list'] = tonum($row[3]);
      }
      elseif ( $innodb_txn && strstr($line, '---TRANSACTION')) {
         $status['current_transactions'] += 1;
         if ( strstr($line, 'ACTIVE') ) {
            $status['active_transactions'] += 1;
         }
      }
      elseif ( $innodb_txn && strstr($line, 'LOCK WAIT') ) {
         $status['locked_transactions'] += 1;
      }
      elseif ( strstr($line, 'read views open inside')) {
         $status['read_views'] = tonum($row[0]);
      }

      # FILE I/O
      elseif (strstr($line, 'OS file reads')) {
         $status['file_reads']  = tonum($row[0]);
         $status['file_writes'] = tonum($row[4]);
         $status['file_fsyncs'] = tonum($row[8]);
      }
      elseif (strstr($line, 'Pending normal aio')) {
         $status['pending_normal_aio_reads']  = tonum($row[4]);
         $status['pending_normal_aio_writes'] = tonum($row[7]);
      }
      elseif (strstr($line, 'ibuf aio reads')) {
         $status['pending_ibuf_aio_reads'] = tonum($row[4]);
         $status['pending_aio_log_ios']    = tonum($row[7]);
         $status['pending_aio_sync_ios']   = tonum($row[10]);
      }
      elseif (strstr($line, 'Pending flushes (fsync)')) {
         $status['pending_log_flushes']      = tonum($row[4]);
         $status['pending_buf_pool_flushes'] = tonum($row[7]);
      }

      # INSERT BUFFER AND ADAPTIVE HASH INDEX
      elseif (strstr($line, 'merged recs')) {
         $status['ibuf_inserts'] = tonum($row[0]);
         $status['ibuf_merged']  = tonum($row[2]);
         $status['ibuf_merges']  = tonum($row[5]);
      }

      # LOG
      elseif (strstr($line, "log i/o's done")) {
         $status['log_writes'] = tonum($row[0]);
      }
      elseif (strstr($line, "pending log writes")) {
         $status['pending_log_writes']  = tonum($row[0]);
         $status['pending_chkp_writes'] = tonum($row[4]);
      }
      elseif (strstr($line, "Log sequence number")) {
         $innodb_lsn = array($row[3], $row[4]);
      }
      elseif (strstr($line, "Log flushed up to")) {
         # Since PHP can't handle 64-bit numbers, we'll ask MySQL to do it for
         # us instead.  And we get it to cast them to strings, too.
         $flushed_to = array($row[6], $row[7]);
      }

      # BUFFER POOL AND MEMORY
      elseif (strstr($line, "Buffer pool size")) {
          $status['pool_size'] = tonum($row[5]);
      }
      elseif (strstr($line, "Free buffers")) {
          $status['free_pages'] = tonum($row[8]);
      }
      elseif (strstr($line, "Database pages")) {
          $status['database_pages'] = tonum($row[6]);
      }
      elseif (strstr($line, "Modified db pages")) {
          $status['modified_pages'] = tonum($row[4]);
      }
      elseif (strstr($line, "Pages read") ) {
          $status['pages_read']    = tonum($row[2]);
          $status['pages_created'] = tonum($row[4]);
          $status['pages_written'] = tonum($row[6]);
      }

      # ROW OPERATIONS
      elseif (strstr($line, 'Number of rows inserted')) {
         $status['rows_inserted'] = tonum($row[4]);
         $status['rows_updated']  = tonum($row[6]);
         $status['rows_deleted']  = tonum($row[8]);
         $status['rows_read']     = tonum($row[10]);
      }
      elseif (strstr($line, "queries inside InnoDB")) {
          $status['queries_inside'] = tonum($row[0]);
          $status['queries_queued']  = tonum($row[4]);
      }
   }

   # Derive some values from other values.

   # if ( $status['Qcache_total_blocks'] ) 
      # Hmmm, not sure what I want to do with this... TODO
      # $status['Qcache_frag_bytes']
         # = $status['Qcache_free_blocks'] / $status['Qcache_total_blocks']
         # * $status['query_cache_size'];


   # PHP sucks at bigint math, so we use MySQL to calculate things that are
   # too big for it.
   if ( $innodb_txn ) {
      $txn = make_bigint_sql($innodb_txn[0], $innodb_txn[1]);
      $lsn = make_bigint_sql($innodb_lsn[0], $innodb_lsn[1]);
      $flu = make_bigint_sql($flushed_to[0], $flushed_to[1]);
      $prg = make_bigint_sql($innodb_prg[0], $innodb_prg[1]);
      $sql = "SELECT CONCAT('', $txn) AS innodb_transactions, "
           . "CONCAT('', ($txn - $prg)) AS unpurged_txns, "
           . "CONCAT('', $lsn) AS log_bytes_written, "
           . "CONCAT('', $flu) AS log_bytes_flushed, "
           . "CONCAT('', ($lsn - $flu)) AS unflushed_log, "
           . "CONCAT('', " . implode('+', $spin_waits) . ") AS spin_waits, "
           . "CONCAT('', " . implode('+', $spin_rounds) . ") AS spin_rounds, "
           . "CONCAT('', " . implode('+', $os_waits) . ") AS os_waits";
      # echo("$sql\n");
      $result = run_query($sql, $conn);
      while ( $row = @mysql_fetch_assoc($result) ) {
         foreach ( $row as $key => $val ) {
            $status[$key] = $val;
         }
      }
   }
   if (true) {
      $sql = "SELECT "
           . "CONCAT('', " . implode('+', $binlogs) . ") AS binary_log_space ";
      # echo("$sql\n");
      $result = run_query($sql, $conn);
      while ( $row = @mysql_fetch_assoc($result) ) {
         foreach ( $row as $key => $val ) {
            $status[$key] = $val;
         }
      }
   }

   # Pre-crunch.  RRDTool only lets me divide by 1024.
   $status['relay_log_space']  /= (1024 * 1024); # MB
   $status['binary_log_space'] /= (1024 * 1024); # MB

   # Define the variables to output for each graph.
   $keys = array(
      # MyISAM index usage
      'Key_read_requests', 'Key_reads', 'Key_write_requests', 'Key_writes',
      # InnoDB Transactions
      # 'unpurged_txns', 'transaction_time', 'transaction_lock_time', 
      'history_list', 'innodb_transactions', 'read_views',
      'current_transactions', 'locked_transactions', 'active_transactions',
      # InnoDB buffer pool
      'pool_size', 'free_pages', 'database_pages', 'modified_pages',
      'pages_read', 'pages_created', 'pages_written',
      # InnoDB I/O
      'file_fsyncs', 'file_reads', 'file_writes', 'log_writes',
      # InnoDB I/O Pending
      'pending_aio_log_ios', 'pending_aio_sync_ios', 'pending_buf_pool_flushes',
      'pending_chkp_writes', 'pending_ibuf_aio_reads', 'pending_log_flushes',
      'pending_log_writes', 'pending_normal_aio_reads',
      'pending_normal_aio_writes',
      # InnoDB Insert Buffer
      'ibuf_inserts', 'ibuf_merged', 'ibuf_merges',
      # InnoDB Semaphores
      'spin_waits', 'spin_rounds', 'os_waits',
      # InnoDB Row Operations
      'rows_inserted', 'rows_updated', 'rows_deleted', 'rows_read',
      # Table locks and slow queries
      'Table_locks_waited', 'Table_locks_immediate', 'Slow_queries',
      # Files and tables
      'Open_files', 'Open_tables', 'Opened_tables',
      'innodb_open_files', 'open_files_limit', 'table_cache',
      # Connections
      'Aborted_clients', 'Aborted_connects', 'Max_used_connections',
      'Slow_launch_threads', 'Threads_cached', 'Threads_connected',
      'Threads_created', 'Threads_running', 'max_connections',
      'thread_cache_size', 'Connections',
      # Slave status
      'slave_running', 'slave_stopped', 'Slave_retried_transactions',
      'seconds_behind_master', 'slave_lag', 'Slave_open_temp_tables',
      # Query Cache
      'Qcache_free_blocks', 'Qcache_free_memory', 'Qcache_hits',
      'Qcache_inserts', 'Qcache_lowmem_prunes', 'Qcache_not_cached',
      'Qcache_queries_in_cache', 'Qcache_total_blocks', 'query_cache_size',
      # General Com_ stats
      'Questions', 'Com_update', 'Com_insert', 'Com_select', 'Com_delete',
      'Com_replace', 'Com_load', 'Com_update_multi', 'Com_insert_select',
      'Com_delete_multi', 'Com_replace_select',
      # Select types
      'Select_full_join', 'Select_full_range_join', 'Select_range',
      'Select_range_check', 'Select_scan',
      # Sorts
      'Sort_merge_passes', 'Sort_range', 'Sort_rows', 'Sort_scan',
      # Temporary objects
      'Created_tmp_tables', 'Created_tmp_disk_tables', 'Created_tmp_files',
      # Network traffic
      'Bytes_sent', 'Bytes_received',
      # InnoDB Log Buffer
      'innodb_log_buffer_size', 'unflushed_log', 'log_bytes_flushed',
      'log_bytes_written',
      # Binlog / Relay Log
      'relay_log_space', 'binlog_cache_size', 'Binlog_cache_disk_use',
      'Binlog_cache_use', 'binary_log_space',
   );

   # Return the output.
   $output = array();
   foreach ($keys as $key) {
      $val      = isset($status[$key]) ? $status[$key] : 0;
      $output[] = "$key:$val";
   }
   return implode(' ', $output);
}

# ============================================================================
# Returns SQL to create a bigint from two ulint
# ============================================================================
function make_bigint_sql ($hi, $lo) {
   return "(($hi << 32) + $lo)";
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
         die("Error executing '$sql': $error");
      }
   }
   return $result;
}

?>
