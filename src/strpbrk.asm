BITS 64                         ; 64-bit mode
GLOBAL strpbrk                  ; export "strpbrk"

SECTION .text

strpbrk:
        MOV     RAX, RDI

.loopA:
        CMP     BYTE[RAX], 0
        JE      .leave
        MOV     R10, RSI
        XOR R10, R10

.loopB:
        MOV     R11B, BYTE[RSI + R10]
        CMP     R11B, 0
        JE      .not_found
        CMP     BYTE[RAX], R11B
        JE      die
        INC     R10
        JMP     .loopB

.not_found:
        INC     RAX
        JMP     .loopA

.leave
        XOR     RAX, RAX
        RET

die:
        RET                     ; return RAX