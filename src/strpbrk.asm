BITS 64                         ; 64-bit mode
GLOBAL strpbrk                  ; export "strpbrk"

SECTION .text

strchr:
        MOV     RAX, RDI

.loopA:
        CMP     BYTE[RAX], 0
        JE      die
        MOV     R10, RSI
        JMP     .loopA
        INC     RAX
        JMP     .loopB

.loopB:
        CMP     BYTE[R10], 0
        JE      .loopA
        CMP     BYTE[R10], AL
        JE      die
        INC     R10
        JMP     .loopB

die:
        RET                     ; return RAX