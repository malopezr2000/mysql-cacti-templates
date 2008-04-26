# This is the definition of a Cacti template.  This file should contain nothing
# but a big Perl data structure.  Don't execute this file.  Instead, process it
# with make-template.pl like this:
#
# perl make-template.pl <file>
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
# Foundation, version 2.  On UNIX and similar systems, you can issue `man
# perlgpl' to read this license.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, write to the Free Software Foundation, Inc., 59 Temple
# Place, Suite 330, Boston, MA  02111-1307  USA.

# TODO: add a port to the ss_get_mysql_stats.php

{  name   => 'DB Server',
   hash   => 'hash_0200133df221ff7893faad48ecc15026687215',
   inputs => {
      'Get MySQL Stats' => {
         name    => 'Get MySQL Stats',
         hash    => 'hash_030013a7b8dc9089ba40cbb293524024e51129',
         type_id => 1,
         input_string => '<path_php_binary> -q '
            . '<path_cacti>/scripts/ss_get_mysql_stats.php <hostname> <username>'
            . '<password>',
         inputs => [
            {  name        => 'hostname',
               hash        => 'hash_070013c89cbc8b1c987e050a310ee5414b2a02',
               allow_nulls => '',
            },
            {  name        => 'username',
               hash        => 'hash_070013181ee907dbb2bbfbfb3c6611f44e5625',
               allow_nulls => 'on',
            },
            {  name        => 'password',
               hash        => 'hash_070013e4ad68877c6e87087e52785d0a870282',
               allow_nulls => 'on',
            },
         ],
         outputs => {
            Key_read_requests =>
               'hash_070013b1c52bc482f979e5098096f60a346d96',
            Key_reads => 'hash_070013744750ba74f76128825af0421da2fc5e',
            Key_write_requests =>
               'hash_070013f883de2e830958a1b3472f1bb8209b16',
            Key_writes => 'hash_070013edc5905b12c0765d8b244467bf90ef13',
         },
      },
   },
   graphs => [
      {  name  => 'MyISAM Indexes',
         hash  => 'hash_000013c870e809c16ac409190bcfbaf6c55624',
         items => [
            {  item   => 'Key_read_requests',
               color  => '157419',
               type   => 'AREA',
               task   => 'hash_0900131d370e9a5914bc84d71e779814f357cb',
               hashes => [
                  qw(
                     hash_100013ac260a1434298e088f15f70cd1a5f726
                     hash_1000132880fe948b6912a3bbef6d572fc08c11
                     hash_1000137ad6f41485c166ba32e6d9e570e395f0
                     hash_100013c0e60c7d108ee721a537bb6e3c62a1d8
                     )
               ],
            },
            {  item   => 'Key_reads',
               color  => 'AFECED',
               task   => 'hash_0900135f6452acaf1e44638836412e2a701af5',
               hashes => [
                  qw(
                     hash_10001325df59422c805e4b85310ec3a4face3b
                     hash_100013f8b4402537c5b8f6fe87f025b66fa36d
                     hash_100013508445350edf7ebffcc53df8ca402cd4
                     hash_100013ce2c5b685c988e9ba283a5b26019a228
                     )
               ],
            },
            {  item   => 'Key_write_requests',
               color  => 'F51D30',
               task   => 'hash_090013cf20ffcf42c91bb6f8e6d4cadc6b74a5',
               hashes => [
                  qw(
                     hash_100013c8ddc4e379739fa6860644b9ec73fd67
                     hash_100013eee6bf6b5627650df8625d88f333299f
                     hash_100013c13f3d345b73c7333254c1d3efcbd02f
                     hash_100013c1d97c83fc4b5cbed160c1530f937307
                     )
               ],
            },
            {  item   => 'Key_writes',
               color  => '862F2F',
               task   => 'hash_090013b06844c326fac7ec50d9819b47b3430a',
               hashes => [
                  qw(
                     hash_100013b05a1a789491c12bed93e2c610e72fa0
                     hash_100013c5621ec923c0e47f0603638f9fbb5815
                     hash_1000137e9cc68942f31c8de3788336f080166f
                     hash_100013c6da7f77308d3127ca7e18385c86ceeb
                     )
               ],
            },
         ],
         dt => {
            hash  => 'hash_01001329f0b43ffd723039d3428839ab9f5174',
            input => 'Get MySQL Stats',
            Key_read_requests =>
               { hash => 'hash_080013b407e61e9948460c99116f7f6a72cf92' },
            Key_reads =>
               { hash => 'hash_0800130de2bf128eac0bc672d77085da38f8cf' },
            Key_write_requests =>
               { hash => 'hash_080013039d69d0262c783f20b77fa3b3f62e88' },
            Key_writes =>
               { hash => 'hash_080013f8851b46ed984a9e8fba454c48995230' },
         },
      },
   ],
   rras => [
      {  hash           => 'hash_150013c21df5178e5c955013591239eb0afd47',
         name           => 'Daily (5 Minute Average)',
         x_files_factor => '0.5',
         steps          => 1,
         rows           => 600,
         timespan       => 86400,
         cf_items       => '1|3',
      },
      {  hash           => 'hash_1500130d9c0af8b8acdc7807943937b3208e30',
         name           => 'Weekly (30 Minute Average)',
         x_files_factor => '0.5',
         steps          => '6',
         rows           => '700',
         timespan       => '604800',
         cf_items       => '1|3',
      },
      {  hash           => 'hash_1500136fc2d038fb42950138b0ce3e9874cc61',
         name           => 'Monthly (2 Hour Average)',
         x_files_factor => '0.5',
         steps          => '24',
         rows           => '775',
         timespan       => '2678400',
         cf_items       => '1|3',
      },
      {  hash           => 'hash_150013e36f3adb9f152adfa5dc50fd2b23337f',
         name           => 'Yearly (1 Day Average)',
         x_files_factor => '0.5',
         steps          => '288',
         rows           => '797',
         timespan       => '33053184',
         cf_items       => '1|3',
      },
   ],
   gprints => {
      Normal => {
         hash        => 'hash_060013e9c43831e54eca8069317a2ce8c6f752',
         gprint_text => '%8.2lf %s',
      },
   }
};
