#!/bin/sh

### QT Environment Variables ###
export QT_QPA_EVDEV_TOUCHSCREEN_PARAMETERS="rotate=180"
export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
export QT_QPA_EGLFS_KMS_CONFIG=/etc/qt5/eglfs_kms_cfg.json
export QT_QPA_EGLFS_INTEGRATION=eglfs_kms
export QT_QPA_EGLFS_ALWAYS_SET_MODE=1
export QT_WAYLAND_SHELL_INTEGRATION=wl-shell
