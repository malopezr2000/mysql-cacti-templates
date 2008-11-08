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
# Define parameters.
# ============================================================================
$ssh_user   = 'cacti';                          # SSH username
$ssh_port   = 22;                               # SSH port
$ssh_iden   = '-i /var/www/cacti/.ssh/id_rsa';  # SSH identity
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
   array_shift($_SERVER["argv"]); # Strip off ss_get_by_ssh.php
   $options = parse_cmdline($_SERVER["argv"]);
   validate_options($options);
   $result = ss_get_by_ssh($options);
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
# TODO: --ident
# ============================================================================
function validate_options($options) {
   $opts = array('host', 'port', 'items', 'nocache', 'type', 'url', 'http-user',
                 'http-password', 'server');
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
   --port      Port to connect to (via SSH)
   --items     Comma-separated list of the items whose data you want
   --type      One of apache, nginx, proc_stat, w, memory, memcached
               (more are TODO)
   --nocache   Do not cache results in a file

Specific options for HTTP status:

   --url       The url, such as /server-status, where server status lives
   --http-user The HTTP authentication user
   --http-password
               The HTTP authentication password
   --server    The server (DNS name or IP address) from which to fetch the
               server status.  Default is 'localhost'.

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
   return $result;
}

# ============================================================================
# This is the main function.  Some parameters are filled in from defaults at the
# top of this file.
# ============================================================================
function ss_get_by_ssh( $options ) {
   global $debug, $ssh_user, $ssh_port, $ssh_iden, $url, $cache_dir, $poll_time;

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

   # SSH to the server and get the data.
   $user = $ssh_user;
   $port = isset($options['port']) ? $options['port'] : $ssh_port;
   $iden = $ssh_iden;
   $cmd = "ssh $user@$options[host] -p $port $iden ";

   $result = array();
   switch ( $options['type'] ) {
   case 'apache':
      $result = get_stats_apache($cmd, $options);
      break;
   case 'nginx':
      $result = get_stats_nginx($cmd, $options);
      break;
   case 'proc_stat':
      $result = get_stats_proc_stat($cmd, $options);
      break;
   case 'memory':
      $result = get_stats_free($cmd, $options);
      break;
   case 'w':
      $result = get_stats_w($cmd, $options);
      break;
   case 'memcached':
      $result = get_stats_memcached($cmd, $options);
      break;
   default:
      die("Unknown value for --type: $options[type]");
      break;
   }

   # Define the variables to output.  I use shortened variable names so maybe
   # it'll all fit in 1024 bytes for Cactid and Spine's benefit.  This list must
   # come right after the word MAGIC_VARS_DEFINITIONS.  The Perl script parses
   # it and uses it as a Perl variable.
   # TODO: give them all a name prefix
   $keys = array(
      # Apache stuff
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
# Gets /proc/stat from Linux.
# Options used: none.
# You can test it like this, as root:
# su - cacti -c 'env -i php /var/www/cacti/scripts/ss_get_by_ssh.php --type proc_stat --host 127.0.0.1 --items ag,ah'
# ============================================================================
function get_stats_proc_stat ( $cmd, $options ) {
   $cmd = "$cmd cat /proc/stat";
   $str = `$cmd`;

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

   foreach ( explode("\n", $str) as $line ) {
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
# Gets the results of the 'free' command from Linux.
# Options used: none.
# You can test it like this, as root:
# su - cacti -c 'env -i php /var/www/cacti/scripts/ss_get_by_ssh.php --type memory --host 127.0.0.1 --items au,av'
# ============================================================================
function get_stats_free ( $cmd, $options ) {
   $cmd = "$cmd free -ob";
   $str = `$cmd`;

   $result = array(
      'STAT_memcached' => null,
      'STAT_membuffer' => null,
      'STAT_memshared' => null,
      'STAT_memfree'   => null,
      'STAT_memused'   => null,
   );

   foreach ( explode("\n", $str) as $line ) {
      if ( preg_match_all('/\S+/', $line, $words) ) {
         $words = $words[0];
         if ( $words[0] == "Mem:" ) {
            $result['STAT_memcached'] = $words[6];
            $result['STAT_membuffer'] = $words[5];
            $result['STAT_memshared'] = $words[4];
            $result['STAT_memfree']   = $words[3];
            $result['STAT_memused']
               = sprintf('%u', $words[2] - $words[4] - $words[5] - $words[6]);
         }
      }
   }
   return $result;
}

# ============================================================================
# Gets the results of the 'w' command from Linux.
# Options used: none.
# You can test it like this, as root:
# su - cacti -c 'env -i php /var/www/cacti/scripts/ss_get_by_ssh.php --type w --host 127.0.0.1 --items as,at'
# ============================================================================
function get_stats_w ( $cmd, $options ) {
   $cmd = "$cmd w";
   $str = `$cmd`;

   $result = array(
      'STAT_loadavg'        => null,
      'STAT_numusers'       => null,
   );

   foreach ( explode("\n", $str) as $line ) {
      if ( preg_match_all('/\S+/', $line, $words) ) {
         $words = $words[0];
         if ( $words[1] == "up" ) {
            for ( $i = 0; $i < count($words); ++$i ) {
               if ( $words[$i] == 'users,' || $words[$i] == 'user,' ) {
                  $result['STAT_numusers'] = $words[$i - 1];
               }
               elseif ( $words[$i] == 'average:' ) {
                  # TODO should it choose 5/1 minute avg based on poll interval?
                  $result['STAT_loadavg'] = tofloat($words[$i + 1]);
               }
            }
         }
      }
   }
   return $result;
}

# ============================================================================
# Gets /server-status from Apache.
# You can test it like this, as root:
# su - cacti -c 'env -i php /var/www/cacti/scripts/ss_get_by_ssh.php --type apache --host 127.0.0.1 --items a0,a1'
# ============================================================================
function get_stats_apache ( $cmd, $options ) {
   global $status_server, $status_url, $http_user, $http_pass;
   $srv = isset($options['server']) ? $options['server'] : $status_server;
   $url = isset($options['url'])    ? $options['url']    : $status_url;
   $user = isset($options['http-user'])     ? $options['http-user']     : $http_user;
   $pass = isset($options['http-password']) ? $options['http-password'] : $http_pass;
   $auth = ($user ? "--http-user=$user" : '') . ' ' . ($pass ? "--http-password=$pass" : '');
   $cmd = "$cmd wget $auth -U Cacti/1.0 -q -O - -T 5 'http://localhost$url?auto'";
   $str = `$cmd`;

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
      $result[$val] = null;
   }

   # Mapping from line prefix to data item name
   $mapping = array (
      "Total Accesses" => 'Requests',
      "Total kBytes"   => 'Bytes_sent',
      "CPULoad"        => 'CPU_Load',
      "BusyWorkers"    => 'Busy_workers',
      "IdleWorkers"    => 'Idle_workers',
   );

   foreach ( explode("\n", $str) as $line ) {
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
function get_stats_nginx ( $cmd, $options ) {
   global $status_server, $status_url, $http_user, $http_pass;
   $srv = isset($options['server']) ? $options['server'] : $status_server;
   $url = isset($options['url'])    ? $options['url']    : $status_url;
   $user = isset($options['http-user'])     ? $options['http-user']     : $http_user;
   $pass = isset($options['http-password']) ? $options['http-password'] : $http_pass;
   $auth = ($user ? "--http-user=$user" : '') . ' ' . ($pass ? "--http-password=$pass" : '');
   $cmd = "$cmd wget $auth -U Cacti/1.0 -q -O - -T 5 'http://$srv$url?auto'";
   $str = `$cmd`;

   $result = array(
      'NGINX_active_connections' => null,
      'NGINX_server_accepts'     => null,
      'NGINX_server_handled'     => null,
      'NGINX_server_requests'    => null,
      'NGINX_reading'            => null,
      'NGINX_writing'            => null,
      'NGINX_waiting'            => null,
   );

   foreach ( explode("\n", $str) as $line ) {
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
# Gets getStats() from memcached.  Does NOT use SSH!
# You can test it like this, as root:
# su - cacti -c 'env -i php /var/www/cacti/scripts/ss_get_by_ssh.php --type memcached --host 127.0.0.1 --items b6,b7'
# TODO: use sockets to get, instead of requiring the Memcache extension?
# ============================================================================
function get_stats_memcached ( $cmd, $options ) {
   global $memcache_port; # TODO: permit port override via cmdline

   $m = new Memcache();
   $m->connect($options['server'], $memcache_port)
      or die("Could not connect to memcached $options[server]:$memcache_port");
   $result = array();
   $stat = $m->getStats();
   foreach ( $stat as $key => $val ) {
      $result["MEMC_$key"] = $val;
   }
   return $result;
}

# ============================================================================
# Safely increments a value that might be null.
# ============================================================================
function increment(&$arr, $key, $howmuch) {
   if ( array_key_exists($key, $arr) && isset($arr[$key]) ) {
      $arr[$key] += $howmuch;
   }
   else {
      $arr[$key] = $howmuch;
   }
}

# ============================================================================
# Extracts the numbers from a string.  You can't reliably do this by casting to
# an int, because numbers that are bigger than PHP's int (varies by platform)
# will be truncated.  So this just handles them as a string instead.
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
      return null;
   }
}

# ============================================================================
# Extracts a float from a string.  See tonum().
# ============================================================================
function tofloat ( $str ) {
   global $debug;
   preg_match('{([0-9.]+)}', $str, $m); 
   if ( isset($m[1]) ) {
      return $m[1];
   }
   elseif ( $debug ) {
      print_r(debug_backtrace());
   }
   else {
      return null;
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

?>
