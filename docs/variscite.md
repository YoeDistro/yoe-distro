# Variscite System on Modules

Yoe supports several [Variscite](https://www.variscite.com/) System on Module
(SOM) products based on NXP i.MX processors. These SOMs are designed for
industrial and embedded applications and are typically mounted on carrier boards.

| Project             | SOM                  | SoC          | Architecture |
| ------------------- | -------------------- | ------------ | ------------ |
| `var-dart-imx6ul`   | DART-6UL             | i.MX 6UL     | Cortex-A7    |
| `var-som-mx8`       | VAR-SOM-MX8          | i.MX 8QuadMax | Cortex-A72/A53 |
| `var-som-mx8m-nano` | VAR-SOM-MX8M-NANO    | i.MX 8M Nano | Cortex-A53   |
| `var-som-mx8x`      | VAR-SOM-MX8X         | i.MX 8QuadXPlus | Cortex-A35 |

## DART-6UL

The [DART-6UL](https://www.variscite.com/product/system-on-module-som/cortex-a7/dart-6ul-freescale-imx-6ul/)
is a compact SOM based on the NXP i.MX 6UltraLite featuring a single Cortex-A7
core at up to 696 MHz. It targets cost-sensitive, low-power applications with
Ethernet, USB, CAN, UART, SPI, and I2C interfaces.

## VAR-SOM-MX8

The [VAR-SOM-MX8](https://www.variscite.com/product/system-on-module-som/cortex-a72-702/var-som-mx8-nxp-i-mx-8/)
is a high-performance SOM based on the NXP i.MX 8QuadMax with dual Cortex-A72
and quad Cortex-A53 cores, dual GPUs, 4K video encode/decode, and up to 4 GB
LPDDR4 RAM. Suitable for multimedia, HMI, and edge computing applications.

## VAR-SOM-MX8M-NANO

The [VAR-SOM-MX8M-NANO](https://www.variscite.com/product/system-on-module-som/cortex-a53-702/var-som-mx8m-nano-nxp-i-mx8m-nano/)
is based on the NXP i.MX 8M Nano with quad Cortex-A53 cores and a Cortex-M7
real-time core. It offers a balance of performance and power efficiency with
1080p video, 3D GPU, and machine learning acceleration via the NPU.

## VAR-SOM-MX8X

The [VAR-SOM-MX8X](https://www.variscite.com/product/system-on-module-som/cortex-a35/var-som-mx8x-nxp-i-mx8x/)
is based on the NXP i.MX 8QuadXPlus with quad Cortex-A35 cores. It is optimized
for low-power applications with 4K video output, dual-camera input, and
industrial temperature support.

## Building/installing an image

1. `git clone https://github.com/YoeDistro/yoe-distro.git`
1. `cd yoe-distro`
1. `. ./envsetup.sh <project>` (e.g., `var-som-mx8m-nano`)
1. `yoe_setup`
1. `bitbake yoe-simple-image`
1. Insert SD card
1. `lsblk` (note SD card device, and substitute for /dev/sdX below)
1. `yoe_install_image /dev/sdX yoe-simple-image`
1. `sudo eject /dev/sdX`
1. Install SD card in the evaluation kit and apply power

## Serial Console

Variscite evaluation kits typically provide a debug UART via micro-USB connector
on the carrier board. Connect at 115200 baud, 8N1.

## References

- [Variscite Products](https://www.variscite.com/products/)
- [Variscite Wiki](https://variwiki.com/)
- [meta-variscite-bsp Layer](https://github.com/varigit/meta-variscite-bsp)
