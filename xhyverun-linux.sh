#!/bin/sh

set -ex

KERNEL="./test/vmlinuz"
INITRD="./test/initrd.gz"
CMDLINE="earlyprintk=serial console=ttyS0"
MEM="-m 1G"
PCI_DEV="-s 0:0,hostbridge -s 31,lpc"
LPC_DEV="-l com1,stdio"
ACPI="-A"

# Linux
./build/xhyve ${ACPI} ${MEM} ${SMP} ${PCI_DEV} ${LPC_DEV} ${NET} ${IMG_CD} ${IMG_HDD} ${UUID} -f kexec,${KERNEL},${INITRD},"${CMDLINE}"
