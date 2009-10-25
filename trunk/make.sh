#!/bin/sh

set -e
set -u
set -x

NAME=better-cacti-templates
VERSION=`grep version Changelog | head -n 1 | cut -d ' ' -f 3`;
DISTFILES="COPYING README ss_get_mysql_stats.php Changelog meta/make-template.pl meta/mysql_definitions.pl"
DISTFILES="${DISTFILES} ss_get_by_ssh.php meta/apache_definitions.pl meta/gnu_linux_definitions.pl meta/memcached_definitions.pl meta/nginx_definitions.pl"

DISTDIR=$NAME-$VERSION

if test -d $DISTDIR ; then rm -rf $DISTDIR ; fi
mkdir $DISTDIR
cp -a $DISTFILES $DISTDIR

# Build the template.xml files...
perl meta/make-template.pl --script ss_get_mysql_stats.php meta/mysql_definitions.pl > ${DISTDIR}/cacti_host_template_x_mysql_server_ht_0.8.6i-sver${VERSION}.xml
for thing in apache gnu_linux memcached nginx; do
   perl meta/make-template.pl --script ss_get_by_ssh.php meta/${thing}_definitions.pl > ${DISTDIR}/cacti_host_template_x_${thing}_server_ht_0.8.6i-sver${VERSION}.xml
done

tar czf $DISTDIR.tar.gz $DISTDIR
rm -rf $DISTDIR
