# KAS

[KAS](https://github.com/siemens/kas) is a tool for managing layer repositories,
configuration, and build environments for Yocto/OE builds. It is the recommended
approach for new Yoe projects (see
[Superproject Management](superproject-management.md) for background).

## Getting Started

KAS configurations live in the `kas/` directory. Each YAML file defines a
complete build for a target machine, including layer repositories, local.conf
settings, and bblayers.conf entries.

Available configurations:

- `jetson-agx-orin-devkit.yml`
- `jetson-orin-nano-devkit-nvme.yml`
- `rpi4-64.yml`
- `visionfive.yml`
- `visionfive2.yml`

## Running a Build

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
./kas-container <...> <target>.yml:local.yml
```

## References

- [KAS Documentation](https://kas.readthedocs.io/)
- [KAS Repository](https://github.com/siemens/kas)
