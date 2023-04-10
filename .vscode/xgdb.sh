#!/bin/bash
readonly TARGET_IP="$1"
readonly PROGRAM="$2"
readonly ARGS="$3"
readonly TARGET_DIR="/tmp"
readonly TARGET_PROGRAM="${TARGET_DIR}/`basename ${PROGRAM}`"

# Must match startsPattern in tasks.json
echo "Deploying to target"

# kill gdbserver on target and delete old binary
ssh root@${TARGET_IP} "sh -c '/usr/bin/killall -q gdbserver; rm -rf ${TARGET_PROGRAM}  exit 0'"

# send the program to the target
scp ${PROGRAM} root@${TARGET_IP}:${TARGET_DIR}

# Must match endsPattern in tasks.json
echo "Starting GDB Server on Target"

# start gdbserver on target
ssh -t root@${TARGET_IP} "sh -c 'cd ${TARGET_DIR}; WAYLAND_DISPLAY=wayland-1 XDG_RUNTIME_DIR=/run/user/`id -u` gdbserver localhost:3000 ${TARGET_PROGRAM} ${ARGS}'"
