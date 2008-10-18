# This is the template definition file.  To use it, see make-template.pl.
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

{
   name   => 'Apache Server',
   hash   => 'hash_02_VER_3df221ff7893faad48ecc15026687215',
   graphs => [
      {  name       => 'Apache Requests',
         base_value => '1000',
         hash       => 'hash_00_VER_c870e809c16ac409190bcfbaf6c55624',
         dt         => {
            hash       => 'hash_01_VER_29f0b43ffd723039d3428839ab9f5174',
            input      => 'Get Apache Stats',
            Requests => {
               data_source_type_id => '2',
               hash => 'hash_08_VER_f8851b46ed984a9e8fba454c48995230'
            },
         },
         items => [
            {  color  => '803405',
               item   => 'Requests',
               task   => 'hash_09_VER_b06844c326fac7ec50d9819b47b3430a',
               type   => 'AREA',
               hashes => [
                  'hash_10_VER_b05a1a789491c12bed93e2c610e72fa0',
                  'hash_10_VER_c5621ec923c0e47f0603638f9fbb5815',
                  'hash_10_VER_7e9cc68942f31c8de3788336f080166f',
                  'hash_10_VER_c6da7f77308d3127ca7e18385c86ceeb'
               ],
            },
         ],
      },
      {  name       => 'Apache Bytes',
         base_value => '1024',
         hash       => 'hash_00_VER_c870e809c16ac409190bcfbaf6c55624',
         dt         => {
            hash       => 'hash_01_VER_29f0b43ffd723039d3428839ab9f5174',
            input      => 'Get Apache Stats',
            Bytes_sent => {
               data_source_type_id => '2',
               hash => 'hash_08_VER_f8851b46ed984a9e8fba454c48995230'
            },
         },
         items => [
            {  color  => '5D868C',
               item   => 'Bytes_sent',
               task   => 'hash_09_VER_b06844c326fac7ec50d9819b47b3430a',
               type   => 'AREA',
               hashes => [
                  'hash_10_VER_b05a1a789491c12bed93e2c610e72fa0',
                  'hash_10_VER_c5621ec923c0e47f0603638f9fbb5815',
                  'hash_10_VER_7e9cc68942f31c8de3788336f080166f',
                  'hash_10_VER_c6da7f77308d3127ca7e18385c86ceeb'
               ],
            },
         ],
      },
      {  name       => 'Apache Workers',
         base_value => '1000',
         hash       => 'hash_00_VER_c870e809c16ac409190bcfbaf6c55624',
         dt         => {
            hash       => 'hash_01_VER_29f0b43ffd723039d3428839ab9f5174',
            input      => 'Get Apache Stats',
            Idle_workers => {
               data_source_type_id => '1',
               hash => 'hash_08_VER_f8851b46ed984a9e8fba454c48995230'
            },
            Busy_workers => {
               data_source_type_id => '1',
               hash => 'hash_08_VER_f8851b46ed984a9e8fba454c48995230'
            },
         },
         items => [
            {  color  => 'EEB78E',
               item   => 'Idle_workers',
               task   => 'hash_09_VER_b06844c326fac7ec50d9819b47b3430a',
               type   => 'AREA',
               hashes => [
                  'hash_10_VER_b05a1a789491c12bed93e2c610e72fa0',
                  'hash_10_VER_c5621ec923c0e47f0603638f9fbb5815',
                  'hash_10_VER_7e9cc68942f31c8de3788336f080166f',
                  'hash_10_VER_c6da7f77308d3127ca7e18385c86ceeb'
               ],
            },
            {  color  => '47748B',
               item   => 'Busy_workers',
               task   => 'hash_09_VER_b06844c326fac7ec50d9819b47b3430a',
               type   => 'STACK',
               hashes => [
                  'hash_10_VER_b05a1a789491c12bed93e2c610e72fa0',
                  'hash_10_VER_c5621ec923c0e47f0603638f9fbb5815',
                  'hash_10_VER_7e9cc68942f31c8de3788336f080166f',
                  'hash_10_VER_c6da7f77308d3127ca7e18385c86ceeb'
               ],
            },
         ],
      },
      {  name       => 'Apache Scoreboard',
         base_value => '1000',
         hash       => 'hash_00_VER_c870e809c16ac409190bcfbaf6c55624',
         dt         => {
            hash       => 'hash_01_VER_29f0b43ffd723039d3428839ab9f5174',
            input      => 'Get Apache Stats',
            Waiting_for_connection => {
               data_source_type_id => '1',
               hash => 'hash_08_VER_f8851b46ed984a9e8fba454c48995230'
            },
            Starting_up => {
               data_source_type_id => '1',
               hash => 'hash_08_VER_f8851b46ed984a9e8fba454c48995230'
            },
            Reading_request => {
               data_source_type_id => '1',
               hash => 'hash_08_VER_f8851b46ed984a9e8fba454c48995230'
            },
            Sending_reply => {
               data_source_type_id => '1',
               hash => 'hash_08_VER_f8851b46ed984a9e8fba454c48995230'
            },
            Keepalive => {
               data_source_type_id => '1',
               hash => 'hash_08_VER_f8851b46ed984a9e8fba454c48995230'
            },
            DNS_lookup => {
               data_source_type_id => '1',
               hash => 'hash_08_VER_f8851b46ed984a9e8fba454c48995230'
            },
            Closing_connection => {
               data_source_type_id => '1',
               hash => 'hash_08_VER_f8851b46ed984a9e8fba454c48995230'
            },
            Logging => {
               data_source_type_id => '1',
               hash => 'hash_08_VER_f8851b46ed984a9e8fba454c48995230'
            },
            Gracefully_finishing => {
               data_source_type_id => '1',
               hash => 'hash_08_VER_f8851b46ed984a9e8fba454c48995230'
            },
            Idle_cleanup => {
               data_source_type_id => '1',
               hash => 'hash_08_VER_f8851b46ed984a9e8fba454c48995230'
            },
            Open_slot => {
               data_source_type_id => '1',
               hash => 'hash_08_VER_f8851b46ed984a9e8fba454c48995230'
            },
         },
         items => [
            {  color  => 'DE0056',
               item   => 'Waiting_for_connection',
               task   => 'hash_09_VER_b06844c326fac7ec50d9819b47b3430a',
               type   => 'AREA',
               hashes => [
                  'hash_10_VER_b05a1a789491c12bed93e2c610e72fa0',
                  'hash_10_VER_c5621ec923c0e47f0603638f9fbb5815',
                  'hash_10_VER_7e9cc68942f31c8de3788336f080166f',
                  'hash_10_VER_c6da7f77308d3127ca7e18385c86ceeb'
               ],
            },
            {  color  => '784890',
               item   => 'Starting_up',
               task   => 'hash_09_VER_b06844c326fac7ec50d9819b47b3430a',
               type   => 'STACK',
               hashes => [
                  'hash_10_VER_b05a1a789491c12bed93e2c610e72fa0',
                  'hash_10_VER_c5621ec923c0e47f0603638f9fbb5815',
                  'hash_10_VER_7e9cc68942f31c8de3788336f080166f',
                  'hash_10_VER_c6da7f77308d3127ca7e18385c86ceeb'
               ],
            },
            {  color  => 'D1642E',
               item   => 'Reading_request',
               task   => 'hash_09_VER_b06844c326fac7ec50d9819b47b3430a',
               type   => 'STACK',
               hashes => [
                  'hash_10_VER_b05a1a789491c12bed93e2c610e72fa0',
                  'hash_10_VER_c5621ec923c0e47f0603638f9fbb5815',
                  'hash_10_VER_7e9cc68942f31c8de3788336f080166f',
                  'hash_10_VER_c6da7f77308d3127ca7e18385c86ceeb'
               ],
            },
            {  color  => '487860',
               item   => 'Sending_reply',
               task   => 'hash_09_VER_b06844c326fac7ec50d9819b47b3430a',
               type   => 'STACK',
               hashes => [
                  'hash_10_VER_b05a1a789491c12bed93e2c610e72fa0',
                  'hash_10_VER_c5621ec923c0e47f0603638f9fbb5815',
                  'hash_10_VER_7e9cc68942f31c8de3788336f080166f',
                  'hash_10_VER_c6da7f77308d3127ca7e18385c86ceeb'
               ],
            },
            {  color  => '907890',
               item   => 'Keepalive',
               task   => 'hash_09_VER_b06844c326fac7ec50d9819b47b3430a',
               type   => 'STACK',
               hashes => [
                  'hash_10_VER_b05a1a789491c12bed93e2c610e72fa0',
                  'hash_10_VER_c5621ec923c0e47f0603638f9fbb5815',
                  'hash_10_VER_7e9cc68942f31c8de3788336f080166f',
                  'hash_10_VER_c6da7f77308d3127ca7e18385c86ceeb'
               ],
            },
            {  color  => 'DE0056',
               item   => 'DNS_lookup',
               task   => 'hash_09_VER_b06844c326fac7ec50d9819b47b3430a',
               type   => 'STACK',
               hashes => [
                  'hash_10_VER_b05a1a789491c12bed93e2c610e72fa0',
                  'hash_10_VER_c5621ec923c0e47f0603638f9fbb5815',
                  'hash_10_VER_7e9cc68942f31c8de3788336f080166f',
                  'hash_10_VER_c6da7f77308d3127ca7e18385c86ceeb'
               ],
            },
            {  color  => '1693A7',
               item   => 'Closing_connection',
               task   => 'hash_09_VER_b06844c326fac7ec50d9819b47b3430a',
               type   => 'STACK',
               hashes => [
                  'hash_10_VER_b05a1a789491c12bed93e2c610e72fa0',
                  'hash_10_VER_c5621ec923c0e47f0603638f9fbb5815',
                  'hash_10_VER_7e9cc68942f31c8de3788336f080166f',
                  'hash_10_VER_c6da7f77308d3127ca7e18385c86ceeb'
               ],
            },
            {  color  => 'FF7D00',
               item   => 'Logging',
               task   => 'hash_09_VER_b06844c326fac7ec50d9819b47b3430a',
               type   => 'STACK',
               hashes => [
                  'hash_10_VER_b05a1a789491c12bed93e2c610e72fa0',
                  'hash_10_VER_c5621ec923c0e47f0603638f9fbb5815',
                  'hash_10_VER_7e9cc68942f31c8de3788336f080166f',
                  'hash_10_VER_c6da7f77308d3127ca7e18385c86ceeb'
               ],
            },
            {  color  => 'B83A04',
               item   => 'Gracefully_finishing',
               task   => 'hash_09_VER_b06844c326fac7ec50d9819b47b3430a',
               type   => 'STACK',
               hashes => [
                  'hash_10_VER_b05a1a789491c12bed93e2c610e72fa0',
                  'hash_10_VER_c5621ec923c0e47f0603638f9fbb5815',
                  'hash_10_VER_7e9cc68942f31c8de3788336f080166f',
                  'hash_10_VER_c6da7f77308d3127ca7e18385c86ceeb'
               ],
            },
            {  color  => '540202',
               item   => 'Idle_cleanup',
               task   => 'hash_09_VER_b06844c326fac7ec50d9819b47b3430a',
               type   => 'STACK',
               hashes => [
                  'hash_10_VER_b05a1a789491c12bed93e2c610e72fa0',
                  'hash_10_VER_c5621ec923c0e47f0603638f9fbb5815',
                  'hash_10_VER_7e9cc68942f31c8de3788336f080166f',
                  'hash_10_VER_c6da7f77308d3127ca7e18385c86ceeb'
               ],
            },
            {  color  => '6E645A',
               item   => 'Open_slot',
               task   => 'hash_09_VER_b06844c326fac7ec50d9819b47b3430a',
               type   => 'STACK',
               hashes => [
                  'hash_10_VER_b05a1a789491c12bed93e2c610e72fa0',
                  'hash_10_VER_c5621ec923c0e47f0603638f9fbb5815',
                  'hash_10_VER_7e9cc68942f31c8de3788336f080166f',
                  'hash_10_VER_c6da7f77308d3127ca7e18385c86ceeb'
               ],
            },
         ],
      },
   ],
   inputs => {
      'Get Apache Stats' => {
         type_id      => 1,
         hash         => 'hash_03_VER_a7b8dc9089ba40cbb293524024e51129',
         input_string => '<path_php_binary> -q <path_cacti>/scripts/ss_get_apache_stats.php '
                       . '--host <hostname> --items <items>',
         inputs => [
            {  allow_nulls => '',
               hash        => 'hash_07_VER_c89cbc8b1c987e050a310ee5414b2a02',
               name        => 'hostname'
            },
         ],
         outputs => {
            Requests => 'hash_07_VER_c89cbc8b1c987e050a310ee5414b2a02',
            Bytes_sent => 'hash_07_VER_c89cbc8b1c987e050a310ee5414b2a02',
            Idle_workers => 'hash_07_VER_c89cbc8b1c987e050a310ee5414b2a02',
            Busy_workers => 'hash_07_VER_c89cbc8b1c987e050a310ee5414b2a02',
            Waiting_for_connection => 'hash_07_VER_c89cbc8b1c987e050a310ee5414b2a02',
            Starting_up => 'hash_07_VER_c89cbc8b1c987e050a310ee5414b2a02',
            Reading_request => 'hash_07_VER_c89cbc8b1c987e050a310ee5414b2a02',
            Sending_reply => 'hash_07_VER_c89cbc8b1c987e050a310ee5414b2a02',
            Keepalive => 'hash_07_VER_c89cbc8b1c987e050a310ee5414b2a02',
            DNS_lookup => 'hash_07_VER_c89cbc8b1c987e050a310ee5414b2a02',
            Closing_connection => 'hash_07_VER_c89cbc8b1c987e050a310ee5414b2a02',
            Logging => 'hash_07_VER_c89cbc8b1c987e050a310ee5414b2a02',
            Gracefully_finishing => 'hash_07_VER_c89cbc8b1c987e050a310ee5414b2a02',
            Idle_cleanup => 'hash_07_VER_c89cbc8b1c987e050a310ee5414b2a02',
            Open_slot => 'hash_07_VER_c89cbc8b1c987e050a310ee5414b2a02',
         },
      },
   },
};
