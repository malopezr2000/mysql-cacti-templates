#!/bin/bash

set -e
set -u
set -x

VERSION=`head -n 5 Changelog | grep version | head -n 1 | cut -d ' ' -f 3`;
DISTDIR=better-cacti-templates-$VERSION

if test -d $DISTDIR ; then rm -rf $DISTDIR ; fi
mkdir -p $DISTDIR/{scripts,templates,tools,definitions,misc}
cp -a Changelog COPYING README $DISTDIR
cp -a tools/*.pl $DISTDIR/tools
cp -a scripts/*.php $DISTDIR/scripts
cp -a definitions/*.pl $DISTDIR/definitions
cp -a misc/*.* $DISTDIR/misc

# Build the template.xml files...
for file in definitions/*.pl; do
   SCRIPT=`grep Autobuild $file | cut -d ' ' -f 3`;
   NAME=`basename $file | sed -e s'/_definitions.pl//'`;
   perl tools/make-template.pl --script scripts/$SCRIPT $file \
      > $DISTDIR/templates/cacti_host_template_x_${NAME}_server_ht_0.8.6i-sver${VERSION}.xml
done

tar czf $DISTDIR.tar.gz $DISTDIR
rm -rf $DISTDIR
