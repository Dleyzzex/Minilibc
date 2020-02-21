BITS 64                         ; 64-bit mode
GLOBAL strlen                   ; export "strlen"

SECTION .text

strlen:
        XOR     RAX, RAX        ; Set RAX to 0, RAX is the return value
.loop:
        CMP     BYTE[RDI + RAX], 0 ; The ZF flag is set according to the result, 1 if equal, 0 if not, BYTE convert to char : RDI (ptr of the char *) + RAX
        JE      die             ; If ZF = 1 == if \0, Go to die
        INC     RAX             ; Icrement by 1 RAX
        JMP     .loop           ; Go to strlen - equivalent of a while

die:
        RET                     ; return RAX