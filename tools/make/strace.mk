#################################################################
## STRACE													   ##
#################################################################

STRACEVERSION := 4.10
STRACEARCHIVE := strace-$(STRACEVERSION).tar.xz
STRACEURI     := https://downloads.sourceforge.net/project/strace/strace/$(STRACEVERSION)/$(STRACEARCHIVE)


#################################################################
##                                                             ##
#################################################################

$(SOURCEDIR)/$(STRACEARCHIVE): $(SOURCEDIR)
	$(DOWNLOADCMD) $@ $(STRACEURI) || rm -f $@


#################################################################
##                                                             ##
#################################################################

$(BUILDDIR)/strace: $(SOURCEDIR)/$(STRACEARCHIVE)
	@mkdir -p $(BUILDDIR) && rm -rf $@-$(STRACEVERSION)
	@tar -xf $(SOURCEDIR)/$(STRACEARCHIVE) -C $(BUILDDIR)
	@cd $@-$(STRACEVERSION)					&& \
	patch -p2 < $(PATCHESDIR)/strace.patch	&& \
	$(BUILDENV)								\
		./configure							\
			--prefix=$(PREFIXDIR)			\
			--host=$(TARGET)				&& \
		make -j$(PROCS)						&& \
		make -j$(PROCS) install
	@rm -rf $@-$(STRACEVERSION)
	@touch $@


#################################################################
##                                                             ##
#################################################################
