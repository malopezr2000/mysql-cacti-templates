<?php
require('test-more.php');
require('../ss_get_mysql_stats.php');

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
   make_bigint('EF861B144C'),
   '1028747105356',
   'make_bigint EF861B144C'
);

is(
   big_sub('74900191315', '1170664159'),
   '73729527156',
   'big_sub 1170664159 74900191315'
);

is(
   big_multiply('74900191315', '1170664159'),
   '87682969474713583616',
   'big_multiply 74900191315 and 1170664159'
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
       'unflushed_log'             => '0',
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
       'hash_index_cells_total'    => '23374853',
       'hash_index_cells_used'     => '21238151',
       'total_mem_alloc'           => '13102052218',
       'additional_pool_alloc'     => '1048576',
   ),
   'samples/innodb-001.txt'
);

is_deeply(
   get_innodb_array(file_get_contents('samples/innodb-002.txt')),
   array(
      'spin_waits'                => '88127914',
      'spin_rounds'               => '157459864',
      'os_waits'                  => '4329779',
      'pending_normal_aio_reads'  => '1',
      'pending_normal_aio_writes' => '2',
      'pending_ibuf_aio_reads'    => '1',
      'pending_aio_log_ios'       => '2',
      'pending_aio_sync_ios'      => '3',
      'pending_log_flushes'       => '1',
      'pending_buf_pool_flushes'  => '2',
      'file_reads'                => '8782182',
      'file_writes'               => '15635445',
      'file_fsyncs'               => '947800',
      'ibuf_inserts'              => '17549044',
      'ibuf_merged'               => '15956910',
      'ibuf_merges'               => '1676050',
      'innodb_lsn'                => '13093949495856',
      'unflushed_log'             => '1276529',
      'flushed_to'                => '13093948219327',
      'pending_log_writes'        => '1',
      'pending_chkp_writes'       => '2',
      'log_writes'                => '3430041',
      'pool_size'                 => '1769471',
      'free_pages'                => '1',
      'database_pages'            => '1696503',
      'modified_pages'            => '160602',
      'pages_read'                => '15240822',
      'pages_created'             => '1770238',
      'pages_written'             => '21705836',
      'queries_inside'            => '1',
      'queries_queued'            => '2',
      'read_views'                => '1',
      'rows_inserted'             => '50678311',
      'rows_updated'              => '66425915',
      'rows_deleted'              => '20605903',
      'rows_read'                 => '454561562',
      'innodb_transactions'       => '1028747105356',
      'unpurged_txns'             => '1026497183983',
      'history_list'              => '132',
      'current_transactions'      => '2',
      'hash_index_cells_total'    => '57374437',
      'hash_index_cells_used'     => 0,
      'total_mem_alloc'           => '29642194944',
      'additional_pool_alloc'     => '0',
      ),
   'samples/innodb-002.txt'
);

is_deeply(
   get_innodb_array(file_get_contents('samples/innodb-006.txt')),
   array(
      'spin_waits'                => '31',
      'spin_rounds'               => '220',
      'os_waits'                  => '17',
      'innodb_transactions'       => '3411',
      'unpurged_txns'             => '11',
      'history_list'              => '19',
      'current_transactions'      => '2',
      'active_transactions'       => '2',
      'innodb_tables_in_use'      => '1',
      'innodb_locked_tables'      => '1',
      'locked_transactions'       => 1,
      'innodb_lock_structs'       => '5',
      'pending_normal_aio_reads'  => '0',
      'pending_normal_aio_writes' => '0',
      'pending_log_flushes'       => '0',
      'pending_buf_pool_flushes'  => '0',
      'file_reads'                => '42',
      'file_writes'               => '168',
      'file_fsyncs'               => '149',
      'ibuf_inserts'              => '0',
      'ibuf_merged'               => '0',
      'ibuf_merges'               => '0',
      'innodb_lsn'                => '103216',
      'unflushed_log'             => '0',
      'flushed_to'                => '103216',
      'pending_log_writes'        => '0',
      'pending_chkp_writes'       => '0',
      'log_writes'                => '72',
      'pool_size'                 => '512',
      'free_pages'                => '476',
      'database_pages'            => '35',
      'modified_pages'            => '0',
      'pages_read'                => '33',
      'pages_created'             => '48',
      'pages_written'             => '148',
      'queries_inside'            => '0',
      'queries_queued'            => '0',
      'read_views'                => '2',
      'rows_inserted'             => '5',
      'rows_updated'              => '0',
      'rows_deleted'              => '0',
      'rows_read'                 => '10',
      'innodb_lock_wait_secs'     => '32',
      'hash_index_cells_total'    => '17393',
      'hash_index_cells_used'     => '0',
      'total_mem_alloc'           => '20557306',
      'additional_pool_alloc'     => '744704',
   ),
   'samples/innodb-006.txt'
);

?>
