# KAS

[KAS](https://github.com/siemens/kas) is a tool for managing layer repositories,
configuration, and build environments for Yocto/OE builds. It is the recommended
approach for Yoe projects (see
[Superproject Management](superproject-management.md) for background).

## Getting Started

KAS configurations live in the `kas/` directory. Each YAML file defines a
complete build for a target machine, including layer repositories, local.conf
settings, and bblayers.conf entries.

Available configurations:

- `beaglebone.yml`
- `imx8mm-ddr4-evk.yml`
- `jetson-agx-orin-devkit.yml`
- `jetson-agx-orin-32gb.yml`
- `jetson-agx-orin-64gb.yml`
- `jetson-orin-nano-devkit.yml`
- `jetson-orin-nano-devkit-nvme.yml`
- `jetson-orin-nano-8gb-nvme.yml`
- `nezha-d1.yml`
- `odroid-c4.yml`
- `qemuarm.yml`
- `qemuarm64.yml`
- `qemumips.yml`
- `qemuppc.yml`
- `qemuppc64.yml`
- `qemuriscv32.yml`
- `qemuriscv64.yml`
- `qemux86.yml`
- `qemux86-64.yml`
- `rockpi-4b.yml`
- `rpi4-32.yml`
- `rpi4-64.yml`
- `rpi5.yml`
- `unleashed.yml`
- `unmatched.yml`
- `var-dart-imx6ul.yml`
- `var-som-mx8.yml`
- `var-som-mx8m-nano.yml`
- `var-som-mx8x.yml`
- `visionfive.yml`
- `visionfive2.yml`

## Customizing libc, init, and window system

The default build uses glibc, systemd, and wayland. To change these, combine
the machine config with one or more component includes using KAS multi-config
syntax:

```bash
kas build kas/rpi4-64.yml:kas/include/libc/musl.yml:kas/include/init/sysvinit.yml
```

Available component includes:

- **libc** (`kas/include/libc/`): `glibc.yml`, `musl.yml`
- **init** (`kas/include/init/`): `busyboxinit.yml`, `systemd.yml`, `sysvinit.yml`
- **winsys** (`kas/include/winsys/`): `eglfs.yml`, `wayland.yml`, `x11.yml`

Mix and match any combination. Only include the axes you want to change from
the defaults (glibc + systemd + wayland).

## Running a Build

To build an image:

```bash
kas build kas/rpi4-64.yml
```

To drop into a bitbake shell:

```bash
kas shell kas/rpi4-64.yml
```

### Using a container

To set up a container and drop into a shell ready for bitbake:

```bash
cd kas/
./kas-container \
    --runtime-args "--volume ./../sources/meta-yoe:/work/layers/meta-yoe" \
    --ssh-dir ~/.ssh \
    shell jetson-agx-orin-devkit.yml
```

The `--volume` flag mounts the local meta-yoe layer into the container so that
local changes are available in the build.

Once inside the container shell, run bitbake as usual:

```bash
bitbake yoe-simple-image
```

## Local Configuration

To add machine-specific or user-specific settings without modifying the
checked-in YAML files, create `kas/local.yml` (git-ignored) and append it when
invoking KAS:

```bash
kas build kas/<target>.yml:kas/local.yml
```

## References

- [KAS Documentation](https://kas.readthedocs.io/)
- [KAS Repository](https://github.com/siemens/kas)
