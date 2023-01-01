include $(ROOTDIR)/coustom
THISDIR = $(shell pwd)
#export GO111MODULE=on
#export GOPROXY=https://goproxy.bj.bcebos.com/
Xray_VERSION := 1.5.3
Xray_URL := https://codeload.github.com/XTLS/Xray-core/tar.gz/v$(Xray_VERSION)
Xray_dir = xray-core/Xray-core-$(Xray_VERSION)/main
ifeq ($(GITHUB_ACTION),n)
all:download_xray build_extract build_Xray

download_xray:
	( if [ ! -f $(THISDIR)/xray ]; then \
	curl --create-dirs -L $(Xray_URL) -o $(THISDIR)/Xray-core-$(Xray_VERSION).tar.gz ; \
	fi )

build_extract:
	( if [ ! -f $(THISDIR)/xray ]; then \
	    mkdir -p $(THISDIR)/xray-core ; \
    	mkdir -p $(THISDIR)/bin ; \
	        ( if [ ! -d $(THISDIR)/xray-core/Xray-core-$(Xray_VERSION) ]; then \
	            rm -rf $(THISDIR)/xray-core/* ; \
	            tar zxfv $(THISDIR)/Xray-core-$(Xray_VERSION).tar.gz -C $(THISDIR)/xray-core ; \
	            fi ) \
	fi )

build_Xray:
    ( if [ ! -f $(THISDIR)/xray ]; then \
    	( cd $(THISDIR)/$(Xray_dir); \
    	if [ $(GOPROXY_ON) = "y" ]; then \
    	    go env -w GOPROXY=https://goproxy.cn,direct ; \
    	fi ; \
	        GOOS=linux GOARCH=mipsle go build -ldflags "-w -s" -o $(THISDIR)/bin/xray; \
	)
	fi )
else
all:
endif
clean:
	rm -rf $(THISDIR)/xray-core
	rm -rf $(THISDIR)/bin

romfs:
ifeq ($(GITHUB_ACTION),n)	
	$(ROMFSINST) -p +x $(THISDIR)/bin/xray /usr/bin/v2ray
else
	$(ROMFSINST) -p +x $(THISDIR)/xray /usr/bin/v2ray
endif