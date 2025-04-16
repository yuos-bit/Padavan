###############################################################################
# Makefile for Transmission 4.0.5
#
# 说明：
# - 基于老版本增加新版缺失的参数，调优配置使新版行为尽量与老版一致。
# - 保持工具链文件参数： -DCMAKE_TOOLCHAIN_FILE=../../cross-mipsel-linux.cmake
# - 保持 daemon 文件安装路径： $(THISDIR)/install/usr/bin/transmission-daemon
# - 补丁文件 disabled-examples-in-cmakelists.patch 位于 trunk/libs/libngtcp2，
#   本 Makefile 位于 trunk/user/transmission，通过相对路径获取 trunk 目录。
###############################################################################

# TRUNK_DIR 用于确定 trunk 目录路径，相对于当前工作目录（trunk/user/transmission）
TRUNK_DIR := $(CURDIR)/../..

SRC_NAME = transmission-4.0.5
SRC_URL  = https://github.com/transmission/transmission/releases/download/4.0.5/transmission-4.0.5.tar.xz

# 保留老版本中的编译优化参数（大文件支持、函数/数据区段优化等）
CFLAGS   += -O2 -ffunction-sections -fdata-sections -fvisibility=hidden \
            -D_LARGEFILE64_SOURCE -D_LFS64_LARGEFILE -Wno-implicit-fallthrough
LDFLAGS  += -Wl,--gc-sections

THISDIR  = $(shell pwd)

###############################################################################
# 默认构建流程：下载、解压、配置、编译与安装
###############################################################################
all: download_test extract_test config_test
	$(MAKE) -j$(HOST_NCPU) -C $(SRC_NAME)/build && \
	$(MAKE) -C $(SRC_NAME)/build install DESTDIR=$(THISDIR)/install

###############################################################################
# 下载源码包
###############################################################################
download_test:
	@if [ ! -f $(SRC_NAME).tar.xz ]; then \
		wget -t5 --timeout=20 --no-check-certificate -O $(SRC_NAME).tar.xz $(SRC_URL); \
	fi

###############################################################################
# 解压源码并应用补丁
# 补丁文件位于 $(TRUNK_DIR)/libs/libngtcp2/disabled-examples-in-cmakelists.patch
###############################################################################
extract_test:
	@if [ ! -d $(SRC_NAME) ]; then \
		tar -xf $(SRC_NAME).tar.xz; \
		patch -p1 -d $(SRC_NAME) < $(TRUNK_DIR)/libs/libngtcp2/disabled-examples-in-cmakelists.patch; \
		# 保留老版本 miniupnpc 头文件处理步骤
		mkdir -p $(SRC_NAME)/third-party/miniupnpc/include/miniupnp; \
		cp -r $(SRC_NAME)/third-party/miniupnpc/*.h $(SRC_NAME)/third-party/miniupnpc/include/miniupnp; \
	fi

###############################################################################
# 配置测试（防止重复执行配置）
###############################################################################
config_test:
	@if [ -f ./config_done ]; then \
		echo "the same configuration"; \
	else \
		$(MAKE) configure && touch config_done; \
	fi

###############################################################################
# 配置阶段（使用 CMake）
# 保留原有工具链文件参数，同时增加老版本中的参数：
#   - ENABLE_DAEMON=ON、USE_SYSTEM_MINIUPNPC=OFF、USE_SYSTEM_NATPMP=OFF、USE_SYSTEM_UTP=OFF、
#     WITH_SYSTEMD=OFF、WITH_INOTIFY=ON、以及 WITH_CRYPTO=openssl
###############################################################################
configure:
	@mkdir -p $(SRC_NAME)/build && cd $(SRC_NAME)/build; \
	cmake \
          -DCMAKE_TOOLCHAIN_FILE=../../cross-mipsel-linux.cmake \
          -DCMAKE_INSTALL_PREFIX=/usr \
          -DCMAKE_BUILD_TYPE=Release \
          -DENABLE_CLI=OFF \
          -DENABLE_DAEMON=ON \
          -DENABLE_GTK=OFF \
          -DENABLE_LIGHTWEIGHT=ON \
          -DENABLE_NLS=OFF \
          -DENABLE_QT=OFF \
          -DENABLE_TESTS=OFF \
          -DINSTALL_DOC=OFF \
          -DUSE_SYSTEM_MINIUPNPC=OFF \
          -DUSE_SYSTEM_NATPMP=OFF \
          -DUSE_SYSTEM_UTP=OFF \
          -DWITH_SYSTEMD=OFF \
          -DWITH_INOTIFY=ON \
          -DWITH_CRYPTO=openssl \
          ..

###############################################################################
# 清理构建生成的文件
###############################################################################
clean:
	@if [ -f $(SRC_NAME)/Makefile ]; then \
		$(MAKE) -C $(SRC_NAME) clean; \
	fi
	@rm -f config_done
	@rm -rf install

###############################################################################
# ROMFS 目标：拷贝 WEB 控制文件和 daemon
# 保持 daemon 文件路径为 $(THISDIR)/install/usr/bin/transmission-daemon
###############################################################################
romfs:
ifeq ($(CONFIG_FIRMWARE_INCLUDE_TRANSMISSION_WEB_CONTROL),y)
	mkdir -p $(INSTALLDIR)/usr/share/transmission
	cp -rf $(THISDIR)/transmission-control/web $(INSTALLDIR)/usr/share/transmission
else
	cp -rf $(THISDIR)/install/usr/share/transmission $(INSTALLDIR)/usr/share
	rm -f $(INSTALLDIR)/usr/share/transmission/web/LICENSE
endif
	$(ROMFSINST) $(THISDIR)/install/usr/bin/transmission-daemon /usr/bin/transmission-daemon
	$(ROMFSINST) -p +x /usr/bin/transmission.sh
