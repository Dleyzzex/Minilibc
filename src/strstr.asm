BITS 64                         ; 64-bit mode
GLOBAL strstr                   ; export "strstr"

SECTION .text

strstr:
        MOV     RAX, RDI

.loopA:
        CMP     BYTE[RAX], 0
        JE      die
        MOV     R11, RAX
        MOV     R10, RSI
        JMP     .loopA
        INC     RAX
        JMP     .loopB

.loopB:
        CMP     BYTE[R10], 0
        JE      .find
        CMP     BYTE[R10], AL
        JNE     .not_equal
        INC     R10
        JMP     .loopB

.not_equal:
        MOV     RAX, R11
        JMP     .loopA

.find:
        MOV     RAX, R11
        RET

die:
        RET                     ; return RAX