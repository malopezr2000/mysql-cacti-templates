<?php
require('test-more.php');
require('../scratch/ss_get_mysql_stats.php');

plan(4);

is(
   make_bigint('0', '1170663853'),
   '1170663853',
   'make_bigint 0 1170663853'
);

is(
   make_bigint('1', '504617703'),
   '4799584999',
   'make_bigint 1 504617703'
);

is(
   big_sub('74900191315', '1170664159'),
   '73729527156',
   'big_sub 1170664159 74900191315'
);

is_deeply(
   get_innodb_array(file_get_contents('samples/innodb-001.txt')),
   array(
       'spin_waits'                => '8317256878',
       'spin_rounds'               => '247280272495',
       'os_waits'                  => '1962880678',
       'innodb_transactions'       => '1170664159',
       'unpurged_txns'             => '306',
       'history_list'              => '9',
       'current_transactions'      => '36',
       'pending_normal_aio_reads'  => '0',
       'pending_normal_aio_writes' => '0',
       'pending_ibuf_aio_reads'    => '0',
       'pending_aio_log_ios'       => '0',
       'pending_aio_sync_ios'      => '0',
       'pending_log_flushes'       => '0',
       'pending_buf_pool_flushes'  => '0',
       'file_reads'                => '5985113',
       'file_writes'               => '633045221',
       'file_fsyncs'               => '537534629',
       'ibuf_inserts'              => '19817685',
       'ibuf_merged'               => '19817684',
       'ibuf_merges'               => '3552620',
       'innodb_lsn'                => '540805326864',
       'flushed_to'                => '540805326864',
       'pending_log_writes'        => '0',
       'pending_chkp_writes'       => '0',
       'log_writes'                => '520835887',
       'pool_size'                 => '720896',
       'free_pages'                => '0',
       'database_pages'            => '638423',
       'modified_pages'            => '118',
       'pages_read'                => '28593890',
       'pages_created'             => '5375161',
       'pages_written'             => '154670836',
       'queries_inside'            => '0',
       'queries_queued'            => '0',
       'read_views'                => '1',
       'rows_inserted'             => '544159502',
       'rows_updated'              => '355138902',
       'rows_deleted'              => '50580680',
       'rows_read'                 => '1911833505287',
   ),
   'samples/innodb-001.txt'
);

?>
