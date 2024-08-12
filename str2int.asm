section .data
    msg db 'Digite um numero: ', 0xA
    len equ $ - msg

section .bss
    var resb 10          ; Reserva espaço para a entrada do usuário (10 bytes para números grandes)
    result resb 11       ; Reserva espaço para o resultado como string (10 dígitos + null terminator)

section .text
global _start

_start:
    ; Exibir a mensagem
    mov eax, 0x4        ; syscall number for sys_write
    mov ebx, 0x1        ; file descriptor 1 (stdout)
    mov ecx, msg        ; pointer to message
    mov edx, len        ; length of message
    int 0x80            ; call kernel

    ; Ler a entrada do usuário
    mov eax, 0x3        ; syscall number for sys_read
    mov ebx, 0x0        ; file descriptor 0 (stdin)
    mov ecx, var        ; pointer to buffer
    mov edx, 10         ; number of bytes to read
    int 0x80            ; call kernel

    ; Converter a entrada de string para inteiro
    mov esi, var        ; pointer to input buffer
    mov eax, 0          ; clear eax to accumulate the result

convert_loop:
    movzx ebx, byte [esi] ; load byte from buffer
    test ebx, ebx        ; check for null terminator
    jz print             ; if zero, end of string

    sub ebx, '0'        ; convert ASCII to integer
    imul eax, eax, 10    ; multiply accumulator by 10
    add eax, ebx        ; add digit to accumulator

    inc esi             ; move to next character
    jmp convert_loop    ; repeat loop

print:
    ; Converter o número inteiro para string
    mov edi, result     ; pointer to result buffer
    add edi, 10         ; move to end of buffer
    mov byte [edi], 0   ; null terminator
    dec edi             ; move back one byte

convert_to_string:
    xor edx, edx        ; clear edx for division
    div dword [10]      ; divide eax by 10 (quotient in eax, remainder in edx)
    add dl, '0'         ; convert remainder to ASCII
    mov [edi], dl       ; store digit in buffer
    dec edi             ; move buffer pointer back
    test eax, eax        ; check if quotient is zero
    jnz convert_to_string ; if not zero, continue

    ; Exibir o resultado
    mov eax, 0x4        ; syscall number for sys_write
    mov ebx, 0x1        ; file descriptor 1 (stdout)
    mov ecx, edi        ; pointer to result buffer
    mov edx, result + 11 - edi ; length of result
    int 0x80            ; call kernel

    ; Finalizar o programa
    mov eax, 0x1        ; syscall number for sys_exit
    xor ebx, ebx        ; exit code 0
    int 0x80            ; call kernel
