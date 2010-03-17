<?php
require('test-more.php');
require('../scripts/ss_get_by_ssh.php');
$debug = true;

is_deeply(
   proc_stat_parse(null, file_get_contents('samples/proc_stat-001.txt')),
   array(
      'STAT_interrupts'       => '339490',
      'STAT_context_switches' => '697948',
      'STAT_forks'            => '11558',
      'STAT_CPU_user'         => '24198',
      'STAT_CPU_nice'         => '0',
      'STAT_CPU_system'       => '69614',
      'STAT_CPU_idle'         => '2630536',
      'STAT_CPU_iowait'       => '558',
      'STAT_CPU_irq'          => '5872',
      'STAT_CPU_softirq'      => '1572',
      'STAT_CPU_steal'        => '0',
      'STAT_CPU_guest'        => '0'
   ),
   'samples/proc_stat-001.txt'
);

is_deeply(
   proc_stat_parse(null, file_get_contents('samples/proc_stat-002.txt')),
   array(
      'STAT_interrupts'       => '87480486',
      'STAT_context_switches' => '125521467',
      'STAT_forks'            => '239810',
      'STAT_CPU_user'         => '2261920',
      'STAT_CPU_nice'         => '38824',
      'STAT_CPU_system'       => '986335',
      'STAT_CPU_idle'         => '39683698',
      'STAT_CPU_iowait'       => '62368',
      'STAT_CPU_irq'          => '19193',
      'STAT_CPU_softirq'      => '8499',
      'STAT_CPU_steal'        => '0',
      'STAT_CPU_guest'        => '0'
   ),
   'samples/proc_stat-002.txt'
);

is(
   ss_get_by_ssh( array(
      'file'    => 'samples/proc_stat-001.txt',
      'type'    => 'proc_stat',
      'host'    => 'localhost',
      'items'   => 'ag,ah,ai,aj,ak,al,am,an,ao,ap,aq,ar'
   )),
   'ag:24198 ah:0 ai:69614 aj:2630536 ak:558 al:5872 am:1572 an:0 ao:0'
      . ' ap:339490 aq:697948 ar:11558',
   'main(samples/proc_stat-001.txt)'
);

is_deeply(
   memory_parse( null, file_get_contents('samples/free-001.txt') ),
   array(
      'STAT_memcached' => '22106112',
      'STAT_membuffer' => '1531904',
      'STAT_memshared' => '0',
      'STAT_memfree'   => '17928192',
      'STAT_memused'   => '21389312'
   ),
   'samples/free-001.txt'
);

is_deeply(
   memory_parse( null, file_get_contents('samples/free-002.txt') ),
   array(
      'STAT_memcached' => '1088184320',
      'STAT_membuffer' => '131469312',
      'STAT_memshared' => '0',
      'STAT_memfree'   => '189325312',
      'STAT_memused'   => '7568291328'
   ),
   'samples/free-002.txt (issue 102)'
);

is(
   ss_get_by_ssh( array(
      'file'    => 'samples/free-001.txt',
      'type'    => 'memory',
      'host'    => 'localhost',
      'items'   => 'au,av,aw,ax,ay'
   )),
   'au:22106112 av:1531904 aw:0 ax:17928192 ay:21389312',
   'main(samples/free-001.txt)'
);

is_deeply(
   w_parse( null, file_get_contents('samples/w-001.txt') ),
   array(
      'STAT_loadavg' => '1.43',
      'STAT_numusers' => '2',
   ),
   'samples/w-001.txt'
);

is_deeply(
   w_parse( null, file_get_contents('samples/w-002.txt') ),
   array(
      'STAT_loadavg' => '0.35',
      'STAT_numusers' => '6',
   ),
   'samples/w-002.txt'
);

is(
   ss_get_by_ssh( array(
      'file'    => 'samples/w-001.txt',
      'type'    => 'w',
      'host'    => 'localhost',
      'items'   => 'as,at'
   )),
   'as:1.43 at:2',
   'main(samples/w-002.txt)'
);

is_deeply(
   memcached_parse( null, file_get_contents('samples/memcached-001.txt') ),
   array(
      'MEMC_pid'                   => '2120',
      'MEMC_uptime'                => '32314',
      'MEMC_time'                  => '1261775864',
      'MEMC_version'               => '1.2.2',
      'MEMC_pointer_size'          => '32',
      'MEMC_rusage_user'           => '396024',
      'MEMC_rusage_system'         => '1956122',
      'MEMC_curr_items'            => '0',
      'MEMC_total_items'           => '0',
      'MEMC_bytes'                 => '0',
      'MEMC_curr_connections'      => '1',
      'MEMC_total_connections'     => '5',
      'MEMC_connection_structures' => '2',
      'MEMC_cmd_get'               => '0',
      'MEMC_cmd_set'               => '0',
      'MEMC_get_hits'              => '0',
      'MEMC_get_misses'            => '0',
      'MEMC_evictions'             => '0',
      'MEMC_bytes_read'            => '45',
      'MEMC_bytes_written'         => '942',
      'MEMC_limit_maxbytes'        => '67108864',
      'MEMC_threads'               => '1',
   ),
   'samples/memcached-001.txt'
);

is_deeply(
   nginx_parse( null, file_get_contents('samples/nginx-001.txt') ),
   array(
      'NGINX_active_connections' => '251',
      'NGINX_server_accepts'     => '255601634',
      'NGINX_server_handled'     => '255601634',
      'NGINX_server_requests'    => '671013148',
      'NGINX_reading'            => '5',
      'NGINX_writing'            => '27',
      'NGINX_waiting'            => '219',
   ),
   'samples/nginx-001.txt'
);

is_deeply(
   apache_parse( null, file_get_contents('samples/apache-001.txt') ),
   array(
      'Requests'               => '3452389',
      'Bytes_sent'             => '23852769280',
      'Idle_workers'           => '8',
      'Busy_workers'           => '1',
      'CPU_Load'               => '.023871',
      'Waiting_for_connection' => '8',
      'Starting_up'            => 0,
      'Reading_request'        => 0,
      'Sending_reply'          => '1',
      'Keepalive'              => 0,
      'DNS_lookup'             => 0,
      'Closing_connection'     => 0,
      'Logging'                => 0,
      'Gracefully_finishing'   => 0,
      'Idle_cleanup'           => 0,
      'Open_slot'              => '247',
   ),
   'samples/apache-001.txt'
);

is_deeply(
   diskstats_parse( array('device' => 'hda1'), file_get_contents('samples/diskstats-001.txt') ),
   array(
      'DISK_reads'              => '12043',
      'DISK_reads_merged'       => '387',
      'DISK_sectors_read'       => '300113',
      'DISK_time_spent_reading' => '6472',
      'DISK_writes'             => '12737',
      'DISK_writes_merged'      => '21340',
      'DISK_sectors_written'    => '272616',
      'DISK_time_spent_writing' => '22360',
      'DISK_io_ops_in_progress' => '0',
      'DISK_io_time'            => '12368',
      'DISK_io_time_weighted'   => '28832'
   ),
   'samples/diskstats-001.txt'
);

is_deeply(
   diskstats_parse( array('device' => 'sda4'), file_get_contents('samples/diskstats-002.txt') ),
   array(
      'DISK_reads'              => '30566',
      'DISK_reads_merged'       => '3341',
      'DISK_sectors_read'       => '586664',
      'DISK_time_spent_reading' => '370308',
      'DISK_writes'             => '150943',
      'DISK_writes_merged'      => '163833',
      'DISK_sectors_written'    => '2518672',
      'DISK_time_spent_writing' => '12081496',
      'DISK_io_time'            => '347416',
      'DISK_io_time_weighted'   => '12451664',
      'DISK_io_ops_in_progress' => '0'
   ),
   'samples/diskstats-002.txt'
);

is_deeply(
   diskstats_parse( array('device' => 'sda2'), file_get_contents('samples/diskstats-003.txt') ),
   array(
      'DISK_reads'              => '15425346',
      'DISK_reads_merged'       => '0',
      'DISK_sectors_read'       => '385290786',
      'DISK_time_spent_reading' => '0',
      'DISK_writes'             => '472909074',
      'DISK_writes_merged'      => '0',
      'DISK_sectors_written'    => '3783272616',
      'DISK_time_spent_writing' => '0',
      'DISK_io_time'            => '0',
      'DISK_io_time_weighted'   => '0',
      'DISK_io_ops_in_progress' => '0'
   ),
   'samples/diskstats-003.txt'
);

is(
   ss_get_by_ssh( array(
      'file'    => 'samples/diskstats-001.txt',
      'type'    => 'diskstats',
      'host'    => 'localhost',
      'items'   => 'bj,bk,bl,bm,bn,bo,bp,bq,br,bs,bt',
      'device'  => 'hda1'
   )),
   'bj:12043 bk:387 bl:300113 bm:6472 bn:12737 bo:21340 bp:272616 bq:22360 '
      . 'br:0 bs:12368 bt:28832',
   'main(samples/diskstats-001.txt)'
);

is_deeply(
   openvz_parse( array(), file_get_contents('samples/openvz-001.txt') ),
   array(
      'OPVZ_kmemsize_held'        => '8906701',
      'OPVZ_kmemsize_failcnt'     => '0',
      'OPVZ_lockedpages_held'     => '0',
      'OPVZ_lockedpages_failcnt'  => '0',
      'OPVZ_privvmpages_held'     => '39695',
      'OPVZ_privvmpages_failcnt'  => '0',
      'OPVZ_shmpages_held'        => '688',
      'OPVZ_shmpages_failcnt'     => '0',
      'OPVZ_numproc_held'         => '32',
      'OPVZ_numproc_failcnt'      => '0',
      'OPVZ_physpages_held'       => '11101',
      'OPVZ_physpages_failcnt'    => '0',
      'OPVZ_vmguarpages_held'     => '0',
      'OPVZ_vmguarpages_failcnt'  => '0',
      'OPVZ_oomguarpages_held'    => '11101',
      'OPVZ_oomguarpages_failcnt' => '0',
      'OPVZ_numtcpsock_held'      => '6',
      'OPVZ_numtcpsock_failcnt'   => '0',
      'OPVZ_numflock_held'        => '6',
      'OPVZ_numflock_failcnt'     => '0',
      'OPVZ_numpty_held'          => '1',
      'OPVZ_numpty_failcnt'       => '0',
      'OPVZ_numsiginfo_held'      => '0',
      'OPVZ_numsiginfo_failcnt'   => '0',
      'OPVZ_tcpsndbuf_held'       => '338656',
      'OPVZ_tcpsndbuf_failcnt'    => '0',
      'OPVZ_tcprcvbuf_held'       => '98304',
      'OPVZ_tcprcvbuf_failcnt'    => '0',
      'OPVZ_othersockbuf_held'    => '9280',
      'OPVZ_othersockbuf_failcnt' => '0',
      'OPVZ_dgramrcvbuf_held'     => '0',
      'OPVZ_dgramrcvbuf_failcnt'  => '0',
      'OPVZ_numothersock_held'    => '9',
      'OPVZ_numothersock_failcnt' => '0',
      'OPVZ_dcachesize_held'      => '0',
      'OPVZ_dcachesize_failcnt'   => '0',
      'OPVZ_numfile_held'         => '788',
      'OPVZ_numfile_failcnt'      => '0',
      'OPVZ_numiptent_held'       => '10',
      'OPVZ_numiptent_failcnt'    => '0',
   ),
   'samples/openvz-001.txt'
);

is(
   ss_get_by_ssh( array(
      'file'    => 'samples/openvz-001.txt',
      'type'    => 'openvz',
      'host'    => 'localhost',
      'items'   => 'bu,bv,bw,bx,by,bz,c0',
   )),
   'bu:8906701 bv:0 bw:0 bx:0 by:39695 bz:0 c0:688',
   'main(samples/openvz-001.txt)'
);

is_deeply(
   redis_parse( null, file_get_contents('samples/redis-001.txt') ),
   array(
      'REDIS_connected_clients'          => '119',
      'REDIS_connected_slaves'           => '911',
      'REDIS_used_memory'                => '412372',
      'REDIS_changes_since_last_save'    => '4321',
      'REDIS_total_connections_received' => '3333',
      'REDIS_total_commands_processed'   => '5',
   ),
   'samples/redis-001.txt'
);

is(
   ss_get_by_ssh( array(
      'file'    => 'samples/redis-001.txt',
      'type'    => 'redis',
      'host'    => 'localhost',
      'items'   => 'cy,cz,d0,d1,d2,d3',
   )),
   'cy:119 cz:911 d0:412372 d1:4321 d2:3333 d3:5',
   'main(samples/redis-001.txt)'
);

?>
