BITS 64                         ; 64-bit mode
GLOBAL memset                   ; export "memset"

SECTION .text

memset:
        MOV     RAX, RDI        ; Set RAX equal to the ptr of RDI -> first parameter
        XOR     R10, R10        ; Set R10 to 0
.loop:
        CMP     R10, RDX        ; Compare index and third argument, if index is equal return
        JE      die             ; If ZF = 1 == if \0, Go to die
        MOV     BYTE[RAX+R10], SIL ; Set the value of RSI to the addre of RAX+R10
        INC     R10             ; Icrement by 1 RAX
        JMP     .loop           ; Go to .loop - equivalent of a while

die:
        RET                     ; return RAX