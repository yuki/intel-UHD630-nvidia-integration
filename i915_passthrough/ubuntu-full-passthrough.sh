#!/bin/bash

ip tuntap add dev tap0 mode tap > /dev/null
ip link set up dev tap0
ip link set dev tap0 master vmbr0

# pasamos como passthrough el ratón y teclado secundarios

qemu-system-x86_64 -machine q35,accel=kvm -m 4G -enable-kvm -cpu host \
-smp "4",cores="1",sockets="1" \
-device vfio-pci,host=00:02.0 -nographic -vga none \
-netdev tap,id=net0,ifname=tap0,script=no,downscript=no -device e1000,netdev=net0 \
-cdrom ubuntu-20.04.2.0-desktop-amd64.iso

#-object input-linux,id=kbd,evdev=/dev/input/by-id/usb-Lenovo_Lenovo_Calliope_USB_Keyboard-event-kbd,grab_all=on,repeat=on \
#-object input-linux,id=mouse1,evdev=/dev/input/by-id/usb-Lenovo_Lenovo_Calliope_USB_Keyboard-if01-event-joystick \

#-bios /usr/share/OVMF/OVMF_CODE.fd \
#-object input-linux,id=kbd,evdev=/dev/input/by-id/usb-RAPOO_RAPOO_2.4G_Wireless_Device-event-kbd,grab_all=on,repeat=on \
#-object input-linux,id=mouse1,evdev=/dev/input/by-id/usb-RAPOO_RAPOO_2.4G_Wireless_Device-if01-event-mouse \
#-usb -device usb-host,hostbus=1,hostport=5 \

#-usb -usbdevice tablet \
# qemu-system-x86_64 -enable-kvm -cpu host -smp 4 -runas qemu -daemonize -vnc 127.0.0.1:1 -cdrom /mnt/storage1/disks/isos/CentOS-7-x86_64-NetInstall-1708.iso -boot c -drive file=/mnt/storage1/disks/vm_harddisk.qcow2,index=0,cache=none,aio=threads,if=virtio -net nic,model=virtio,macaddr=00:00:00:00:00:01 -net tap,ifname=tap0 -balloon virtio -m 2048 -monitor telnet:127.0.0.1:5805,server,nowait
