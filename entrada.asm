section .data
    msg db 'Entrada de dados!', 0xA
    tam equ $-msg

section .bss
    var resb 1
    
section .text 
global _start
_start:
    mov eax, 0x4 ;syscall write
    mov ebx, 0x1 ;std_out (terminal)
    mov ecx, msg
    mov edx, tam 
    int     0x80
    
    mov eax, 0x3 ;syscall read
    mov ebx, 0x0 ;std_in
    mov ecx, var
    mov edx, 0xA
    
    mov eax, 0x1
    mov eax, 0x0
    int     0x80
    
;Criado por YAgoSP 11/12/2022 15:46
;nasm -f elf stairway.asm; ld -m elf_i386 -s -o stairway stairway.o
