[![Build Status](https://travis-ci.com/hanwckf/rt-n56u.svg?branch=master)](https://travis-ci.com/hanwckf/rt-n56u)
![GitHub All Releases](https://img.shields.io/github/downloads/hanwckf/rt-n56u/total)
[![release](https://img.shields.io/github/release/hanwckf/rt-n56u.svg)](https://github.com/hanwckf/rt-n56u/releases)

# README #

### UI预览 ###
[![cKY0w4.png](https://z3.ax1x.com/2021/04/04/cKY0w4.png)](https://imgtu.com/i/cKY0w4)


### 特别说明 ###
* 汉化字典来自 https://github.com/gorden5566/padavan

***

### 固件特点 ###
- 使用[gorden5566](https://github.com/gorden5566/padavan)的汉化字典
- [aria2](https://github.com/aria2/aria2)可选使用较新版本的预编译程序 ```CONFIG_FIRMWARE_INCLUDE_ARIA2_NEW_PREBUILD_BIN```
- aria2前端更换为[AriaNg](https://github.com/mayswind/AriaNg)
- [curl](https://github.com/curl/curl)可选编译可执行程序```CONFIG_FIRMWARE_INCLUDE_CURL```
- 使用了[PROMETHEUS](http://pm.freize.net/index.html)提供的部分补丁，包括新版本的类库、软件包和WIFI驱动补丁
- 使用了[Linaro1985/padavan-ng](https://github.com/Linaro1985/padavan-ng)的部分软件包
### 固件管理 ###
- 我编译的固件后台管理地址:
```shell 
10.32.0.1 
user: admin
password: admin
```

- 已额外适配除官方适配外的以下机型
>- MI-3 (USB)
>- MI-3MI (USB) ```小米路由3硬改SOP flash 16mb```
>- MI-3A
>- MI-3C
>- MI-4C
>- MI-4A-100M
- 小米路由3C 网口以及LED灯配置分别如下
>- wlan and lan: >>>>> kernel-3.4.x.config
```shell
# CONFIG_RAETH_ESW_IGMP_SNOOP_OFF is not set
CONFIG_RAETH_ESW_IGMP_SNOOP_SW=y
CONFIG_RAETH_ESW_PORT_WAN=0
CONFIG_RAETH_ESW_PORT_LAN1=4
CONFIG_RAETH_ESW_PORT_LAN2=2
CONFIG_RAETH_ESW_PORT_LAN3=3
CONFIG_RAETH_ESW_PORT_LAN4=1
```
>- led: >>>> board.h
```shell
#undef  BOARD_GPIO_LED_ALL 
#define BOARD_GPIO_LED_WIFI	11
#define BOARD_GPIO_LED_POWER	24	/* 24: blue, 26: yellow, 29: red */
#undef  BOARD_GPIO_LED_LAN
#undef  BOARD_GPIO_LED_WAN
```

- 小米路由4C 网口以及LED灯配置分别如下
>- wlan and lan: >>>>> kernel-3.4.x.config
```shell
# CONFIG_RAETH_ESW_IGMP_SNOOP_OFF is not set
CONFIG_RAETH_ESW_IGMP_SNOOP_SW=y
CONFIG_RAETH_ESW_PORT_WAN=1
CONFIG_RAETH_ESW_PORT_LAN1=4
CONFIG_RAETH_ESW_PORT_LAN2=2
CONFIG_RAETH_ESW_PORT_LAN3=3
CONFIG_RAETH_ESW_PORT_LAN4=0
```
>- led: >>>> board.h
```shell
#undef  BOARD_GPIO_LED_ALL 
#define BOARD_GPIO_LED_WIFI	11
#define BOARD_GPIO_LED_POWER	24	/* 24: blue, 26: yellow, 29: red */
#undef  BOARD_GPIO_LED_LAN
#undef  BOARD_GPIO_LED_WAN
```
***

### 编译说明 ###

* 安装依赖包
```shell
sudo apt-get update
sudo apt-get install unzip libtool curl cmake gperf gawk flex bison nano \
git python-docutils gettext automake autopoint texinfo build-essential fakeroot \
pkg-config zlib1g-dev libgmp3-dev libmpc-dev libmpfr-dev libncurses5-dev libltdl-dev
```
* 克隆源码
```shell
git clone --depth=1 https://github.com/yuos-bit/Padavan.git /opt/rt-n56u
#git clone --depth=1 https://github.com/yuos-bit/Padavan.git /opt/rt-n56u
```
* 编译工具链
```shell
cd /opt/rt-n56u/toolchain-mipsel
./clean_sources
./build_toolchain_3.4.x
```
* (可选)修改机型配置文件
```shell
nano /opt/rt-n56u/trunk/configs/templates/PSG1218.config
```
* 清理代码树并开始编译
```shell
cd /opt/rt-n56u/trunk
sudo ./clear_tree
fakeroot ./build_firmware_modify PSG1218
#脚本第一个参数为路由型号，在trunk/configs/templates/中
#编译好的固件在trunk/images里
```

***

### 请参阅 ###
- https://yuos.top/index.php/archives/11/
- https://yuos.top/index.php/archives/208/
