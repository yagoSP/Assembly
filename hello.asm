segment .data 
        sys_call        equ 0x80
        write           equ 0x4
        std_out         equ 0x1
        sys_exit        equ 0x1
        return          equ 0x0
        
        
section .data
        msg   db    'Hello Assembler!', 0AH
        tam   equ   $-msg

section .text
global _start
_start: 
        mov     eax, write
        mov     ebx, std_out
        mov     ecx, msg
        mov     edx, tam
        int     sys_call
        
        mov     eax, sys_exit
        mov     ebx, return
        int     sys_call
        
;Comentários
;YagoSP // Primeiro código em assembly
;'Hello Assembler' 
;Criado 19/12/2021
;Editado 03/01/2022

;nasm -f elf hello.asm
;ld -m elf_i386 -s -o hello hello.o
