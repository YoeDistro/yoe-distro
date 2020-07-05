# Notes on using Yoe on the Xilinx ZCU102

[up](README.md)

[BSP Layer documentation](meta-xilinx/meta-xilinx-bsp/README.building.md)

## Building/installing an image

1. `git clone git://github.com/YoeDistro/yoe-distro.git`
1. `cd yoe-distro`
1. `. zcu102-zynqmp-envsetup.sh`
1. `yoe_setup`
1. add following to conf/local.conf
```console
IMAGE_BOOT_FILES_append = " boot.bin"
PREFERRED_PROVIDER_virtual/pmu-firmware = "pmu-firmware"
PREFERRED_PROVIDER_virtual/boot-bin = "xilinx-bootbin"
PREFERRED_PROVIDER_virtual/dtb = "device-tree"
PREFERRED_PROVIDER_qemu-native = "qemu-xilinx-native"
PREFERRED_PROVIDER_qemu-helper-native = "qemu-helper-native"
IMAGE_INSTALL_remove = " qemu"
```
1. `bitbake petalinux-image-minimal`
1. insert SD card
1. `lsblk` (note sd card device, and substitute for /dev/sdX below)
1. `yoe_install_image /dev/sdX petalinux-image-minimal`
1. optional: configure console for serial port (see below)
1. `sudo eject /dev/sdX`

*core-image-minimal also works, but yoe-simple-image builds but would not boot up and gets stuck in kernel *
