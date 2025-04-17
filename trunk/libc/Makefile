#SRC_NAME=uClibc-ng-1.0.52
#SRC_URL=https://downloads.uclibc-ng.org/releases/1.0.52/$(SRC_NAME).tar.xz
.EXPORT_ALL_VARIABLES:
.PHONY: all romfs clean

ifndef ROOTDIR
ROOTDIR=..
endif
ifndef ROMFSDIR
ROMFSDIR=$(ROOTDIR)/romfs
endif

include $(PROJECT_CONFIG)
include $(ARCH_CONFIG)
include $(LINUX_CONFIG)
include $(ROOTDIR)/include/configedit.mk

DESTDIR=$(ROOTDIR)/stage

LIBC_DIR = uClibc-ng-1.0.52
#all: download_test extract_test
#download_test:
#	( if [ ! -f $(SRC_NAME).tar.xz ]; then \
#		wget -t5 --timeout=20 --no-check-certificate -O $(SRC_NAME).tar.xz $(SRC_URL); \
#	fi )
#
#extract_test:
#	( if [ ! -d $(SRC_NAME) ]; then \
#		tar xJf $(SRC_NAME).tar.xz; \
#	fi )

all:
	cp -fL $(ROOTDIR)/configs/boards/uclibc-mipsel.config $(LIBC_DIR)/.config
ifeq ($(CONFIG_IPV6),y)
	$(call KconfigEnableOption,UCLIBC_HAS_IPV6,$(LIBC_DIR)/.config)
else
	$(call KconfigDisableOption,UCLIBC_HAS_IPV6,$(LIBC_DIR)/.config)
endif
ifneq (,$(filter y,$(CONFIG_MMC_BLOCK) $(CONFIG_BLK_DEV_SD)))
	$(call KconfigEnableOption,UCLIBC_HAS_LIBICONV,$(LIBC_DIR)/.config)
else
	$(call KconfigDisableOption,UCLIBC_HAS_LIBICONV,$(LIBC_DIR)/.config)
endif
	$(call KconfigSetOption,UCLIBC_EXTRA_CFLAGS,"$(CPUFLAGS) $(CFLAGS)",$(LIBC_DIR)/.config)
	$(MAKE) -j$(HOST_NCPU) -C $(LIBC_DIR) oldconfig || exit $$? ; \
	if [ ! -f $(DESTDIR)/.installed_$(LIBC_DIR) ] ; then \
		$(MAKE) -C $(LIBC_DIR) PREFIX=$(DESTDIR) DEVEL_PREFIX=/ MULTILIB_DIR=lib install_runtime install_utils && \
		touch $(DESTDIR)/.installed_$(LIBC_DIR) ; \
	fi

%_only:
	$(MAKE) -C $(@:_only=)

%_romfs:
	$(MAKE) -C $(@:_romfs=) romfs

%_clean:
	$(MAKE) -C $(@:_clean=) clean

romfs:
	$(STRIP) $(DESTDIR)/bin/ldd ; \
	$(STRIP) $(DESTDIR)/sbin/ldconfig ; \
	cp -fP $(DESTDIR)/bin/ldd $(ROMFSDIR)/bin ; \
	cp -fP $(DESTDIR)/lib/libuClibc*.so* $(ROMFSDIR)/lib ; \
	cp -fP $(DESTDIR)/lib/libc.so.0 $(ROMFSDIR)/lib ; \
	cp -fP $(DESTDIR)/lib/ld-uClibc*.so* $(ROMFSDIR)/lib ; \
	chmod +x $(ROMFSDIR)/lib/libuClibc*.so

clean:
	rm -f $(DESTDIR)/.installed_$(LIBC_DIR)
	$(MAKE) -C $(LIBC_DIR) distclean
