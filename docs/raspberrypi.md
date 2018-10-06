# Notes on using Yoe on the Raspberry PI

## Enable serial console

Currently, the images default to console only on HDMI display. If you want
the console on the serial port, you will need to edit two files in the
boot partition of the SD card.

* config.txt
  * add the following line to the end of the file: `enable_uart=1`
* cmdline.txt
  * add the following to the end of the kernel cmdline: `console=ttyAMA0,115200`

We would like to make this configurable in the near future.
