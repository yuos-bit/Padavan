include $(ROOTDIR)/coustom
THISDIR = $(shell pwd)
VIM_BIN := vim
VIMRC := .vimrc

ifeq ($(GITHUB_ACTION),n)
all: prepare_romfs romfs
else
all:
endif

prepare_romfs:
	@if [ ! -f $(THISDIR)/$(VIMRC) ]; then \
		echo "Error: Missing .vimrc file!"; \
		exit 1; \
	fi

clean:
	rm -rf $(THISDIR)/$(VIM_BIN)

romfs:

ifeq ($(GITHUB_ACTION),n)
	$(ROMFSINST) -p +x $(THISDIR)/$(VIM_BIN) /usr/bin/vim
	$(ROMFSINST) $(THISDIR)/$(VIMRC) /etc/vimrc
	@echo "export VIMINIT=\"source /etc/vimrc\"" >> $(ROOTDIR)/romfs/etc/profile
else
	$(ROMFSINST) -p +x $(THISDIR)/$(VIM_BIN) /usr/bin/vim
	$(ROMFSINST) $(THISDIR)/$(VIMRC) /etc/vimrc
endif