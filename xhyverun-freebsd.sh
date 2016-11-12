#!/bin/sh

if [ $# -lt 1 ]; then
  echo "Please provide a bath to a boot-volume" 2>&1
  exit 1
fi

BOOTVOLUME="$1"

if [ ! -f ${BOOTVOLUME} ]; then
  echo "The given boot-volume \"${BOOTVOLUME}\" is not a regular file" 2>&1
  exit 1
fi

USERBOOT="./test/userboot.so"
KERNELENV=""

MEM="-m 1G"
SMP="-c 2"
NET="-s 2:0,virtio-net"
IMG_CD="-s 3,ahci-cd,${BOOTVOLUME}"
#IMG_HDD="-s 4,virtio-blk,/somepath/somefile.img"
PCI_DEV="-s 0:0,hostbridge -s 31,lpc"
LPC_DEV="-l com1,stdio"
ACPI="-A"
UUID="-U deadbeef-dead-dead-dead-deaddeafbeef"

# FreeBSD
./build/xhyve ${ACPI} ${MEM} ${SMP} ${PCI_DEV} ${LPC_DEV} ${NET} ${IMG_CD} ${IMG_HDD} ${UUID} -f fbsd,${USERBOOT},${BOOTVOLUME},"${KERNELENV}"
