<?php

# ============================================================================
# This is a script to retrieve information over SSH for a Cacti graphing
# process.
#
# This program is copyright (c) 2008 Baron Schwartz. Feedback and improvements
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
# To make this code testable, we need to prevent code from running when it is
# included from the test script.  The test script and this file have different
# filenames, so we can compare them.  In some cases $_SERVER['SCRIPT_FILENAME']
# seems not to be defined, so we skip the check -- this check should certainly
# pass in the test environment.
# ============================================================================
if ( !array_key_exists('SCRIPT_FILENAME', $_SERVER)
   || basename(__FILE__) == basename($_SERVER['SCRIPT_FILENAME']) ) {

# ============================================================================
# CONFIGURATION
# ============================================================================
# Define parameters.  Instead of defining parameters here, you can define them
# in another file named the same as this file, with a .cnf extension.
# ============================================================================
$ssh_user   = 'cacti';                          # SSH username
$ssh_port   = 22;                               # SSH port
$ssh_iden   = '-i /var/www/cacti/.ssh/id_rsa';  # SSH identity
$ssh_tout   = 10;                               # SSH connect timeout
$cache_dir  = '';  # If set, this uses caching to avoid multiple calls.
$poll_time  = 300; # Adjust to match your polling interval.
$use_ss     = FALSE; # Whether to use the script server or not

# Parameters for specific graphs are possible to specify here, or in the .cnf
# file.
$status_server = 'localhost';             # Which server to query
$status_url    = '/server-status';        # Where Apache status lives
$http_user     = '';
$http_pass     = '';
$memcache_port = 11211;                   # Which port memcached listens on

# ============================================================================
# You should not need to change anything below this line.
# ============================================================================
$version = '1.1.5';

# ============================================================================
# Include settings from an external config file (issue 39).
# ============================================================================
if ( file_exists(__FILE__ . '.cnf' ) ) {
   require(__FILE__ . '.cnf');
}

# ============================================================================
# Define whether you want debugging behavior.
# ============================================================================
$debug = TRUE;
# If $debug_log is a filename, debugging info will be logged to it.
$debug_log = '/tmp/debug.log';
error_reporting($debug ? E_ALL : E_ERROR);

# Make this a happy little script even when there are errors.
$no_http_headers = true;
ini_set('implicit_flush', false); # No output, ever.
ob_start(); # Catch all output such as notices of undefined array indexes.
function error_handler($errno, $errstr, $errfile, $errline) {
   print("$errstr at $errfile line $errline\n");
   debug("$errstr at $errfile line $errline");
}
# ============================================================================
# Set up the stuff we need to be called by the script server.
# ============================================================================
if ( $use_ss ) {
   if ( file_exists( dirname(__FILE__) . "/../include/global.php") ) {
      # See issue 5 for the reasoning behind this.
      debug("including " . dirname(__FILE__) . "/../include/global.php");
      include_once(dirname(__FILE__) . "/../include/global.php");
   }
   elseif ( file_exists( dirname(__FILE__) . "/../include/config.php" ) ) {
      # Some Cacti installations don't have global.php.
      debug("including " . dirname(__FILE__) . "/../include/config.php");
      include_once(dirname(__FILE__) . "/../include/config.php");
   }
}

# ============================================================================
# Make sure we can also be called as a script.
# ============================================================================
if (!isset($called_by_script_server)) {
   debug($_SERVER["argv"]);
   array_shift($_SERVER["argv"]); # Strip off this script's filename
   $options = parse_cmdline($_SERVER["argv"]);
   validate_options($options);
   $result = ss_get_by_ssh($options);
   debug($result);
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
   debug(array("Final result", $output));
   print(implode(' ', $output));
}

# ============================================================================
# End "if file was not included" section.
# ============================================================================
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
# TODO: --ident
# ============================================================================
function validate_options($options) {
   debug($options);
   $opts = array('host', 'port', 'items', 'nocache', 'type', 'url', 'http-user',
                 'http-password', 'server', 'port2');
   # Required command-line options
   foreach ( array('host', 'items', 'type') as $option ) {
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
# TODO: add http port, and make user/pass/port/server generic for all types
# ============================================================================
function usage($message) {
   $usage = <<<EOF
$message
Usage: php ss_get_by_ssh.php --host <host> --items <item,...> [OPTION]

Command-line options ALWAYS require a value after them.  If you specify an
option without a value after it, the option is ignored.  For options such as
--nocache, you can say "--nocache 1".

General options:

   --host      Hostname to connect to (via SSH)
   --items     Comma-separated list of the items whose data you want
   --nocache   Do not cache results in a file
   --port      Port to connect to (via SSH)
   --port2     Port to connect to after SSHing, such as memcached port
   --server    The server (DNS name or IP address) from which to fetch the
               desired data after SSHing.  Default is 'localhost' for HTTP stats
               and --host for memcached stats.
   --type      One of apache, nginx, proc_stat, w, memory, memcached
               (more are TODO)
   --url       The url, such as /server-status, where server status lives
   --http-user The HTTP authentication user
   --http-password
               The HTTP authentication password

EOF;
   die($usage);
}

# ============================================================================
# Parse command-line arguments, in the format --arg value --arg value, and
# return them as an array ( arg => value )
# ============================================================================
function parse_cmdline( $args ) {
   $result = array();
   for ( $i = 0; $i < count($args); ++$i ) {
      if ( strpos($args[$i], '--') === 0 ) {
         if ( $i + 1 < count($args) && strpos($args[$i + 1], '--') !== 0 ) {
            # The next element should be the value for this option.
            $result[substr($args[$i], 2)] = $args[$i + 1];
            ++$i;
         }
      }
   }
   debug($result);
   return $result;
}

# ============================================================================
# This is the main function.  Some parameters are filled in from defaults at the
# top of this file.
# ============================================================================
function ss_get_by_ssh( $options ) {
   global $debug, $cache_dir, $poll_time;

   # TODO: generate filename via a hash.
   $cache_file = "$cache_dir/$options[host]-$options[type]_cacti_stats.txt";

   # First, check the cache. TODO: caching is disabled.
   $fp = null;
   if ( !isset($options['nocache']) && $cache_dir ) {
      if ( file_exists($cache_file) && filesize($cache_file) > 0
         && filectime($cache_file) + ($poll_time/2) > time() )
      {
         # The file is fresh enough to use.
         $arr = file($cache_file);
         # The file ought to have some contents in it!  But just in case it
         # doesn't... (see issue #6).
         if ( count($arr) ) {
            # TODO: release the lock
            return $arr[0];
         }
         else {
            if ( $debug ) {
               trigger_error("The function file($cache_file) returned nothing!\n");
            }
         }
      }
      if ( !$fp = fopen($cache_file, 'w+') ) {
         die("Cannot open file '$cache_file'");
      }
   }

   # The rest of the work is broken into three parts by a pair of functions,
   # one pair for each type of data collection, based on the --type option:
   # 1) Build a command-line string.
   #    This is done in $type_cmdline() and will often be trivially simple.
   # 2) SSH to the server and execute that command to get its output.
   #    This is common code, done in get_command_result().
   # 3) Parse the result.
   #    This is done in $type_parse().

   # Build and test the type-specific function names.
   $cmdline_func = "$options[type]_cmdline";
   $parsing_func = "$options[type]_parse";
   debug("Functions: '$cmdline_func', '$parsing_func'");
   if ( !function_exists($cmdline_func) ) {
      die("The parsing function '$cmdline_func' does not exist");
   }
   if ( !function_exists($parsing_func) ) {
      die("The parsing function '$parsing_func' does not exist");
   }

   # Get the command-line to fetch the data, then fetch and parse the data.
   $cmd = call_user_func($cmdline_func, $options);
   debug($cmd);
   $output = get_command_result($cmd, $options);
   debug($output);
   $result = call_user_func($parsing_func, $options, $output);

   # Define the variables to output.  I use shortened variable names so maybe
   # it'll all fit in 1024 bytes for Cactid and Spine's benefit.  This list must
   # come right after the word MAGIC_VARS_DEFINITIONS.  The Perl script parses
   # it and uses it as a Perl variable.
   $keys = array(
      # Apache stuff.  Don't emulate -- the naming convention here lacks a name
      # prefix, which really ought to be added to all of these.
      'Requests'               => 'a0',
      'Bytes_sent'             => 'a1',
      'Idle_workers'           => 'a2',
      'Busy_workers'           => 'a3',
      'CPU_Load'               => 'a4',
      'Waiting_for_connection' => 'a5',
      'Starting_up'            => 'a6',
      'Reading_request'        => 'a7',
      'Sending_reply'          => 'a8',
      'Keepalive'              => 'a9',
      'DNS_lookup'             => 'aa',
      'Closing_connection'     => 'ab',
      'Logging'                => 'ac',
      'Gracefully_finishing'   => 'ad',
      'Idle_cleanup'           => 'ae',
      'Open_slot'              => 'af',
      # /proc/stat stuff
      'STAT_CPU_user'          => 'ag',
      'STAT_CPU_nice'          => 'ah',
      'STAT_CPU_system'        => 'ai',
      'STAT_CPU_idle'          => 'aj',
      'STAT_CPU_iowait'        => 'ak',
      'STAT_CPU_irq'           => 'al',
      'STAT_CPU_softirq'       => 'am',
      'STAT_CPU_steal'         => 'an',
      'STAT_CPU_guest'         => 'ao',
      'STAT_interrupts'        => 'ap',
      'STAT_context_switches'  => 'aq',
      'STAT_forks'             => 'ar',
      # Stuff from 'w'
      'STAT_loadavg'           => 'as',
      'STAT_numusers'          => 'at',
      # Stuff from 'free'
      'STAT_memcached'         => 'au',
      'STAT_membuffer'         => 'av',
      'STAT_memshared'         => 'aw',
      'STAT_memfree'           => 'ax',
      'STAT_memused'           => 'ay',
      # Stuff from Nginx
      'NGINX_active_connections' => 'az',
      'NGINX_server_accepts'     => 'b0',
      'NGINX_server_handled'     => 'b1',
      'NGINX_server_requests'    => 'b2',
      'NGINX_reading'            => 'b3',
      'NGINX_writing'            => 'b4',
      'NGINX_waiting'            => 'b5',
      # Stuff from memcached
      'MEMC_rusage_user'       => 'b6',
      'MEMC_rusage_system'     => 'b7',
      'MEMC_curr_items'        => 'b8',
      'MEMC_total_items'       => 'b9',
      'MEMC_bytes'             => 'ba',
      'MEMC_curr_connections'  => 'bb',
      'MEMC_total_connections' => 'bc',
      'MEMC_cmd_get'           => 'bd',
      'MEMC_cmd_set'           => 'be',
      'MEMC_get_misses'        => 'bf',
      'MEMC_evictions'         => 'bg',
      'MEMC_bytes_read'        => 'bh',
      'MEMC_bytes_written'     => 'bi',
   );

   # Return the output.
   $output = array();
   foreach ($keys as $key => $short ) {
      # If the value isn't defined, return -1 which is lower than (most graphs')
      # minimum value of 0, so it'll be regarded as a missing value.
      $val      = isset($result[$key]) ? $result[$key] : -1;
      $output[] = "$short:$val";
   }
   $result = implode(' ', $output);
   if ( $fp ) {
      if ( fwrite($fp, $result) === FALSE ) {
         die("Cannot write to '$cache_file'");
         # TODO: then truncate file, too
      }
      fclose($fp);
   }
   return $result;
}

# ============================================================================
# Execute the command to get the output and return it.
# ============================================================================
function get_command_result($cmd, $options) {
   global $debug, $ssh_user, $ssh_port, $ssh_iden, $ssh_tout;

   # Build the SSH command line.
   $port = isset($options['port']) ? $options['port'] : $ssh_port;
   $ssh  = "ssh -q -o \"ConnectTimeout $ssh_tout\" -o \"StrictHostKeyChecking no\" "
         . "$ssh_user@$options[host] -p $port $ssh_iden";
   debug($ssh);
   $final_cmd = "$ssh '$cmd'";
   debug($final_cmd);
   $result = `$final_cmd`; # XXX this is the ssh command.
   debug($result);
   return $result;
}

# ============================================================================
# Gets and parses /proc/stat from Linux.
# Options used: none.
# You can test it like this, as root:
# su - cacti -c 'env -i php /var/www/cacti/scripts/ss_get_by_ssh.php --type proc_stat --host 127.0.0.1 --items ag,ah'
# ============================================================================
function proc_stat_cmdline ( $options ) {
   return "cat /proc/stat";
}

function proc_stat_parse ( $options, $output ) {
   $result = array(
      'STAT_interrupts'        => null,
      'STAT_context_switches'  => null,
      'STAT_forks'             => null,
   );
   $cpu_types = array(
      'STAT_CPU_user',
      'STAT_CPU_nice',
      'STAT_CPU_system',
      'STAT_CPU_idle',
      'STAT_CPU_iowait',
      'STAT_CPU_irq',
      'STAT_CPU_softirq',
      'STAT_CPU_steal',
      'STAT_CPU_guest',
   );
   foreach ( $cpu_types as $key ) {
      $result[$key] = null;
   }

   foreach ( explode("\n", $output) as $line ) {
      if ( preg_match_all('/\w+/', $line, $words) ) {
         $words = $words[0];
         if ( $words[0] == "cpu" ) {
            for ( $i = 1; $i < count($words); ++$i ) {
               $result[$cpu_types[$i - 1]] = $words[$i];
            }
         }
         elseif ( $words[0] == "intr" ) {
            $result['STAT_interrupts'] = $words[1];
         }
         elseif ( $words[0] == "ctxt" ) {
            $result['STAT_context_switches'] = $words[1];
         }
         elseif ( $words[0] == "processes" ) {
            $result['STAT_forks'] = $words[1];
         }
      }
   }
   return $result;
}

# ============================================================================
# Gets and parses the 'free' command from Linux.
# Options used: none.
# You can test it like this, as root:
# su - cacti -c 'env -i php /var/www/cacti/scripts/ss_get_by_ssh.php --type memory --host 127.0.0.1 --items au,av'
# ============================================================================
function free_cmdline ( $options ) {
   return "$cmd free -ob";
}

function free_parse ( $options, $output ) {
   $result = array(
      'STAT_memcached' => null,
      'STAT_membuffer' => null,
      'STAT_memshared' => null,
      'STAT_memfree'   => null,
      'STAT_memused'   => null,
   );

   foreach ( explode("\n", $output) as $line ) {
      if ( preg_match_all('/\S+/', $line, $words) ) {
         $words = $words[0];
         if ( $words[0] == "Mem:" ) {
            $result['STAT_memcached'] = $words[6];
            $result['STAT_membuffer'] = $words[5];
            $result['STAT_memshared'] = $words[4];
            $result['STAT_memfree']   = $words[3];
            $result['STAT_memused']   = sprintf('%.0f',
               $words[2] - $words[4] - $words[5] - $words[6]);
         }
      }
   }
   return $result;
}

# ============================================================================
# Gets and parses the results of the 'w' command from Linux.  Actually it's
# designed to get loadavg and number of users, so it uses 'uptime' instead; it
# used to use 'w' but uptime prints the same thing.
# Options used: none.
# You can test it like this, as root:
# su - cacti -c 'env -i php /var/www/cacti/scripts/ss_get_by_ssh.php --type w --host 127.0.0.1 --items as,at'
# ============================================================================
function w_cmdline ( $options ) {
   return "uptime";
}

function w_parse ( $options, $output ) {
   $result = array(
      'STAT_loadavg'        => null,
      'STAT_numusers'       => null,
   );

   foreach ( explode("\n", $output) as $line ) {
      if ( preg_match_all('/(\d+) users, .*(\d+\.\d+)$/', $line, $words) ) {
         $result['STAT_numusers'] = $words[1][0];
         $result['STAT_loadavg']  = $words[2][0];
      }
   }
   return $result;
}

# ============================================================================
# Gets and parses /server-status from Apache.
# You can test it like this, as root:
# su - cacti -c 'env -i php /var/www/cacti/scripts/ss_get_by_ssh.php --type apache --host 127.0.0.1 --items a0,a1'
# ============================================================================
function apache_cmdline ( $options ) {
   global $status_server, $status_url, $http_user, $http_pass;
   $srv = isset($options['server']) ? $options['server'] : $status_server;
   $url = isset($options['url'])    ? $options['url']    : $status_url;
   $user = isset($options['http-user'])     ? $options['http-user']     : $http_user;
   $pass = isset($options['http-password']) ? $options['http-password'] : $http_pass;
   $auth = ($user ? "--http-user=$user" : '') . ' ' . ($pass ? "--http-password=$pass" : '');
   return "wget $auth -U Cacti/1.0 -q -O - -T 5 'http://$srv$url?auto'";
}

function apache_parse ( $options, $output ) {
   $result = array(
      'Requests'     => null,
      'Bytes_sent'   => null,
      'Idle_workers' => null,
      'Busy_workers' => null,
      'CPU_Load'     => null,
      # More are added from $scoreboard below.
   );

   # Mapping from Scoreboard statuses to friendly labels
   $scoreboard = array(
      '_' => 'Waiting_for_connection',
      'S' => 'Starting_up',
      'R' => 'Reading_request',
      'W' => 'Sending_reply',
      'K' => 'Keepalive',
      'D' => 'DNS_lookup',
      'C' => 'Closing_connection',
      'L' => 'Logging',
      'G' => 'Gracefully_finishing',
      'I' => 'Idle_cleanup',
      '.' => 'Open_slot',
   );
   foreach ( $scoreboard as $key => $val ) {
      # These are not null, they are zero, when they aren't in the output.
      $result[$val] = 0;
   }

   # Mapping from line prefix to data item name
   $mapping = array (
      "Total Accesses" => 'Requests',
      "Total kBytes"   => 'Bytes_sent',
      "CPULoad"        => 'CPU_Load',
      "BusyWorkers"    => 'Busy_workers',
      "IdleWorkers"    => 'Idle_workers',
   );

   foreach ( explode("\n", $output ) as $line ) {
      $words = explode(": ", $line);
      if ( $words[0] == "Total kBytes" ) {
         $words[1] = big_multiply($words[1], 1024);
      }

      if ( array_key_exists($words[0], $mapping) ) {
         # Check for really small values indistinguishable from 0, but otherwise
         # just copy the value to the output.
         $result[$mapping[$words[0]]] = strstr($words[1], 'e') ? 0 : $words[1];
      }
      elseif ( $words[0] == "Scoreboard" ) {
         $string = $words[1];
         $length = strlen($string);
         for ( $i = 0; $i < $length ; $i++ ) {
            increment($result, $scoreboard[$string[$i]], 1);
         }
      }
   }
   return $result;
}

# ============================================================================
# Gets /server-status from Nginx.
# You can test it like this, as root:
# su - cacti -c 'env -i php /var/www/cacti/scripts/ss_get_by_ssh.php --type nginx --host 127.0.0.1 --items az,b0'
# ============================================================================
function nginx_cmdline ( $options ) {
   global $status_server, $status_url, $http_user, $http_pass;
   $srv = isset($options['server']) ? $options['server'] : $status_server;
   $url = isset($options['url'])    ? $options['url']    : $status_url;
   $user = isset($options['http-user'])     ? $options['http-user']     : $http_user;
   $pass = isset($options['http-password']) ? $options['http-password'] : $http_pass;
   $auth = ($user ? "--http-user=$user" : '') . ' ' . ($pass ? "--http-password=$pass" : '');
   return "wget $auth -U Cacti/1.0 -q -O - -T 5 'http://$srv$url?auto'";
}

function nginx_parse ( $options, $output ) {
   $result = array(
      'NGINX_active_connections' => null,
      'NGINX_server_accepts'     => null,
      'NGINX_server_handled'     => null,
      'NGINX_server_requests'    => null,
      'NGINX_reading'            => null,
      'NGINX_writing'            => null,
      'NGINX_waiting'            => null,
   );

   foreach ( explode("\n", $output) as $line ) {
      if ( preg_match_all('/\S+/', $line, $words) ) {
         $words = $words[0];
         if ( $words[0] == 'Active' ) {
            $result['NGINX_active_connections'] = $words[2];
         }
         elseif ( $words[0] == 'Reading:' ) {
            $result['NGINX_reading'] = $words[1];
            $result['NGINX_writing'] = $words[3];
            $result['NGINX_waiting'] = $words[5];
         }
         elseif ( preg_match('/^\d+$/', $words[0]) ) {
            $result['NGINX_server_accepts']  = $words[0];
            $result['NGINX_server_handled']  = $words[1];
            $result['NGINX_server_requests'] = $words[2];
         }
      }
   }
   return $result;
}

# ============================================================================
# Get and parse stats from memcached, using nc (netcat).
# You can test it like this, as root:
# su - cacti -c 'env -i php /var/www/cacti/scripts/ss_get_by_ssh.php --type memcached --host 127.0.0.1 --items b6,b7'
# ============================================================================
function memcached_cmdline ( $options ) {
   global $memcache_port;
   $srv = isset($options['server']) ? $options['server'] : $options['host'];
   $prt = isset($options['port2'])  ? $options['port2']  : $memcache_port;
   return "echo \"stats\nquit\" | nc $srv $prt";
}

function memcached_parse ( $options, $output ) {
   $result = array();
   foreach ( explode("\n", $output) as $line ) {
      $words = explode(' ', $line);
      if ( count($words) && $words[0] === "STAT" ) {
         # rusage are in microseconds, but COUNTER does not accept fractions
         if ( $words[1] === 'rusage_user' || $words[1] === 'rusage_system' ) {
            $result["MEMC_$words[1]"]
               = sprintf('%.0f', 1000000 * trim($words[2]));
         }
         else {
            $result["MEMC_$words[1]"] = trim($words[2]);
         }
      }
   }
   return $result;
}

# ============================================================================
# Extracts the numbers from a string.  You can't reliably do this by casting to
# an int, because numbers that are bigger than PHP's int (varies by platform)
# will be truncated.  So this just handles them as a string instead.
# ============================================================================
function to_int ( $str ) {
   debug($str);
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
# Extracts a float from a string.  See to_int().  This is tested in
# get_by_ssh.php.
# ============================================================================
function to_float ( $str ) {
   debug($str);
   global $debug;
   preg_match('{([0-9.]+)}', $str, $m); 
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
# Safely increments a value that might be null.
# ============================================================================
function increment(&$arr, $key, $howmuch) {
   debug(array($key, $howmuch));
   if ( array_key_exists($key, $arr) && isset($arr[$key]) ) {
      $arr[$key] = big_add($arr[$key], $howmuch);
   }
   else {
      $arr[$key] = $howmuch;
   }
}

# ============================================================================
# Multiply two big integers together as accurately as possible with reasonable
# effort.  This is tested in t/mysql_stats.php and copied, without tests, to
# ss_get_by_ssh.php.
# ============================================================================
function big_multiply ($left, $right) {
   if ( function_exists("gmp_mul") ) {
      debug(array('gmp_mul', $left, $right));
      return gmp_strval( gmp_mul( $left, $right ));
   }
   elseif ( function_exists("bcmul") ) {
      debug(array('bcmul', $left, $right));
      return bcmul( $left, $right );
   }
   else {
      debug(array('sprintf', $left, $right));
      return sprintf(".0f", $left * $right);
   }
}

# ============================================================================
# Subtract two big integers as accurately as possible with reasonable effort.
# This is tested in t/mysql_stats.php and copied, without tests, to
# ss_get_by_ssh.php.
# ============================================================================
function big_sub ($left, $right) {
   debug(array($left, $right));
   if ( is_null($left)  ) { $left = 0; }
   if ( is_null($right) ) { $right = 0; }
   if ( function_exists("gmp_sub") ) {
      debug(array('gmp_sub', $left, $right));
      return gmp_strval( gmp_sub( $left, $right ));
   }
   elseif ( function_exists("bcsub") ) {
      debug(array('bcsub', $left, $right));
      return bcsub( $left, $right );
   }
   else {
      debug(array('to_int', $left, $right));
      return to_int($left - $right);
   }
}

# ============================================================================
# Add two big integers together as accurately as possible with reasonable
# effort.  This is tested in t/mysql_stats.php and copied, without tests, to
# ss_get_by_ssh.php.
# ============================================================================
function big_add ($left, $right) {
   if ( is_null($left)  ) { $left = 0; }
   if ( is_null($right) ) { $right = 0; }
   if ( function_exists("gmp_add") ) {
      debug(array('gmp_add', $left, $right));
      return gmp_strval( gmp_add( $left, $right ));
   }
   elseif ( function_exists("bcadd") ) {
      debug(array('bcadd', $left, $right));
      return bcadd( $left, $right );
   }
   else {
      debug(array('to_int', $left, $right));
      return to_int($left + $right);
   }
}

# ============================================================================
# Writes to a debugging log.
# ============================================================================
function debug($val) {
   global $debug_log;
   if ( !$debug_log ) {
      return;
   }
   if ( $fp = fopen($debug_log, 'a+') ) {
      $trace = debug_backtrace();
      $calls = array();
      $i    = 0;
      $line = 0;
      $file = '';
      foreach ( debug_backtrace() as $arr ) {
         if ( $i++ ) {
            $calls[] = "$arr[function]() at $file:$line";
         }
         $line = $arr['line'];
         $file = $arr['file'];
      }
      if ( !count($calls) ) {
         $calls[] = "at $file:$line";
      }
      fwrite($fp, date('Y-M-D h:i:s') . ' ' . implode(' <- ', $calls));
      fwrite($fp, "\n" . var_export($val, TRUE) . "\n");
      fclose($fp);
   }
   else { # Disable logging
      print("Warning: disabling debug logging to $debug_log\n");
      $debug_log = FALSE;
   }
}

?>
