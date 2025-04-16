#
# CMake Toolchain file for crosscompiling on mipsel.
#
# This can be used when running cmake in the following way:
#  cd build/
#  cmake .. -DCMAKE_TOOLCHAIN_FILE=../cross-mipsel-linux.cmake

# ------------------------------------------------------------
# [必须修改 1/3] 定义标准安装路径（Transmission 4.0.5 依赖这些变量）
# ------------------------------------------------------------
set(CMAKE_INSTALL_BINDIR "/bin")
set(CMAKE_INSTALL_LIBDIR "/lib")
set(CMAKE_INSTALL_INCLUDEDIR "/include")
set(CMAKE_INSTALL_DATADIR "/share")
set(CMAKE_INSTALL_MANDIR "/share/man")

# ------------------------------------------------------------
# 保留原有交叉编译环境配置
# ------------------------------------------------------------
set(CROSS_PATH $ENV{CONFIG_CROSS_COMPILER_ROOT})
set(ENV{PKG_CONFIG_PATH} "$ENV{PKG_CONFIG_PATH}:$ENV{STAGEDIR}/lib/pkgconfig")

# Target operating system name.
set(CMAKE_SYSTEM_NAME Linux)

# Name of C compiler.
set(CMAKE_C_COMPILER "${CROSS_PATH}/bin/mipsel-linux-uclibc-gcc")
set(CMAKE_CXX_COMPILER "${CROSS_PATH}/bin/mipsel-linux-uclibc-g++")

# ------------------------------------------------------------
# [必须修改 2/3] 扩展库/头文件搜索路径（新增内核路径）
# ------------------------------------------------------------
set(CMAKE_FIND_ROOT_PATH 
    "${CROSS_PATH}"            # 工具链目录
    "$ENV{STAGEDIR}"           # 已编译的依赖库
    "$ENV{ROOTDIR}/$ENV{LINUXDIR}"  # 内核头文件路径（解决 WITH_INOTIFY=ON 依赖）
)

# Adjust the default behavior of the FIND_XXX() commands:
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

# ------------------------------------------------------------
# [必须修改 3/3] 正确传递编译参数（关键修改！）
# 注意：替换原有的 add_definitions 方式
# ------------------------------------------------------------
# 传递 CFLAGS（包含优化选项和 CPU 特性）
set(CMAKE_C_FLAGS "$ENV{CFLAGS} $ENV{CPUFLAGS}")
set(CMAKE_CXX_FLAGS "$ENV{CFLAGS} $ENV{CPUFLAGS}")

# 传递 LDFLAGS（包含链接优化选项）
set(CMAKE_EXE_LINKER_FLAGS "$ENV{LDFLAGS}")

# 保留旧的 add_definitions 作为兼容（如有特殊宏定义需求）
if(DEFINED ENV{CPUFLAGS})
  add_definitions($ENV{CPUFLAGS})
endif()