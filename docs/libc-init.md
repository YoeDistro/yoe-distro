# libc and init system selection

[up](README.md)

## Selection

Selection of the libc and init system can be done be selecting a
[Yoe Profile](yoe-profile.md).

## Comparison of disk spaced used

- Musl + Busybox init/dev/login
  - space used in ext4 filesystem on running system using df: 1.9MB
  - adding sizes of files in image from buildhistory: 1.5MB
  - number of files in image: 595
- Busybox init/dev/login
  - space used in ext4 filesystem on running system using df: 3.5MB
  - adding sizes of files in image from buildhistory: 3.1MB
  - number of files in image: 621
- SysVinit
  - space used in ext4 filesystem on running system using df: 4.7MB
  - adding sizes of files in image from buildhistory: 4.3MB
  - number of files in image: 696
- Systemd
  - space used in ext4 filesystem on running system using df: 33.2MB
  - adding sizes of files in image from buildhistory: 22MB
  - number of files in image: 1,806

The space on disc used by a systemd image is much larger than adding the size of
the files in the image. We're not sure why this is -- perhaps there is
filesystem overhead for small files.
