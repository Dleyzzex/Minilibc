BITS 64                         ; 64-bit mode
GLOBAL strstr                   ; export "strstr"

SECTION .text

strstr:
        MOV     RAX, RDI        ; Set RAX equal to the ptr of RDI -> first parameter
        XOR     R10, R10
.loop:
        CMP     BYTE[RAX], 0    ; The ZF flag is set according to the result, 1 if equal, 0 if not, BYTE convert to char : RAX
        JE      die             ; If ZF = 1 == if \0, Go to die

        MOV     R10, RAX
        MOV     R11, RSI
        JMP     .check          ; Go to .loop - equivalent of a while

        INC     RAX             ; Icrement by 1 RAX
        JMP     .loop           ; Go to .loop - equivalent of a while

.check:
        CMP     BYTE[RAX], 0    ; The ZF flag is set according to the result, 1 if equal, 0 if not, BYTE convert to char : RAX
        JE      .stop           ; If ZF = 1 == if \0, Go to die
        CMP     BYTE[R11], AL   ; The ZF flag is set according to the result, 1 if equal, 0 if not, BYTE convert to char : RAX
        JNE     .stop
        CMP     BYTE[R11], 0    ; The ZF flag is set according to the result, 1 if equal, 0 if not, BYTE convert to char : RAX
        JE      find            ; If ZF = 1 == if \0, Go to die
        INC     R11
        INC     RAX
        JMP     .check

.stop:
        MOV     RAX, R10
        INC     RAX
        JMP     .loop

find:
        MOV     RAX, R10
        JMP     die

die:
        RET                   ; return RAX