BITS 64                         ; 64-bit mode
GLOBAL strchr                   ; export "strchr"

SECTION .text

strchr:
        MOV     RAX, RDI        ; Set RAX equal to the ptr of RDI -> first parameter
.loop:
        CMP     BYTE[RAX], 0    ; The ZF flag is set according to the result, 1 if equal, 0 if not, BYTE convert to char : RAX
        JE      .null_ptr       ; If ZF = 1 == if \0, Go to die
        CMP     BYTE[RAX], SIL  ; The ZF flag is set according to the result, 1 if equal, 0 if not, BYTE convert to char : RAX
        JE      die             ; If ZF = 1 ==  find the char, Go to die
        INC     RAX             ; Icrement by 1 RAX
        JMP     .loop           ; Go to .loop - equivalent of a while

.null_ptr
        XOR     RAX, RAX

die:
        RET                     ; return RAX