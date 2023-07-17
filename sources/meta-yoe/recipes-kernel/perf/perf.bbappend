do_compile:prepend() {
    if [ -e ${S}/tools/lib/traceevent/plugins/Makefile ]; then
        sed -i -e 's|\$(libdir)/traceevent/plugins|\$(libdir)/traceevent_${KERNEL_VERSION}/plugins|g' ${S}/tools/lib/traceevent/plugins/Makefile
    fi
    sed -i -e 's|\$(libdir)/traceevent/plugins|\$(libdir)/traceevent_${KERNEL_VERSION}/plugins|g' ${S}/tools/perf/Makefile.config
}

FILES:${PN} += "${libdir}/traceevent*"
