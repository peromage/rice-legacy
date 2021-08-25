# Multiboot USB
Boot from any iso file

## Hybrid UEFI GPT + BIOS MBR/GPT boot
### Preparation
Create 3 partitions on a removable USB stick.
1. A BIOS boot partition (gdisk type code `EF02`, or GUID `21686148-6449-6E6F-744E-656564454649`) with no filesystem. This partition can be put in any place on the disk but it is recommended to put it at the begginning from sector 34 to 2047. At minimal 1 MiB.
1. An EFI System partition (gdisk type code `EF00`) with a FAT32 filesystem. This partition can be as small as 50 MiB but it is better to set at least 256 MiB (550 MiB recommended).
1. Data partition (use a filesystem supported by GRUB). This partition can take up the rest of the space of the drive.
### GRUB Installation
Mount EFI and data partitions.  
First install GRUB for UEFI:
```
# grub-install --target=x86_64-efi --recheck --removable --efi-directory=/EFI_MOUNTPOINT --boot-directory=/DATA_MOUNTPOINT/boot
```
Then GRUB for BIOS:
```
# grub-install --target=i386-pc --recheck --boot-directory=/DATA_MOUNTPOINT/boot /dev/sdX
```
As an additional fallback, GRUB on the MBR-bootable data partition can be installed:
```
# grub-install --target=i386-pc --recheck --boot-directory=/DATA_MOUNTPOINT/boot /dev/sdX3
```
### GRUB Configuration
#### Using a Template
There are some git projects which provide some pre-existing GRUB configuration files, and a nice generic grub.cfg which can be used to load the other boot entries on demand, showing them only if the specified ISO files - or folders containing them - are present on the drive.  
[Multiboot USB](https://github.com/aguslr/multibootusb)  
[GLIM (GRUB2 Live ISO Multiboot)](https://github.com/thias/glim)
#### Using Manual Configuration
1. Install memdisk module from Syslinux:
```
# cp /usr/lib/syslinux/bios/memdisk /DATA_MOUNTPOINT/boot/
```
2. Finding the partition where image files are located by persistent name is recommended. To get this done by using either filesystem UUID or partition label **(this step is not necessarily required due to iso files are located on the same partition)**.
3. A template configuration can be found below. Note: `/DATA_MOUNTPOINT/boot/` is for GRUB boot files and `/DATA_MOUNTPOINT/iso/` is for images. Those directories can be variant.
> /DATA_MOUNTPOINT/boot/grub/grub.cfg
```
### insert modules ###

# if on ntfs with compression on
#insmode ntfscomp


### path variables ###
set isopath=${root}/iso
set memdisk=${prefix}/memdisk

# path to the partition holding ISO images (using UUID)
#probe -u $root --set=rootuuid
#set imgdevpath="/dev/disk/by-uuid/$rootuuid"

# path to the partition holding ISO images (using UUID explicitly)
#set imgdevpath="/dev/disk/by-uuid/UUID_value

# path to the partition holding ISO images (using UUID searching)
#search --set=imgdevpath --no-floppy --fs-uuid UUID_value

# path to the partition holding ISO images (using labels)
#set imgdevpath="/dev/disk/by-label/label_value"

# path to the partition holding ISO images (using file searching)
#search --set=part --no-floppy --file PATH_TO_FILE

menuentry "Generic ISO Boot Menu" {
	linux16 ${memdisk} iso ro
	initrd16 ${isopath}/PATH_TO_ISO
}
```

## Credits
[BIOS + GPT + GRUB + Linux + Windows 折腾笔记](https://wzyboy.im/post/1049.html)  
[Arch Linux Wiki: GRUB](https://wiki.archlinux.org/index.php/GRUB)  
[Arch Linux Wiki: EFI system partition](https://wiki.archlinux.org/index.php/EFI_system_partition)  
[Arch Linux Wiki: Multiboot USB drive](https://wiki.archlinux.org/index.php/Multiboot_USB_drive)  
[Wiki: GUID Partition Table](https://en.wikipedia.org/wiki/GUID_Partition_Table)  