# Allwinner Nezha D1

The [Nezha D1](https://d1.docs.aw-ol.com/en/) is a RISC-V single-board computer
based on the Allwinner D1 SoC, featuring the XuanTie C906 64-bit RISC-V core. It
is one of the first affordable RISC-V Linux SBCs.

## Key Features

- Allwinner D1 SoC with XuanTie C906 RISC-V core at 1 GHz
- 1 GB DDR3 RAM
- HDMI output
- Gigabit Ethernet
- USB 2.0 Host and OTG
- GPIO header (compatible with Raspberry Pi HATs)
- MicroSD card slot
- WiFi/BT module (optional)

## Building/installing an image

1. `git clone --recurse-submodules -j8 -b master https://github.com/YoeDistro/yoe-distro.git yoe`
1. `cd yoe`
1. `kas build kas/nezha-d1.yml`
1. Insert SD card
1. `lsblk` (note SD card device, and substitute for /dev/sdX below)
1. Flash the image from `build/tmp/deploy/images/` to the SD card
1. `sudo eject /dev/sdX`
1. Install SD card in the Nezha and apply power

## Serial Console

The debug UART is available on the GPIO header. Connect a 3.3V USB-to-serial
adapter:

- GND to GND
- TX to RX
- RX to TX

Serial settings: 115200 baud, 8N1.

## References

- [Allwinner D1 Documentation](https://d1.docs.aw-ol.com/en/)
- [Nezha D1 Wiki](https://linux-sunxi.org/Allwinner_Nezha)
