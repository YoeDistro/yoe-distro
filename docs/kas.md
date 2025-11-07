# KAS

KAS is a tool to manage metadata and build environments for Yocto/OE builds: https://github.com/siemens/kas

In leveraging KAS inside the Yoe distribution, the goal is to combine the [project configuration mechanism](docs/conf-files.md) of Yoe with the benefits of KAS. In the kas/ directory there is a configuration for each project `${PROJECT}.yml`. KAS updates build/conf/local.conf every time it's run - KAS includes the conf/${PROJECT}/config.conf file through this local.conf.

To have local configuration, create kas/local.yml (git ignored) and append it to the project configuration when invoking KAS:
```bash
./kas-container <...> kas/myproject.yml:kas/local.yml
```