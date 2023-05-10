# Dependence and Library

## Box64 failed to run Spec2017 dynamically linked binary
Problem 

Box64 failed to run dynamically linked spec2017 binary. Error message shows that the `libstdc++.so.6` and `libgcc_s.so.1` lib is missing.

Reason

Dynamically linked binary is compiled on x86 platform, where the box64 on aarch64 platform, the library is missing.

Solution
use `ldd-grep.sh` script to extract all the dynamic lib the binaries need, and use BOX64_LD_LIBRARY env variable to specify the lib.
