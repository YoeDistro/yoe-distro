# readline is needed by bluetoothctl cmdline tool
# unless we need it, we can avoid libreadline in images
# which maybe good for GPL-3 free image types
PACKAGECONFIG:remove = "readline"
