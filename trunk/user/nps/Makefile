THISDIR := $(shell pwd)
NPS_VER := 0.26.10
NPS_URL_BASE :=https://github.com/ehang-io/nps/releases/download
NPS_NAME := linux_mipsle_client
NPS_URL= $(NPS_URL_BASE)/v$(NPS_VER)/$(NPS_NAME).tar.gz

all: download_test extract_test
	@echo "nps build done!"

download_test:
	( if [ ! -f $(NPS_NAME).tar.gz ]; then \
		wget -t5 --timeout=20 --no-check-certificate -O $(NPS_NAME).tar.gz $(NPS_URL); \
	fi )

extract_test:
	( if [ ! -d $(NPS_NAME) ]; then \
		tar xvf $(NPS_NAME).tar.gz; \
	fi )
 
clean:
	rm -rf $(NPS_NAME).tar.gz $(NPS_NAME)

romfs:
ifeq ($(CONFIG_FIRMWARE_INCLUDE_NPS),y)
	$(ROMFSINST) -p +x $(THISDIR)/$(NPS_NAME)/* /usr/bin/nps/*
endif
	$(ROMFSINST) -p +x $(THISDIR)/nps.sh /usr/bin/nps.sh
	$(ROMFSINST) /etc_ro/nps_script.sh