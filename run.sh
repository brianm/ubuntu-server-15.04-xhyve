#!/bin/sh

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

KERNEL="$DIR/boot/vmlinuz-3.19.0-21-generic"
INITRD="$DIR/boot/initrd.img-3.19.0-21-generic"
CMDLINE="earlyprintk=serial console=ttyS0 acpi=off root=/dev/vda1 ro"

MEM="-m 1G"
#SMP="-c 2"
NET="-U 779a0668-6cce-4f3a-b943-6511e1591981 -s 2:0,virtio-net"
#IMG_CD="-s 3,ahci-cd,./ubuntu-15.04-server-amd64.iso"
IMG_HDD="-s 4,virtio-blk,$DIR/hdd.img"
PCI_DEV="-s 0:0,hostbridge -s 31,lpc"
LPC_DEV="-l com1,stdio"

xhyve $MEM $SMP $PCI_DEV $LPC_DEV $NET $IMG_CD $IMG_HDD -f kexec,$KERNEL,$INITRD,"$CMDLINE"
