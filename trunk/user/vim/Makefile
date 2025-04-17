include $(ROOTDIR)/coustom
THISDIR = $(shell pwd)
Vim_VERSION := 9.1.1263
Vim_URL := https://github.com/vim/vim/archive/refs/tags/v$(Vim_VERSION).tar.gz
VIM_BIN := vim
VIMRC := .vimrc
ifeq ($(GITHUB_ACTION),n)
all:download_vim build_extract build_Vim

download_vim:
	( if [ ! -f $(THISDIR)/vim ]; then \
	curl --create-dirs -L $(Vim_URL) -o $(THISDIR)/$(Vim_VERSION).tar.gz ; \
	fi )

build_extract:
	( if [ ! -f $(THISDIR)/vim ]; then \
	    mkdir -p $(THISDIR)/vim-core ; \
    	mkdir -p $(THISDIR)/bin ; \
	        ( if [ ! -d $(THISDIR)/vim-core/$(Vim_VERSION) ]; then \
	            rm -rf $(THISDIR)/vim-core/* ; \
	            tar zxfv $(THISDIR)/$(Vim_VERSION).tar.gz -C $(THISDIR)/vim-core ; \
	            fi ) \
	fi )

build_Vim:
    ( if [ ! -f $(THISDIR)/vim ]; then \
    	( cd $(THISDIR)/$(Vim_dir); \
    	if [ $(GOPROXY_ON) = "y" ]; then \
    	    go env -w GOPROXY=https://goproxy.cn,direct ; \
    	fi ; \
	        GOOS=linux GOARCH=mipsle go build -ldflags "-w -s" -o $(THISDIR)/bin/vim; \
	)
	fi )
else
all:
endif
clean:
	rm -rf $(THISDIR)/bin
romfs:
ifeq ($(GITHUB_ACTION),n)	
	$(ROMFSINST) -p +x $(THISDIR)/$(VIM_BIN) /usr/bin/vim
	$(ROMFSINST) $(THISDIR)/$(VIMRC) /etc/vimrc
	@echo "export VIMINIT=\"source /etc/vimrc\"" >> $(ROOTDIR)/romfs/etc/profile
else
	$(ROMFSINST) -p +x $(THISDIR)/$(VIM_BIN) /usr/bin/vim
	$(ROMFSINST) $(THISDIR)/$(VIMRC) /etc/vimrc
endif
