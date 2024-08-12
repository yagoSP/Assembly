section .data
    msg db 'Digite um numero: ', 0xA
    len equ $ - msg

section .bss
    var resb 10
    result resb 11

section .text
global _start

_start:
    ; Exibir mensagem
    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, msg
    mov edx, len
    int 0x80

    ; Ler entrada
    mov eax, 0x3
    mov ebx, 0x0
    mov ecx, var
    mov edx, 10
    int 0x80

    ; Converter string para inteiro
    mov esi, var
    mov eax, 0

convert_loop:
    movzx ebx, byte [esi]
    test ebx, ebx
    jz print

    sub ebx, '0'
    imul eax, eax, 10
    add eax, ebx

    inc esi
    jmp convert_loop

print:
    mov edi, result
    add edi, 10
    mov byte [edi], 0
    dec edi

convert_to_string:
    xor edx, edx
    div dword [10]
    add dl, '0'
    mov [edi], dl
    dec edi
    test eax, eax
    jnz convert_to_string

    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, edi
    mov edx, result + 11 - edi
    int 0x80

    mov eax, 0x1
    xor ebx, ebx
    int 0x80
