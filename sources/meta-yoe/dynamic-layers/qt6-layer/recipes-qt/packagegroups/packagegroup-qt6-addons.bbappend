# qtdeviceutilities needs connman  which yoe does not use
# python3-pyside6 does not build with clang/lld which is default C/C++ compiler for yoe
RDEPENDS:${PN}:remove = "qtdeviceutilities python3-pyside6"
