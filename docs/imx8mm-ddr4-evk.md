# NXP i.MX 8M Mini DDR4 EVK

The [i.MX 8M Mini](https://www.nxp.com/products/processors-and-microcontrollers/arm-processors/i-mx-applications-processors/i-mx-8-applications-processors/i-mx-8m-mini-arm-cortex-a53-cortex-m4-audio-voice-video:i.MX8MMINI)
is an applications processor from NXP featuring quad Arm Cortex-A53 cores and a
Cortex-M4 core. The DDR4 EVK is NXP's evaluation kit for this SoC using DDR4
memory.

## Key Features

- Quad Arm Cortex-A53 up to 1.8 GHz
- Arm Cortex-M4 up to 400 MHz
- 2 GB DDR4 RAM
- GPU (GC NanoUltra / GCNanoLite)
- 1080p video decode
- Dual camera input (MIPI CSI-2)
- MIPI DSI display interface
- Gigabit Ethernet, USB 2.0, PCIe, UART, SPI, I2C

## Building/installing an image

1. `git clone https://github.com/YoeDistro/yoe-distro.git`
1. `cd yoe-distro`
1. `. ./envsetup.sh imx8mm-ddr4-evk`
1. `yoe_setup`
1. `bitbake yoe-simple-image`
1. Insert SD card
1. `lsblk` (note SD card device, and substitute for /dev/sdX below)
1. `yoe_install_image /dev/sdX yoe-simple-image`
1. `sudo eject /dev/sdX`
1. Install SD card in the EVK and apply power

## Serial Console

The debug UART is exposed via the micro-USB connector on the board. It will
appear as /dev/ttyUSB0 (or similar) on a Linux host. Connect at 115200 baud,
8N1.

## References

- [i.MX 8M Mini EVK Product Page](https://www.nxp.com/design/design-center/development-boards-and-designs/i-mx-evaluation-and-development-boards/evaluation-kit-for-the-i-mx-8m-mini-applications-processor:8MMINILPD4-EVK)
- [BSP Layer](https://github.com/Freescale/meta-freescale)
