#################################################################
## BASH													       ##
#################################################################

BASHVERSION := 4.4
BASHARCHIVE := bash-$(BASHVERSION).tar.gz
BASHURI     := https://ftp.gnu.org/gnu/bash/$(BASHARCHIVE)


#################################################################
##                                                             ##
#################################################################

$(SOURCEDIR)/$(BASHARCHIVE): $(SOURCEDIR)
	$(DOWNLOADCMD) $@ $(BASHURI) || rm -f $@


#################################################################
##                                                             ##
#################################################################

$(BUILDDIR)/bash: $(SOURCEDIR)/$(BASHARCHIVE) $(BUILDDIR)/readline
	@mkdir -p $(BUILDDIR) && rm -rf $@-$(BASHVERSION)
	@tar -xzf $(SOURCEDIR)/$(BASHARCHIVE) -C $(BUILDDIR)
	@cd $@-$(BASHVERSION)					&& \
	$(BUILDENV)								\
		./configure							\
			--host=$(TARGET)				\
			--prefix=$(PREFIXDIR)			\
			--without-bash-malloc 			\
			--enable-largefile 				\
			--enable-alias 					\
			--enable-history				&& \
		make -j$(PROCS)						&& \
		make -j$(PROCS) install 			&& \
	rm $(PREFIXDIR)/lib/bash/Makefile.inc   && \
	$(TARGET)-strip $(PREFIXDIR)/lib/bash/* && \
	rm -rf $@-$(BASHVERSION)
	@touch $@


#################################################################
##                                                             ##
#################################################################
