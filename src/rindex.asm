BITS 64                         ; 64-bit mode
GLOBAL rindex                   ; export "rindex"

SECTION .text

rindex:
        XOR     RAX, RAX
.loop:
        CMP     BYTE[RDI], SIL    ; The ZF flag is set according to the result, 1 if equal, 0 if not, BYTE convert to char : RDI (ptr of the char *) + RAX
        JE      .save_value
        CMP     BYTE[RDI], 0      ; The ZF flag is set according to the result, 1 if equal, 0 if not, BYTE convert to char : RDI (ptr of the char *) + RAX
        JE      .null_ptr         ; If ZF = 1 == if \0, Go to die
        INC     RDI                     ; Icrement by 1 RAX
        JMP     .loop                   ; Go to strlen - equivalent of a while

.save_value:
        MOV     RAX, RDI
        CMP     BYTE[RDI], 0      ; The ZF flag is set according to the result, 1 if equal, 0 if not, BYTE convert to char : RDI (ptr of the char *) + RAX
        JE      .null_ptr         ; If ZF = 1 == if \0, Go to die
        INC     RDI                     ; Icrement by 1 RAX
        JMP     .loop                   ; Go to strlen - equivalent of a while

.null_ptr:
        CMP     BYTE[RDI], SIL  ; The ZF flag is set according to the result, 1 if equal, 0 if not, BYTE convert to char : RAX
        JE      die
        XOR     RAX, RAX

die:
        RET                     ; return RAX
