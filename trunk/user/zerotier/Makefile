SRC_NAME = ZeroTierOne-1.14.0
THISDIR = $(shell pwd)
FLAGS := DEFS=""
CFLAGS := -Os -ffunction-sections -fdata-sections
LDFLAGS := -Wl,--gc-sections,--as-needed -static-libstdc++

all: 
	
extract_test:
	 
config_test:

clean:

romfs:
	$(ROMFSINST) -p +x $(THISDIR)/$(SRC_NAME) /usr/bin/zerotier-one
	$(ROMFSINST) -p +x $(THISDIR)/zerotier.sh /usr/bin/zerotier.sh
	ln -sf zerotier-one $(ROMFSDIR)/usr/bin/zerotier-cli
	ln -sf zerotier-one $(ROMFSDIR)/usr/bin/zerotier-idtool