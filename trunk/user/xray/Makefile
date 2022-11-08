THISDIR = $(shell pwd)
xray_dir="xray.com/core/main"
export GO111MODULE=on
export GOPROXY=https://goproxy.cn
xray_SED_ARGS:=
xray_SED_ARGS += \
	s/_ "xray.com\/core\/main\/json"/\/\/ &/; \
	/\/\/ _ "xray.com\/core\/main\/jsonem"/s/\/\/ //;
xray_SED_ARGS += \
	s/_ "xray.com\/core\/main\/json"/\/\/ &/;
xray_VERSION := 1.6.1
xray_URL := https://codeload.github.com/xtls/xray-core/tar.gz/v$(xray_VERSION)

all:download_xray build_extract build_xray

download_xray:
	(if [ ! -f $(THISDIR)/xray ]; then \
		if [ ! -f $(THISDIR)/Xray-core-$(xray_VERSION).tar.gz ]; then \
			curl --create-dirs -L $(xray_URL) -o $(THISDIR)/Xray-core-$(xray_VERSION).tar.gz ; \
		fi \
	fi )
	
build_extract:
	( if [ ! -f $(THISDIR)/xray ]; then \
		mkdir -p $(THISDIR)/xray.com ; \
		mkdir -p $(THISDIR)/bin ; \
	( if [ ! -d $(THISDIR)/xray.com/core ]; then \
	tar zxfv $(THISDIR)/Xray-core-$(xray_VERSION).tar.gz -C $(THISDIR)/xray.com ; \
	mv $(THISDIR)/xray.com/Xray-core-$(xray_VERSION) $(THISDIR)/xray.com/core ; \
		fi ) \
	fi )

build_xray:
	( if [ ! -f $(THISDIR)/xray ]; then \
		( cd $(THISDIR)/$(xray_dir); \
		sed -i \
			'$(xray_SED_ARGS)' \
			distro/all/all.go ; \
		GOOS=linux GOARCH=mipsle go build -ldflags "-s -w -buildid=" -o $(THISDIR)/bin/xray; \
		)\
	fi )
	
clean:
	rm -rf $(THISDIR)/xray.com
	rm -rf $(THISDIR)/bin
	
romfs:
	( if [ ! -f $(THISDIR)/xray ]; then \
		$(ROMFSINST) -p +x $(THISDIR)/bin/xray /usr/bin/v2ray ;\
		$(ROMFSINST) -p +x $(THISDIR)/bin/xray_softfloat /usr/bin/xray_softfloat ;\
	else \
		$(ROMFSINST) -p +x $(THISDIR)/xray /usr/bin/v2ray ;\
		$(ROMFSINST) -p +x $(THISDIR)/xray_softfloat /usr/bin/xray_softfloat ;\
	fi )
