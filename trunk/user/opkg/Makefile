include $(ROOTDIR)/coustom
THISDIR = $(shell pwd)

ifeq ($(GITHUB_ACTION),n)
all:
	
else

all:
	
endif

clean:

	rm -rf $(THISDIR)/bin

romfs:
ifeq ($(GITHUB_ACTION),n)
	$(ROMFSINST) -d -m 755 /opt/bin
	$(ROMFSINST) -d -m 755 /opt/etc
	$(ROMFSINST) -p +x $(THISDIR)/opkg /usr/bin/opkg
	$(ROMFSINST) -p +x $(THISDIR)/opkg.conf /opt/etc/opkg.conf
else
    	$(ROMFSINST) -d -m 755 /opt/bin
    	$(ROMFSINST) -d -m 755 /opt/etc
    	$(ROMFSINST) -p +x $(THISDIR)/opkg /usr/bin/opkg
    	$(ROMFSINST) -p +x $(THISDIR)/opkg.conf /opt/etc/opkg.conf
endif
