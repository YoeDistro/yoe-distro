# Radxa ROCK Pi 4B

The [ROCK Pi 4B](https://wiki.radxa.com/Rock4) is a single-board computer from
Radxa powered by the Rockchip RK3399 SoC. It offers a Raspberry Pi-like form
factor with significantly more processing power.

## Key Features

- Rockchip RK3399: dual Cortex-A72 at 1.8 GHz + quad Cortex-A53 at 1.4 GHz
- Mali-T860MP4 GPU
- 1/2/4 GB LPDDR4 RAM
- eMMC socket and MicroSD card slot
- M.2 connector for NVMe SSD
- Gigabit Ethernet
- 802.11ac WiFi and Bluetooth 5.0
- USB 3.0, USB 2.0, USB-C (with DisplayPort alt-mode)
- HDMI 2.0 (up to 4K@60)
- MIPI DSI and CSI interfaces
- 40-pin GPIO header (Raspberry Pi compatible)

## Building/installing an image

1. `git clone https://github.com/YoeDistro/yoe-distro.git`
1. `cd yoe-distro`
1. `. ./envsetup.sh rockpi-4b`
1. `yoe_setup`
1. `bitbake yoe-simple-image`
1. Insert SD card
1. `lsblk` (note SD card device, and substitute for /dev/sdX below)
1. `yoe_install_image /dev/sdX yoe-simple-image`
1. `sudo eject /dev/sdX`
1. Install SD card in the ROCK Pi 4B and apply power

## Serial Console

The debug UART is available on the 40-pin GPIO header (pins 6/8/10). Connect a
3.3V USB-to-serial adapter:

- Pin 6 (GND) to GND
- Pin 8 (TX) to RX
- Pin 10 (RX) to TX

Serial settings: 1500000 baud, 8N1. Note the high baud rate — make sure your
serial adapter supports it.

## References

- [ROCK Pi 4 Wiki](https://wiki.radxa.com/Rock4)
- [meta-rockchip BSP Layer](https://github.com/YoeDistro/meta-rockchip)
