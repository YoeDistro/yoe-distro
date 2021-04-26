# ATSAMA5D27

The ATSAMA5D27 from Microchip is a ARM Cortex-A5 CPU available in 3 different
packages:

- [IC](https://www.microchip.com/wwwproducts/en/ATSAMA5D27)
- [SIP package with embedded SDRAM](https://www.microchip.com/wwwproducts/en/ATSAMA5D27C-D1G)
- [SOM package](https://www.microchip.com/wwwproducts/en/ATSAMA5D27-SOM1)

Microchip also provides a
[development board](https://www.microchip.com/DevelopmentTools/ProductDetails/ATSAMA5D27-SOM1-EK1).

## Building/installing an image

1. `git clone git://github.com/YoeDistro/yoe-distro.git`
1. `cd yoe-distro`
1. `. sama5d27-som1-ek-sd-envsetup.sh`
1. `yoe_setup`
1. `bitbake yoe-simple-image`
1. insert full size SD card (this image will not boot from the micro-sd slot)
1. `lsblk` (note sd card device, and substitute for /dev/sdX below)
1. `yoe_install_image /dev/sdX yoe-simple-image`
1. `sudo eject /dev/sdX`
1. Install SD card in development board and apply power via one of the micro-USB
   connectors.

## Connecting a serial console

The serial console for the development board is provided via the micro USB
connector near the Ethernet connector. The serial device will show up as
/dev/ttyACMx on a Linux system.

![Serial Console connector](ATSAMA5D27-SOM1-EK1.png)

## USB Host

USB Host is provided by connecting a port expander to the USB Type-C connector,
as shown in the photo above.

## Bootstrapping the system using SAM-BA

[SAM-BA](https://github.com/atmelcorp/sam-ba) is a boot assistant that can be
used to bootstrap a system over a UART or USB Client port and program fuses. It
is possible to bootstrap a system completely over SAM-BA with no flash/eMMC/SD
memory programmed. This is useful for systems that perhaps have a eMMC flash
installed, but do not have a SD card slot. Initially we used a procedure to load
AT91Bootstrap/U-boot into RAM and then jump to them, but that was not reliable,
so it seems the next best option is to load these pieces directly into flash.
The following connection can be used:

- UART (slow)
- USB Client
- JTAG (J-32 Debug Probe from Segger/Microchip)

eMMC can be flashed directly from SAM-BA/JTAG using the commands. Note, a serial
connection is required initially to set up the JTAG connection.

- connect UART
- setup JTAG
  - `sam-mba -p serial:ttyUSB0 -x setup-jtag.qml`
- create a disk image including the two bootloaders (can use part of a Yocto WIC
  image)
- program the bootloaders into eMMC
  - `sam-ba -p j-link --board sama5d2-xplained --applet sdmmc:0:1:: -c write:bootstrap-part.img`

Once u-boot has loaded, you can load the kernel from USB or TFTP/Network and
then install the rest of the system using the Yoe updater.

- from USB:
  - `usb reset;fatls usb 0:1;fatload usb 0:1 0x21000000 at91-sama5d27_som1_ek.dtb;fatload usb 0:1 0x22000000 zImage;bootz 0x22000000 - 0x21000000`
- from network/TFTP:
  - `dhcp 0x21000000 <tftp server IP address>:at91-sama5d27_som1_ek.dtb`
  - `dhcp 0x22000000 <tftp server IP address>:zImage`
  - `bootz 0x22000000 - 0x21000000`

At this point the kernel will boot, run the updater from an initramfs bundled
with the kernel. The updater will inialize a SD/eMMC device, and program the
system from the \*.upd file on the USB disk.

See the [Yoe Updater Documentation](updater.md) for more information on how the
updater works.

### setup-jtag.qml file

```
import SAMBA 3.5
import SAMBA.Connection.Serial 3.5
import SAMBA.Device.SAMA5D2 3.5
SerialConnection {
	port: "ttyUSB0"
	//port: "COM85"
	baudRate: 115200
	device: SAMA5D2Xplained {
		/* override part of default config */
		config {
			/* use first boot partition */
			sdmmc {
				partition: 0
			}
		}
	}

	onConnectionOpened: {
		// initialize SD/MMC applet
		//initializeApplet("sdmmc")
		// write file
		//applet.write(0, "at91bootstrap.bin", true)
		// initialize boot config applet
		initializeApplet("bootconfig")
		// Use BUREG0 as boot configuration word
		applet.writeBootCfg(BootCfg.BSCR,
		  BSCR.fromText("VALID,BUREG0"))

		// Enable external boot only on SDMMC0
		applet.writeBootCfg(BootCfg.BUREG0,
			BCW.fromText("EXT_MEM_BOOT,UART1_IOSET1,JTAG_IOSET1," +
				"SDMMC0,SDMMC1_DISABLED,NFC_DISABLED," +
				"SPI1_DISABLED,SPI0_DISABLED," +
				"QSPI1_DISABLED,QSPI0_DISABLED"))
	}
}
```
