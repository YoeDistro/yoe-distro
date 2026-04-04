# SiFive RISC-V Boards

Yoe supports two SiFive RISC-V development boards:

| Project     | Board            | SoC        | Cores           |
| ----------- | ---------------- | ---------- | --------------- |
| `unleashed` | HiFive Unleashed | FU540-C000 | 4x U54 + 1x E51 |
| `unmatched` | HiFive Unmatched | FU740-C000 | 4x U74 + 1x S7  |

## HiFive Unleashed

The [HiFive Unleashed](https://www.sifive.com/boards/hifive-unleashed) was the
first RISC-V board capable of running Linux. It features the SiFive Freedom U540
SoC with four U54 application cores (RV64GC) at 1.5 GHz and one E51 monitor
core, 8 GB DDR4 RAM, Gigabit Ethernet, and a MicroSD card slot.

## HiFive Unmatched

The [HiFive Unmatched](https://www.sifive.com/boards/hifive-unmatched) is a
mini-ITX form factor RISC-V development board. It features the SiFive Freedom
U740 SoC with four U74 application cores (RV64GC) at 1.2 GHz and one S7 monitor
core, 16 GB DDR4 RAM, PCIe x16 slot (x8 electrically), M.2 for NVMe and WiFi,
Gigabit Ethernet, and four USB 3.2 Gen 1 ports.

## Building/installing an image

1. `git clone --recurse-submodules -j8 -b master https://github.com/YoeDistro/yoe-distro.git yoe`
1. `cd yoe`
1. `kas build kas/<machine>.yml` (e.g., `kas/unmatched.yml`,
   `kas/unleashed.yml`)
1. Insert SD card
1. `lsblk` (note SD card device, and substitute for /dev/sdX below)
1. Flash the image from `build/tmp/deploy/images/` to the SD card
1. `sudo eject /dev/sdX`
1. Install SD card and apply power

## Serial Console

Both boards expose a debug UART via micro-USB connector. Connect at 115200 baud,
8N1.

## References

- [SiFive Boards](https://www.sifive.com/boards)
- [meta-riscv BSP Layer](https://github.com/riscv/meta-riscv)
