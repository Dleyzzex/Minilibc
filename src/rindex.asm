BITS 64                         ; 64-bit mode
GLOBAL rindex                   ; export "rindex"

SECTION .text

rindex:
        MOV     RAX, RDI        ; Set RAX to 0, RAX is the return value
        XOR     R11, R11
.loop:
        CMP     BYTE[RAX], 0      ; The ZF flag is set according to the result, 1 if equal, 0 if not, BYTE convert to char : RDI (ptr of the char *) + RAX
        JE      die                     ; If ZF = 1 == if \0, Go to die
        CMP     BYTE[RAX], SIL    ; The ZF flag is set according to the result, 1 if equal, 0 if not, BYTE convert to char : RDI (ptr of the char *) + RAX
        JE      .save_value
        INC     RAX                     ; Icrement by 1 RAX
        JMP     .loop                   ; Go to strlen - equivalent of a while

.save_value:
        MOV     R11, RAX
        INC     RAX                     ; Icrement by 1 RAX
        JMP     .loop                   ; Go to strlen - equivalent of a while

die:
        MOV     RAX, R11
        RET                     ; return RAX