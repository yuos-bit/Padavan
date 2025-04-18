include $(ROOTDIR)/coustom
THISDIR = $(shell pwd)
VIM_BIN := vim
VIMRC := .vimrc
TERMINFODIR := $(THISDIR)/terminfo


ifeq ($(GITHUB_ACTION),n)
all:
	@echo "Nothing to build. Using local vim binary and vimrc."
else
all:
	@echo "GitHub Action build: nothing to do here."
endif
clean:

	rm -rf $(THISDIR)/bin

romfs:
ifeq ($(GITHUB_ACTION),n)	
	$(ROMFSINST) -p +x $(THISDIR)/$(VIM_BIN) /usr/bin/vim
	$(ROMFSINST) $(THISDIR)/$(VIMRC) /etc/vimrc
	$(ROMFSINST) -d -m 755 /usr/share/terminfo
	$(ROMFSINST) -r $(TERMINFODIR) /usr/share/terminfo
	
	@mkdir -p $(THISDIR)/romfs_patch
	echo 'export VIMINIT="source /etc/vimrc"' > $(THISDIR)/romfs_patch/profile_vim
	echo 'export TERMINFO=/usr/share/terminfo' >> $(THISDIR)/romfs_patch/profile_vim
	$(ROMFSINST) -p +x $(THISDIR)/romfs_patch/profile_vim /etc/storage/vim.sh
else
	$(ROMFSINST) -p +x $(THISDIR)/$(VIM_BIN) /usr/bin/vim
	$(ROMFSINST) $(THISDIR)/$(VIMRC) /etc/vimrc
	$(ROMFSINST) -d -m 755 /usr/share/terminfo
	$(ROMFSINST) -r $(TERMINFODIR) /usr/share/terminfo
endif
