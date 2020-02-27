BITS 64                         ; 64-bit mode
GLOBAL strcasecmp               ; export "strcasecmp"

SECTION .text

strcasecmp:

die:
        RET     ; Return RAX