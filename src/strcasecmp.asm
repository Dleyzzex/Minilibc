BITS 64                         ; 64-bit mode
GLOBAL strcasecmp               ; export "strcasecmp"

SECTION .text

strcasecmp:
        XOR     RAX, RAX        ; Set RAX to 0
        XOR     R9, R9          ; Set R9 to 0
        XOR     R10, R10        ; Set R10 to 0

.loop:
        CMP     BYTE[RDI + R9], 0   ; The ZF flag is set according to the result, 1 if equal, 0 if not, BYTE convert to char : RAX
        JE      die                 ; If ZF = 1 == if \0, Go to die
        CMP     BYTE[RSI + R9], 0   ; The ZF flag is set according to the result, 1 if equal, 0 if not, BYTE convert to char : RAX
        JE      die

        CMP     BYTE[RDI + R9], 97   ; if str[n] > 'a'
        JGE     .is_min_a

        CMP     BYTE[RSI + R9], 97   ; if str[n] > 'a'
        JGE     .is_min

        JMP     .compare

.is_min:
        CMP     BYTE[RSI + R9], 121  ; if str[n] > 'z'
        JGE     .compare

        CMP     BYTE[RDI + R9], 96  ; if str2[n] < 'a'
        JLE     .compare

        CMP     BYTE[RDI + R9], 121  ; if str2[n] > 'z'
        JGE     .compare

        ADD     BYTE[RSI + R9], 32

        JMP     .compare


.is_min_a:
        CMP     BYTE[RDI + R9], 121  ; if str[n] > 'z'
        JGE     .compare

        CMP     BYTE[RSI + R9], 96  ; if str2[n] < 'a'
        JLE     .compare

        CMP     BYTE[RSI + R9], 121  ; if str2[n] > 'z'
        JGE     .compare

        ADD     BYTE[RDI + R9], 32

        JMP     .compare

.compare:
        MOV     R10B, BYTE[RSI+R9]  ; Move strb[n] of the second parameter to R10B
        MOV     AL, BYTE[RDI+R9]    ; Move stra[n] to RAX
        CMP     AL, R10B            ; Compare stra[n] with strb[n]
        JNE     not_equal

        INC     R9                  ; Icrement by 1 RAX
        JMP     .loop               ; Go to .loop - equivalent of a while

not_equal:
        SUB     RAX, R10            ; Do stra[n] - strb[n]
        RET                         ; return RAX

die:
        RET                             ; return RAX
