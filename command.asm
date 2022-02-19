section .data
	ln1		db		"nasm -f elf  archive.asm", 0xA
	tam1 	equ		$-ln1
	ln2		db		"ld -m elf_i386 -s -o archive archive.o", 0xA
	tam2	equ		$-ln2
section .text
global _start
_start:
	mov		eax, 4
	mov 	ebx, 1
	mov 	ecx, ln1
	mov 	edx, tam1
	int 	0x80
	
	mov 	eax, 4
	mov 	ebx, 1
	mov 	ecx, ln2
	mov 	edx, tam2
	int 	0x80
	
	mov 	eax, 1
	mov		ebx, 0
	int 	0x80
;Criado por YagoSP 
;OS = Linux Mint Sarah
;18/02/2022 23:54 [FR]
