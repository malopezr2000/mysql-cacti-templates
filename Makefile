NAME = mysql-cacti-templates
VERSION = 1.0.0
DISTFILES = COPYING \
	README \
	ss_get_mysql_stats.php \
	Changelog

DISTDIR = $(NAME)-$(VERSION)

all: $(DISTFILES)

distdir: all
	if test -d $(DISTDIR) ; then rm -rf $(DISTDIR) ; fi
	mkdir $(DISTDIR)
	cp -a $(DISTFILES) $(DISTDIR)
	cp release/*.xml $(DISTDIR)

dist: distdir
	tar czf $(DISTDIR).tar.gz $(DISTDIR)
	rm -rf $(DISTDIR)

distclean:
	rm -f $(DISTDIR).tar.gz
	rm -f $(DISTDIR).zip

upload:
	googlecode_upload.py -s "Version $(VERSION)" -p mysql-cacti-templates -u baron.schwartz $(DISTDIR).tar.gz
