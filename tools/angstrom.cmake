# to use, cmake --DCMAKE_TOOLCHAIN_FILE=angstrom.cmake ...
#
# note, this will probably only work for very simple programs.
# See http://www.cmake.org/Wiki/CMake_Cross_Compiling for more
# complex examples.

set (CMAKE_C_COMPILER arm-angstrom-linux-gnueabi-gcc)
set (CMAKE_CXX_COMPILER arm-angstrom-linux-gnueabi-g++)

