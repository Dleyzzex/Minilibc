BITS 64                         ; 64-bit mode
GLOBAL memmove                  ; export "memmove"

SECTION .text

memmove:
        MOV     RAX, RDI        ; Set RAX equal to the ptr of RDI -> first parameter
        XOR     R10, R10        ; Set R10 to 0
        SUB     RDX, 1
        CMP     RDI, RSI
        JG      .loop_b
        JE      die

.loop:
        CMP     R10, RDX        ; Compare index and third argument, if index is equal return
        JE      die             ; If ZF = 1 == if \0, Go to die
        MOV     R11B, BYTE[RSI+R10]
        MOV     BYTE[RDI+R10], R11B ; Set the value of RSI to the addre of RAX+R10
        INC     R10             ; Icrement by 1 RAX
        JMP     .loop           ; Go to .loop - equivalent of a while

.loop_b:
        CMP     RDX, -1        ; Compare index and third argument, if index is equal return
        JE      die             ; If ZF = 1 == if \0, Go to die
        MOV     R11B, BYTE[RSI+RDX]
        MOV     BYTE[RDI+RDX], R11B ; Set the value of RSI to the addre of RAX+R10
        SUB     RDX, 1
        JMP     .loop_b           ; Go to .loop - equivalent of a while

die:
        RET                     ; return RAX