[![Build Status](https://travis-ci.com/hanwckf/rt-n56u.svg?branch=master)](https://travis-ci.com/hanwckf/rt-n56u)
![GitHub All Releases](https://img.shields.io/github/downloads/hanwckf/rt-n56u/total)
[![release](https://img.shields.io/github/release/hanwckf/rt-n56u.svg)](https://github.com/hanwckf/rt-n56u/releases)

# README #

### UI预览 ###
[![b84Ru4.jpg](https://s4.ax1x.com/2022/03/02/b84Ru4.jpg)](https://imgtu.com/i/b84Ru4)


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
### 编译说明 ###

* 安装依赖包
```shell
sudo apt-get update
sudo apt install unzip libtool-bin curl cmake gperf gawk flex bison nano xxd \
    fakeroot kmod cpio git python3-docutils gettext automake autopoint \
    texinfo build-essential help2man pkg-config zlib1g-dev libgmp3-dev \
    libmpc-dev libmpfr-dev libncurses5-dev libltdl-dev wget libc-dev-bin libctf-nobfd0 libcunit1-dev libhdf5-dev libopenblas-dev -y
```
* 克隆源码
```shell
git clone --depth=1 https://github.com/yuos-bit/Padavan.git

#git clone --depth=1 https://github.com/yuos-bit/Padavan.git /opt/rt-n56u
```
* 编译工具链
```shell
cd /opt/rt-n56u/toolchain-mipsel

# （推荐）使用脚本下载预编译的工具链：
sh dl_toolchain.sh

# 或者，也可以从源码编译工具链，这需要一些时间：
./clean_toolchain
./build_toolchain

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
- 已额外适配除官方适配外的以下机型
>- MI-3 (USB)
>- MI-3MI (USB) ```小米路由3硬改SOP flash 16mb```
>- MI-3A
>- MI-3C
>- MI-4C
>- MI-4A-100M
>- MI-R4A```小米路由4A千兆版```
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
### 捐贈

***
<center><b>如果你觉得此项目对你有帮助，可以捐助我，用爱发电也挺难的，哈哈。</b></center>

|  微信   | 支付宝  |
|  ----  | ----  |
| ![](https://pic.imgdb.cn/item/62502707239250f7c5b8ac3d.png) | ![](https://pic.imgdb.cn/item/62502707239250f7c5b8ac36.png) |

## 赞助名单

![](https://pic.imgdb.cn/item/625028c0239250f7c5bd102b.jpg)
感谢以上大佬的充电！

### 关于报错
* 报错 1
```shell
/opt/rt-n56u/trunk/libs/libpcre/pcre-8.43/missing: line 81: aclocal-1.16: command not found
WARNING: 'aclocal-1.16' is missing on your system.
         You should only need it if you modified 'acinclude.m4' or
         'configure.ac' or m4 files included by 'configure.ac'.
         The 'aclocal' program is part of the GNU Automake package:
         <https://www.gnu.org/software/automake>
         It also requires GNU Autoconf, GNU m4 and Perl in order to run:
         <https://www.gnu.org/software/autoconf>
         <https://www.gnu.org/software/m4/>
         <https://www.perl.org/>
Makefile:1438: recipe for target 'aclocal.m4' failed
make[3]: *** [aclocal.m4] Error 127
```
* 解决方案
```shell
cd /opt/rt-n56u/trunk/libs/libpcre/pcre-8.43
autoreconf -ivf
```
* 报错 2
```shell
/opt/rt-n56u/trunk/.config: line 237: CONFIG_FIRMWARE_INCLUDE_LRZSZ: command not found
```
* 解决方案
```shell
rm -rf /opt/rt-n56u/trunk/.config
```
***

### 请参阅 ###
- https://yuos.top/index.php/archives/11/
- https://yuos.top/index.php/archives/208/
