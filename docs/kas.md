# KAS

KAS is a tool to manage metadata and build environments for Yocto/OE builds: https://github.com/siemens/kas

To have local configuration, create kas/local.yml (git ignored) and append it to the project configuration when invoking KAS:
```bash
./kas-container <...> kas/myproject.yml:kas/local.yml
```