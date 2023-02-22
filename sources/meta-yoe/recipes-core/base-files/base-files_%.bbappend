# Create /data in rootfs which is needed
# by yoe updater for mounting r/w persistent
# partition in rootfs especially with r/o rootfs
# where it can not be created on the fly
dirs755 += "/data"
