#
# CMake Toolchain file for crosscompiling on mipsel.
#
# This can be used when running cmake in the following way:
#  cd build/
#  cmake .. -DCMAKE_TOOLCHAIN_FILE=$(ROOTDIR)/cross-mipsel-linux.cmake

set(CROSS_PATH $ENV{CONFIG_TOOLCHAIN_DIR})
set(CMAKE_INSTALL_BINDIR "/bin")
set(CMAKE_INSTALL_LIBDIR "/lib")
set(CMAKE_INSTALL_INCLUDEDIR "/include")
set(CMAKE_INSTALL_DATADIR "/share")
set(CMAKE_INSTALL_MANDIR "/share/man")
#set(ENV{PKG_CONFIG_PATH} "$ENV{PKG_CONFIG_PATH}:$ENV{STAGEDIR}/lib/pkgconfig")
# Target operating system name.
set(CMAKE_SYSTEM_NAME Linux)

# Name of C compiler.
set(CMAKE_C_COMPILER "${CROSS_PATH}/bin/mipsel-linux-uclibc-gcc")
set(CMAKE_CXX_COMPILER "${CROSS_PATH}/bin/mipsel-linux-uclibc-g++")

# Where to look for the target environment. (More paths can be added here)
set(CMAKE_FIND_ROOT_PATH "${CROSS_PATH}" "$ENV{STAGEDIR}" "$ENV{ROOTDIR}/$ENV{LINUXDIR}" )

# Adjust the default behavior of the FIND_XXX() commands:
# search programs in the host environment only.
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# Search headers and libraries in the target environment only.
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

add_definitions($ENV{CPUFLAGS})
add_definitions($ENV{CFLAGS})
add_definitions($ENV{LDFLAGS})

