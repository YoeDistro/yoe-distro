# Yoe Init/Updater

## Requirements

There are two functions of the Init/Updater system:

1. verify the system is initialized such that it can run (disk partitions, etc)
1. update the system with new software

Both of these functions are critical for a reliable system. Having
initialization system also greatly simplifies production deployment as the
system can completely initialize itself as long as a kernel can boot.

- single partition update
- update u-boot, kernel, dtb, etc.
- init/updater located in kernel initramfs
- most systems will have 3 partitions
  - `boot`: contains bootloaders, kernel+initramfs+init/udpater
  - `rootfs`: root file system that is re-written during update
  - `data`: data that is preserved between updates
- Initializes disk partitions
  - if disk is not partitioned correctly (# partitions), re-partition disk
  - optionally re-partition disk if sizes or not correct (example rootfs is too
    small)
    - try to preserve data if possible
- Mounts all partitions
  - mount `rootfs`
  - optionally mount `boot` into `rootfs` mount
  - mount `data` into `rootfs` mount
  - re-format `data` if it cannot be mounted
- Update
  - check for update file on USB disk and `data` partition
  - if found, select latest version
  - verify checksums for all files
  - compare contents of boot and kernel images and _only_ update them if they
    have changed. This is very import to minimize flash wear in `boot`
    partition, and minimize windows where unit may be bricked.
  - unconditionally write rootfs
  - optionally ask user to remove USB disk (if updating from USB)
- Platform specified hooks
  - any platform specific setup that needs done
- Switch root from initramfs to main rootfs

## Rationale for single image system

Most update systems focus on an A/B update system where you ping/pong between
two sets of images on the disk. The thought is that if the system does not boot
or has other problems, you can roll back to the other set of images. This is a
nice feature, but has the following complexities:

- maintaining two boot paths requires you to touch bootloader, kernel, and
  possibly rootfs code to process an update.
- there has to be some state that determines current boot path (typically a
  u-boot variable)
- typically update is handled in the main rootfs context, so pretty much the
  entire system needs to be running.
- more disk space is required
- you have to have some policy or mechanism for switching to the other set of
  images if there is a failure. This is not trivial.

For remote or ultra-critical systems, this type of A/B setup may make sense.
However it is critical to understand that this system is only as reliable as
weakest link in the boot/update process. Any bug, no matter how small, can
render the system useless. Because so many pieces of the boot process are
modified in the A/B system, it is critical that you budget enough time to
thoroughly test the process and all edge conditions.

An alternative implementation (described above in the above Requirements
section) is much simpler because the complete update process lives in an
initramfs bundled with the kernel. As long as the kernel boots, you can easily
recover the system from a USB disk, or perhaps a recovery update image stored in
the data partition. Because the booloader and kernel are stored in a `boot`
partition that is rarely written to (only on updates), this data is fairly
reliable. Network updates can be managed from an application running in the main
rootfs that fetches an update, stores it in the data partition and then reboots.
Overall, this system has worked extremely well on 10,000+ deployed systems and
is adequate for many embedded Linux systems. The simplicity also allows it to be
deployed quickly on new systems with very low risk.
