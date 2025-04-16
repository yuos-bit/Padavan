SRC_NAME=ngtcp2-1.11.0
SRC_URL=https://github.com/ngtcp2/ngtcp2/releases/download/v1.11.0/$(SRC_NAME).tar.xz

CFLAGS += -fPIC
CXXFLAGS += -fPIC

#all: download_test extract_test config_test
all: config_test
	$(MAKE) -j$(HOST_NCPU) -C $(SRC_NAME)/build

download_test:
	( if [ ! -f $(SRC_NAME).tar.gz ]; then \
		wget -t5 --timeout=20 --no-check-certificate -O $(SRC_NAME).tar.xz $(SRC_URL); \
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
		-DENABLE_EXAMPLES=OFF \
		-DENABLE_STATIC_LIB=ON \
		-DENABLE_SHARED_LIB=OFF \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_TOOLCHAIN_FILE=$(ROOTDIR)/include/cross-mipsel-linux.cmake .. \
	)

clean:
	if [ -d $(SRC_NAME)/build ] ; then \
		rm -rf $(SRC_NAME)/build ; \
	fi ; \
	rm -f config_done

install:
	$(MAKE) -C $(SRC_NAME)/build install DESTDIR=$(STAGEDIR)

romfs:
