BITS 64                         ; 64-bit mode
GLOBAL strcspn                  ; export "strcspn"

SECTION .text

strcspn:
        MOV     RAX, RDI
        XOR     R9, R9

.loopA:
        CMP     BYTE[RAX], 0
        JE      .found
        XOR     R10, R10

.loopB:
        MOV     R11B, BYTE[RSI + R10]
        CMP     R11B, 0
        JE      .not_found
        CMP     BYTE[RAX], R11B
        JE      .found
        INC     R10
        JMP     .loopB

.not_found:
        INC     R9
        INC     RAX
        JMP     .loopA

.found:
        MOV     RAX, R9
        RET

die:
        RET                     ; return RAX