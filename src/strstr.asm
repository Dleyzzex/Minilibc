BITS 64                         ; 64-bit mode
GLOBAL strstr                   ; export "strstr"

SECTION .text

strstr:
        MOV     RAX, RDI

.loopA:
        MOV     R9, RAX
        CMP     BYTE[RAX], 0
        JE      .leave
        XOR     R10, R10        ; index

.loopB:
        MOV     R11B, BYTE[RSI + R10]   ; tmp
        CMP     R11B, 0
        JE      .found
        CMP     R9B, 0
        JE      .not_found
        CMP     BYTE[R9], R11B
        JNE      .not_found
        INC     R10
        INC     R9
        JMP     .loopB

.not_found:
        INC     RAX
        JMP     .loopA

.leave:
        XOR     RAX, RAX
        RET

.found:
        RET