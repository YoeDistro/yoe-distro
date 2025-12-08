# KAS

KAS is a tool to manage metadata and build environments for Yocto/OE builds: https://github.com/siemens/kas

To run KAS in Yoe Distro, use the kas/ subfolder as the working directory. This directory contains KAS configurations for each
supported target machine at the top level. Once the `kas-container` script is run in the kas/ folder, it will also contain the
build/ and layers/ folders.

To set up a docker container ready to run bitbake commands:
```bash
cd kas/
./kas-container \
    --runtime-args "--volume ./../sources/meta-yoe:/work/layers/meta-yoe" \
    --ssh-dir ~/.ssh \
    shell jetson-agx-orin-devkit.yml
```

The `--volume` flag is passed to docker through the kas-container `--runtime-args` flag and mounts the local meta-yoe layer in the container's layer/ directory for use in the build.

To have local configuration, create kas/local.yml (git ignored) and append it to the project configuration when invoking KAS:
```bash
./kas-container <...> <target>.yml:local.yml
```