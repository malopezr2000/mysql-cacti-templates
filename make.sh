#!/bin/sh

set -e
set -u
set -x

NAME=mysql-cacti-templates
VERSION=`grep version Changelog | head -n 1 | cut -d ' ' -f 3`;
DISTFILES="COPYING README ss_get_mysql_stats.php Changelog meta/make-template.pl meta/mysql_definitions.pl"

DISTDIR=$NAME-$VERSION

if test -d $DISTDIR ; then rm -rf $DISTDIR ; fi
mkdir $DISTDIR
cp -a $DISTFILES $DISTDIR
cp release/*.xml $DISTDIR

tar czf $DISTDIR.tar.gz $DISTDIR
rm -rf $DISTDIR
