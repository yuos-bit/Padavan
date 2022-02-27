FIRMWARE_ROOTFS_VER=3.9
FIRMWARE_BUILDS_VER=099_$(shell date +%Y%m%d)_$(shell git rev-parse --short HEAD 2>/dev/null)
FIRMWARE_BUILDS_REV=$(shell git rev-parse --short HEAD 2>/dev/null)
