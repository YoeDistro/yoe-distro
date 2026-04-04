# StarFive VisionFive

Yoe supports two generations of the StarFive VisionFive RISC-V single-board
computer:

| Project       | Board        | SoC    | Cores                     |
| ------------- | ------------ | ------ | ------------------------- |
| `visionfive`  | VisionFive   | JH7100 | 2x U74 (RV64GC) @ 1 GHz   |
| `visionfive2` | VisionFive 2 | JH7110 | 4x U74 (RV64GC) @ 1.5 GHz |

## VisionFive (V1)

The [StarFive VisionFive](https://www.starfivetech.com/en/site/boards) is an
affordable RISC-V SBC based on the JH7100 SoC with dual SiFive U74 cores at 1
GHz, 8 GB LPDDR4 RAM, Gigabit Ethernet, USB 3.0, HDMI, and a 40-pin GPIO header.

## VisionFive 2

The [StarFive VisionFive 2](https://www.starfivetech.com/en/site/boards) is the
successor featuring the JH7110 SoC with quad SiFive U74 cores at 1.5 GHz, a GPU
(IMG BXE-4-32), 2/4/8 GB LPDDR4X RAM, dual Gigabit Ethernet, USB 3.0, HDMI 1.4,
MIPI DSI/CSI, M.2 for WiFi/BT, and a 40-pin GPIO header.

## Building/installing an image

1. `git clone --recurse-submodules -j8 -b master https://github.com/YoeDistro/yoe-distro.git yoe`
1. `cd yoe`
1. `kas build kas/<machine>.yml` (e.g., `kas/visionfive2.yml`)
1. Insert SD card
1. `lsblk` (note SD card device, and substitute for /dev/sdX below)
1. Flash the image from `build/tmp/deploy/images/` to the SD card
1. `sudo eject /dev/sdX`
1. Install SD card and apply power

## Serial Console

Both boards expose a debug UART on the 40-pin GPIO header. Connect a 3.3V
USB-to-serial adapter:

- Pin 6 (GND) to GND
- Pin 8 (TX) to RX
- Pin 10 (RX) to TX

Serial settings: 115200 baud, 8N1.

## References

- [StarFive VisionFive 2](https://www.starfivetech.com/en/site/boards)
- [VisionFive 2 Documentation](https://doc-en.rvspace.org/VisionFive2/)
- [meta-riscv BSP Layer](https://github.com/riscv/meta-riscv)
