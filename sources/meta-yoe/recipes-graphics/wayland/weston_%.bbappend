FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SIMPLECLIENTS ?= "all"
PACKAGECONFIG[clients] = "-Dsimple-clients=${SIMPLECLIENTS} -Ddemo-clients=true,-Dsimple-clients= -Ddemo-clients=false"
