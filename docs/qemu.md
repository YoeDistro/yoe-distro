# QEMU Virtual Machines

Yoe supports a variety of QEMU targets for testing and development without
physical hardware. These are useful for build testing, application development,
and CI pipelines.

| Project       | Architecture   | Description                  |
| ------------- | -------------- | ---------------------------- |
| `qemuarm`     | ARM 32-bit     | Versatile Express Cortex-A15 |
| `qemuarm64`   | ARM 64-bit     | Generic ARM64 (Cortex-A57)   |
| `qemux86`     | x86 32-bit     | Generic PC (i586)            |
| `qemux86-64`  | x86 64-bit     | Generic PC (x86-64)          |
| `qemumips`    | MIPS 32-bit    | Malta board                  |
| `qemuppc`     | PowerPC 32-bit | Mac99 machine                |
| `qemuppc64`   | PowerPC 64-bit | pseries machine              |
| `qemuriscv32` | RISC-V 32-bit  | Generic RISC-V (virt)        |
| `qemuriscv64` | RISC-V 64-bit  | Generic RISC-V (virt)        |

## Building an image

1. `git clone --recurse-submodules -j8 -b master https://github.com/YoeDistro/yoe-distro.git yoe`
1. `cd yoe`
1. `kas build kas/<machine>.yml` (e.g., `kas/qemuarm64.yml`)

## Running the image

After building, launch the image in QEMU with:

```bash
runqemu yoe-simple-image
```

Common options:

- `runqemu yoe-simple-image nographic` — serial console only, no GUI window
- `runqemu yoe-simple-image kvm` — use KVM acceleration (x86 host only, for
  qemux86/qemux86-64)
- `runqemu yoe-simple-image slirp` — user-mode networking (no root required)

## Notes

- The `qemucommon` project contains shared configuration used by other QEMU
  projects. It is not intended to be built directly.
- KVM acceleration is available on x86 hosts for `qemux86` and `qemux86-64`,
  providing near-native performance.
- For ARM and RISC-V targets, QEMU uses full system emulation which is slower
  but functional.

## References

- [QEMU Documentation](https://www.qemu.org/docs/master/)
- [Yocto QEMU Documentation](https://docs.yoctoproject.org/dev-manual/qemu.html)
