section .data
    msg     db      "Digite algo:  "
    tam     equ     $-msg

section .bss
    buffer resb 256

section .text
global _start
_start:
    ;imprime a mensagem "Digite algo:  "
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, msg
    mov     edx, tam
    int     0x80
   
    ;Le a mensagem 
    mov     eax, 3
    mov     ebx, 1
    mov     ecx, buffer
    mov     edx, 256
    int     0x80
    
    ;imprime a mensgem 
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, buffer
    mov     edx, 256
    int     0x80
    
    ; "return 0;"
    mov     eax, 1
    mov     ebx, 0
    int     0x80
    
    
   ;Criado por YagoSP 15/03/2022 21:18 [SENAC RIB SALA 18]
