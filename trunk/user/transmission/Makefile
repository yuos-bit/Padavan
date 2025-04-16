SRC_NAME=transmission-4.0.5
SRC_URL=https://github.com/transmission/transmission/archive/refs/tags/4.0.4.tar.xz
# FMT max ver9.1.0
SRC_URL_FMT=https://github.com/transmission/fmt/archive/refs/tags/9.1.0.tar.gz
SRC_URL_DHT=https://github.com/transmission/dhtfmt/archive/refs/tags/dht-0.26.tar.gz
SRC_URL_FAST_FLOAT=https://github.com/transmission/fast_float/archive/refs/tags/5.2.0.tar.gz
SRC_URL_FMT=https://github.com/transmission/fmt/archive/refs/tags/10.0.0.tar.gz
SRC_URL_B64=https://github.com/transmission/libb64/archive/refs/tags/2.0.0.1.tar.gz
SRC_URL_PSL=https://github.com/transmission/libpsl/archive/refs/tags/0.21.1.tar.gz
SRC_URL_MINIUPNPC=https://github.com/transmission/miniupnpc/archive/refs/tags/miniupnpd_2.3.0.tar.gz
SRC_URL_UTFCPP=https://github.com/transmission/utfcpp/archive/refs/tags/v3.2.1.tar.gz
SRC_URL_SMALL=https://github.com/transmission/small/archive/refs/tags/v0.1.2.tar.gz

THISDIR = $(shell pwd)

CFLAGS  += -O2 -ffunction-sections -fdata-sections -fvisibility=hidden -fPIC
LDFLAGS += -Wl,--gc-sections,-rpath-link,$(STAGEDIR)/lib -lcurl -lssl -lcrypto -lz


#all: download_test extract_test config_test
all: config_test
	$(MAKE) -j$(HOST_NCPU) -C $(SRC_NAME)/build && \
	$(MAKE) -C $(SRC_NAME)/build install DESTDIR=$(THISDIR)/install

download_test:
	( if [ ! -f $(SRC_NAME).tar.gz ]; then \
		wget -t5 --timeout=20 --no-check-certificate -O fmt.tar.xz $(SRC_URL_FMT); \
	fi )

extract_test:
	( if [ ! -d $(SRC_NAME) ]; then \
		tar xJf $(SRC_NAME).tar.xz; \
		patch -d $(SRC_NAME) -p1 -i ../disabled-examples-in-cmakelists.patch; \
	fi )

config_test:
	( if [ -f ./config_done ]; then \
		echo "the same configuration"; \
	else \
		make configure && touch config_done; \
	fi )

configure:
	( mkdir -p $(SRC_NAME)/build && cd $(SRC_NAME)/build ; \
	cmake	-DCMAKE_INSTALL_PREFIX:PATH=/ \
		-DENABLE_LIGHTWEIGHT=ON \
		-DENABLE_TESTS=OFF \
		-DENABLE_NLS=OFF \
		-DENABLE_GTK=OFF \
		-DENABLE_MAC=OFF \
		-DENABLE_CLI=OFF \
		-DINSTALL_DOC=OFF \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_LIBDIR=$(SRC_NAME)/build/lib \
		-DCMAKE_INSTALL_INCLUDEDIR=$(SRC_NAME)/build/lib/inc \
		-DCMAKE_TOOLCHAIN_FILE=$(ROOTDIR)/include/cross-mipsel-linux.cmake .. \
	)

clean:
	if [ -d $(SRC_NAME)/build ] ; then \
		rm -rf $(SRC_NAME)/build ; \
	fi ; \
	rm -f config_done
	rm -rf install

romfs:
ifeq ($(CONFIG_FIRMWARE_INCLUDE_TRANSMISSION_WEB_CONTROL),y)
	mkdir -p $(INSTALLDIR)/usr/share/transmission
#	cp -rf $(THISDIR)/transmission-control/web $(INSTALLDIR)/usr/share/transmission
	cp -rf $(THISDIR)/transmission-control/public_html $(INSTALLDIR)/usr/share/transmission
else
	cp -rf $(THISDIR)/install/usr/share/transmission $(INSTALLDIR)/usr/share
	rm -f $(INSTALLDIR)/usr/share/transmission/web/LICENSE
endif
	$(ROMFSINST) $(THISDIR)/install/bin/transmission-daemon /usr/bin/transmission-daemon
	$(ROMFSINST) -p +x /usr/bin/transmission.sh
