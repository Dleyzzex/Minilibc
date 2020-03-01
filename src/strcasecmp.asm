BITS 64                         ; 64-bit mode
GLOBAL strcasecmp               ; export "strcasecmp"

SECTION .text

strcasecmp:
        XOR     RAX, RAX        ; Set RAX to 0
        XOR     R9, R9          ; Set R9 to 0
        XOR     R10, R10        ; Set R10 to 0
        JMP     .loop

.loop:
        MOV     AL, BYTE[RDI+R9]    ; Move stra[n] to RAX
        MOV     R10B, BYTE[RSI+R9]  ; Move strb[n] of the second parameter to R10B

        CMP     AL, 'A'
        JL      .check_a
        CMP     AL, 'Z'
        JG      .check_a
        ADD     AL, 32

.check_a:
        CMP     R10B, 'A'
        JL      .compare
        CMP     R10B, 'Z'
        JG      .compare
        ADD     R10B, 32

.compare:
        CMP     AL, R10B            ; Compare stra[n] with strb[n]
        JNE     not_equal
        CMP     BYTE[RDI + R9], 0   ; The ZF flag is set according to the result, 1 if equal, 0 if not, BYTE convert to char : RAX
        JE      die                 ; If ZF = 1 == if \0, Go to die
        CMP     BYTE[RSI + R9], 0   ; The ZF flag is set according to the result, 1 if equal, 0 if not, BYTE convert to char : RAX
        JE      die
        INC     R9                  ; Icrement by 1 RAX
        JMP      .loop               ; if (str[n] = strb[n]) continue else return rax - r10

not_equal:
        SUB     RAX, R10            ; Do stra[n] - strb[n]
        RET                         ; return RAX

die:
        RET                         ; return RAX
