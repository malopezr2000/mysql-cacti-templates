<?php

# ============================================================================
# Define connection constants in config.php.  Arguments explicitly passed
# in from Cacti will override these.  However, if you leave them blank in Cacti
# and set them here, you can make life easier.
# ============================================================================
$unix_user    = 'monitor';
$ssh_identity = "-i /etc/nagios/id_rsa";
$poll_time    = 300;     # Adjust to match your polling interval.

# ============================================================================
# You should not need to change anything below this line.
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
if ( file_exists( dirname(__FILE__) . "/../include/global.php") ) {
   # See issue 5 for the reasoning behind this.
   include_once(dirname(__FILE__) . "/../include/global.php");
}
else {
   # Some versions don't have global.php.
   include_once(dirname(__FILE__) . "/../include/config.php");
}

# ============================================================================
# Make sure we can also be called as a script.
# ============================================================================
if (!isset($called_by_script_server)) {
   array_shift($_SERVER["argv"]);
   $result = call_user_func_array("ss_get_lvm", $_SERVER["argv"]);
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
# Others are filled in from defaults at the top of this file.
# ============================================================================
function ss_get_lvm( $host, $user = null, $port = null, $identity = null ) {

   global $debug, $cache_dir, $poll_time, $unix_user, $ssh_identity;

   $user = isset($user) ? $user : $unix_user;
   $port = isset($port) ? $port : 22;
   $ident = isset($identity) ? "-i $identity" : $ssh_identity;

   $cmd = "ssh $user@$host -p $port $ident sudo /usr/sbin/lvs";
   # echo("$cmd\n");
   $lvs = `$cmd`;
   foreach ( explode("\n", $lvs) as $line ) {
      $words = preg_split("/\s+/", trim($line));
      if ( count($words) >= 6 && $words[5] != 'Snap%' ) {
         return $words[5] * 100;
      }
   }
   return 0;
}

?>

