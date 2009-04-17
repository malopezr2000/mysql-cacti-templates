#!/bin/sh

set -e
set -u

# After the cache file grows an hour old, rebuild it.
if ! find /tmp/host_count_cacti.txt -mtime -60 >/dev/null 2>&1 ; then
   mysql -N -e "select host, count(*) as num_users from mysql.user group by host" |
   while read line; do
      res=`echo $line | awk '{print $1 ":" $2}'`;
      echo -n $res;
      echo -n " ";
   done > /tmp/host_count_cacti.txt;
fi
cat /tmp/host_count_cacti.txt;
