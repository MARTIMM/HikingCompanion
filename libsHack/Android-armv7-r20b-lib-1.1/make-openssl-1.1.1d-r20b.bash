#!/usr/bin/env bash

set -e


###############################################################################
# https://android.gadgethacks.com/how-to/android-basics-see-what-kind-processor-you-have-arm-arm64-x86-0168051/
# installed app: droid info
#
# https://developer.android.com/ndk/guides/other_build_systems
###############################################################################
# Cross-compile environment for Android
#
# Tablet;
#   Device name:  Galaxy Tab A
#   Model number: SM-T550
#   Version:      7.1.1     => api 25
#   Cpu architecture:   ARMv7 processor revision 0 (v7I)
#   Instruction set:    armeabi-v7a, armeabi
#
###############################################################################
ssl="1.1.1d"

ndk=r20b                          # developer kit
tc=arm-linux-androideabi          # toolchain = processor os instr. set
tcv=4.9                           # toolchain version

# tabel from https://developer.android.com/ndk/guides/other_build_systems
# toolchain prebuild = host
#tcpb=darwin-x86_64                # macOS
tcpb=linux-x86_64                 # linux
#tcpb=windows                      # 32-bit windows
#tcpb=windows-x86_64               # 64-bit windows

pf=android-arm                    # platform = target processor
api=24

# tabel from https://developer.android.com/ndk/guides/other_build_systems
triple=armv7a-linux-androideabi   # for armeabi-v7a
#triple=aarch64-linux-android      # arm64-v8a
#triple=i686-linux-android         # x86
#triple=x86_64-linux-android       # x86_64-v8a

home=/opt/google/android-ndk-$ndk
#path=$home/toolchains/$tc-$tcv/prebuilt/$tcpb/bin
#clang=$home/toolchains/llvm/prebuilt/$tcpb/bin/$triple$api-clang
path=$home/toolchains/llvm/prebuilt/$tcpb/bin

ar=$tc$api-ar
clang=$triple$api-clang
ranlib=$tc-ranlib

export ANDROID_NDK_HOME=$home
export PATH=$path:$PATH



cd openssl-$ssl-$ndk
# Do following once in the openssl directory
#make clean
./Configure $pf -D__ANDROID_API__=$api \
  AR=$ar CC=$clang RANLIB=$path/$tc-ranlib \
  -I$home/sysroot/usr/include \
  -I$home/sysroot/usr/include/$tc

make




# Configure LIST | grep android --> list of android platforms (processor)
# android-arm
# android-arm64
# android-armeabi
# android-mips
# android-mips64
# android-x86
# android-x86_64
# android64
# android64-aarch64
# android64-mips64
# android64-x86_64

# must have <ndk>/platforms/<api>/<platform>















exit 0

# Set ANDROID_NDK_ROOT to your NDK location.
#ANDROID_NDK_ROOT="/opt/google/android-ndk-r10e"
#ANDROID_NDK_ROOT="/opt/google/android-ndk-r17b"
#ANDROID_NDK_ROOT="/opt/google/android-ndk-r17c"
#ANDROID_NDK_ROOT="/opt/google/android-ndk-r18b"
ANDROID_NDK_ROOT="/opt/google/android-ndk-r20b"
export ANDROID_NDK_HOME="/opt/google/android-ndk-r20b"

# Set _ANDROID_EABI to the EABI you want to use. You can find the
# list in $ANDROID_NDK_ROOT/toolchains. This value is always used.
# _ANDROID_EABI="x86-4.6"
# _ANDROID_EABI="arm-linux-androideabi-4.6"
_ANDROID_EABI="arm-linux-androideabi-4.9"

# Set _ANDROID_ARCH to the architecture you are building for.
# This value is always used.
# _ANDROID_ARCH=arch-x86
_ANDROID_ARCH=arch-arm

# Set _ANDROID_API to the API you want to use. You should set it
# to one of: android-14, android-9, android-8, android-14, android-5
# android-4, or android-3. You can't set it to the latest (for
# example, API-17) because the NDK does not supply the platform. At
# Android 5.0, there will likely be another platform added (android-22?).
# This value is always used.
# _ANDROID_API="android-14"
# _ANDROID_API="android-18"

# Must have 25 but there wheren't any changes so was left out of NDK
_ANDROID_API="android-24"

###############################################################################
# Error checking
# ANDROID_NDK_ROOT should always be set by the user (even when not running
# this script) http://groups.google.com/group/android-ndk/browse_thread/thread/a998e139aca71d77
###############################################################################
if [ -z "$ANDROID_NDK_ROOT" ] || [ ! -d "$ANDROID_NDK_ROOT" ]; then
  echo "Error: ANDROID_NDK_ROOT is not a valid path. Please edit this script."
  echo "$ANDROID_NDK_ROOT"
  exit 1
fi

# Error checking
if [ ! -d "$ANDROID_NDK_ROOT/toolchains" ]; then
  echo "Error: ANDROID_NDK_ROOT/toolchains is not a valid path. Please edit this script."
  echo "$ANDROID_NDK_ROOT/toolchains"
  exit 1
fi

# Error checking
if [ ! -d "$ANDROID_NDK_ROOT/toolchains/$_ANDROID_EABI" ]; then
  echo "Error: ANDROID_EABI is not a valid path. Please edit this script."
  echo "$ANDROID_NDK_ROOT/toolchains/$_ANDROID_EABI"
  exit 1
fi

###############################################################################
# Based on ANDROID_NDK_ROOT, try and pick up the required toolchain. We expect
# something like:  /opt/android-ndk-r83/toolchains/arm-linux-androideabi-4.7/prebuilt/linux-x86_64/bin
# Once we locate the toolchain, we add it to the PATH. Note: this is the 'hard
# way' of doing things according to the NDK documentation for Ice Cream
# Sandwich.  https://android.googlesource.com/platform/ndk/+/ics-mr0/docs/STANDALONE-TOOLCHAIN.html
###############################################################################
ANDROID_TOOLCHAIN=""
for host in "linux-x86_64" "linux-x86" "darwin-x86_64" "darwin-x86"
do
  if [ -d "$ANDROID_NDK_ROOT/toolchains/$_ANDROID_EABI/prebuilt/$host/bin" ]; then
    ANDROID_TOOLCHAIN="$ANDROID_NDK_ROOT/toolchains/$_ANDROID_EABI/prebuilt/$host/bin"
    break
  fi
done

# Error checking
if [ -z "$ANDROID_TOOLCHAIN" ] || [ ! -d "$ANDROID_TOOLCHAIN" ]; then
  echo "Error: ANDROID_TOOLCHAIN is not valid. Please edit this script."
  echo "$ANDROID_TOOLCHAIN"
  exit 1
fi

case $_ANDROID_ARCH in
	arch-arm)
      ANDROID_TOOLS="arm-linux-androideabi-gcc arm-linux-androideabi-ranlib arm-linux-androideabi-ld"
	  ;;
  arch-arm64)
      ANDROID_TOOLS="aarch64-linux-android-gcc aarch64-linux-android-ranlib aarch64-linux-android-ld"
    ;;
	arch-x86)
      ANDROID_TOOLS="i686-linux-android-gcc i686-linux-android-ranlib i686-linux-android-ld"
	  ;;
	*)
	  echo "ERROR ERROR ERROR"
	  ;;
esac

for tool in $ANDROID_TOOLS
do
  # Error checking
  if [ ! -e "$ANDROID_TOOLCHAIN/$tool" ]; then
    echo "Error: Failed to find $tool. Please edit this script."
    # echo "$ANDROID_TOOLCHAIN/$tool"
    # exit 1
  fi
done

# Only modify/export PATH if ANDROID_TOOLCHAIN good
if [ ! -z "$ANDROID_TOOLCHAIN" ]; then
  export ANDROID_TOOLCHAIN="$ANDROID_TOOLCHAIN"
  export PATH="$ANDROID_TOOLCHAIN":"$PATH"
fi

#####################################################################
# For the Android SYSROOT. Can be used on the command line with --sysroot
# https://android.googlesource.com/platform/ndk/+/ics-mr0/docs/STANDALONE-TOOLCHAIN.html

export ANDROID_SYSROOT="$ANDROID_NDK_ROOT/platforms/$_ANDROID_API/$_ANDROID_ARCH"
export CROSS_SYSROOT="$ANDROID_SYSROOT"
export NDK_SYSROOT="$ANDROID_SYSROOT"
#echo "sysroot: $ANDROID_SYSROOT"

# Error checking
if [ -z "$ANDROID_SYSROOT" ] || [ ! -d "$ANDROID_SYSROOT" ]; then
  echo "Error: ANDROID_SYSROOT is not valid. Please edit this script."
  # echo "$ANDROID_SYSROOT"
  # exit 1
fi

#####################################################################
# If the user did not specify the FIPS_SIG location, try and pick it up
# If the user specified a bad location, then try and pick it up too.
if [ -z "$FIPS_SIG" ] || [ ! -e "$FIPS_SIG" ]; then

  # Try and locate it
  _FIPS_SIG=""
  if [ -d "/usr/local/ssl/$_ANDROID_API" ]; then
    _FIPS_SIG=`find "/usr/local/ssl/$_ANDROID_API" -name incore`
  fi

  if [ ! -e "$_FIPS_SIG" ]; then
    _FIPS_SIG=`find $PWD -name incore`
  fi

  # If a path was set, then export it
  if [ ! -z "$_FIPS_SIG" ] && [ -e "$_FIPS_SIG" ]; then
    export FIPS_SIG="$_FIPS_SIG"
  fi
fi

## Error checking. Its OK to ignore this if you are *not* building for FIPS
#if [ -z "$FIPS_SIG" ] || [ ! -e "$FIPS_SIG" ]; then
#  echo "Error: FIPS_SIG does not specify incore module. Please edit this script."
#  # echo "$FIPS_SIG"
#  # exit 1
#fi

#####################################################################
# (Remark MT  2018-12-14: Are all these vars needed by openssl???)

# Most of these should be OK (MACHINE, SYSTEM, ARCH). RELEASE is ignored.
export MACHINE=armv7
export RELEASE=2.6.37
export SYSTEM=android
export ARCH=arm
export CROSS_COMPILE="arm-linux-androideabi-"

if [ "$_ANDROID_ARCH" == "arch-x86" ]; then
	export MACHINE=i686
	export RELEASE=2.6.37
	export SYSTEM=android
	export ARCH=x86
	export CROSS_COMPILE="i686-linux-android-"
fi

if [ "$_ANDROID_ARCH" == "arch-arm64" ]; then
  export MACHINE=armv8
  export RELEASE=2.6.37
  export SYSTEM=android64
  export ARCH=arm
  export CROSS_COMPILE="aarch64-linux-android-"
fi

# For the Android toolchain
# https://android.googlesource.com/platform/ndk/+/ics-mr0/docs/STANDALONE-TOOLCHAIN.html
export ANDROID_SYSROOT="$ANDROID_NDK_ROOT/platforms/$_ANDROID_API/$_ANDROID_ARCH"
export SYSROOT="$ANDROID_SYSROOT"
export NDK_SYSROOT="$ANDROID_SYSROOT"
export ANDROID_NDK_SYSROOT="$ANDROID_SYSROOT"
export ANDROID_API="$_ANDROID_API"

# CROSS_COMPILE and ANDROID_DEV are DFW (Don't Fiddle With). Its used by OpenSSL build system.
# export CROSS_COMPILE="arm-linux-androideabi-"
export ANDROID_DEV="$ANDROID_NDK_ROOT/platforms/$_ANDROID_API/$_ANDROID_ARCH/usr"
export HOSTCC=gcc

VERBOSE=1
if [ ! -z "$VERBOSE" ] && [ "$VERBOSE" != "0" ]; then
  echo "ANDROID_NDK_ROOT: $ANDROID_NDK_ROOT"
  echo "ANDROID_ARCH: $_ANDROID_ARCH"
  echo "ANDROID_EABI: $_ANDROID_EABI"
  echo "ANDROID_API: $ANDROID_API"
  echo "ANDROID_SYSROOT: $ANDROID_SYSROOT"
  echo "ANDROID_TOOLCHAIN: $ANDROID_TOOLCHAIN"
  echo "FIPS_SIG: $FIPS_SIG"
  echo "CROSS_COMPILE: $CROSS_COMPILE"
  echo "ANDROID_DEV: $ANDROID_DEV"
fi
#exit 0

cd openssl-1.1.1d-r20b
# Do following once in the openssl directory
make clean
./Configure android-armeabi \
  -I$ANDROID_NDK_ROOT/sysroot/usr/include/arm-linux-androideabi \
  -I$ANDROID_NDK_ROOT/sysroot/usr/include \
  shared no-ssl2 no-ssl3 no-asm no-hw no-engine no-threads \
  no-psk no-srp
make CALC_VERSIONS="SHLIB_COMPAT=; SHLIB_SOVER=" build_libs
