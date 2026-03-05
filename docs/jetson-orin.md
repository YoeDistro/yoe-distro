# NVIDIA Jetson Orin

Yoe supports several NVIDIA Jetson Orin developer kits:

- **Jetson AGX Orin Developer Kit** — the high-end Orin module with up to 64 GB
  RAM and 2048 CUDA cores
- **Jetson Orin Nano Developer Kit** — the entry-level Orin module with up to 8
  GB RAM and 1024 CUDA cores
- **Jetson Orin Nano Developer Kit (NVMe)** — same as above, configured to boot
  from NVMe SSD

## Key Features (Jetson AGX Orin)

- Arm Cortex-A78AE CPU (up to 12 cores)
- NVIDIA Ampere GPU with up to 2048 CUDA cores
- Up to 64 GB LPDDR5 RAM
- Up to 275 TOPS AI performance
- PCIe Gen4, USB 3.2, Gigabit Ethernet, HDMI 2.1
- Multiple camera inputs (MIPI CSI-2)

## Key Features (Jetson Orin Nano)

- Arm Cortex-A78AE CPU (up to 6 cores)
- NVIDIA Ampere GPU with up to 1024 CUDA cores
- Up to 8 GB LPDDR5 RAM
- Up to 40 TOPS AI performance
- PCIe Gen3, USB 3.2, Gigabit Ethernet, DisplayPort

## Building/installing an image

### Jetson AGX Orin

1. `git clone https://github.com/YoeDistro/yoe-distro.git`
1. `cd yoe-distro`
1. `. ./envsetup.sh jetson-agx-orin-devkit`
1. `yoe_setup`
1. `bitbake yoe-simple-image`

### Jetson Orin Nano

1. `git clone https://github.com/YoeDistro/yoe-distro.git`
1. `cd yoe-distro`
1. `. ./envsetup.sh jetson-orin-nano-devkit`
1. `yoe_setup`
1. `bitbake yoe-simple-image`

For NVMe boot, use `jetson-orin-nano-devkit-nvme` instead.

## Flashing

NVIDIA Jetson boards are typically flashed using the NVIDIA SDK Manager or the
`tegraflash` tool. After building, the deploy directory will contain the
necessary files. Refer to the
[NVIDIA Jetson documentation](https://developer.nvidia.com/embedded/jetson-linux)
for detailed flashing instructions.

## Serial Console

The Jetson developer kits provide a debug UART via micro-USB connector. Connect
at 115200 baud, 8N1.

## References

- [Jetson AGX Orin Developer Kit](https://developer.nvidia.com/embedded/jetson-agx-orin-developer-kit)
- [Jetson Orin Nano Developer Kit](https://developer.nvidia.com/embedded/jetson-orin-nano-developer-kit)
- [meta-tegra BSP Layer](https://github.com/OE4T/meta-tegra)
