section .data
	msg 	db	'Digite um numero', 0xA
	len 	equ	$-msg

section .bss
	var	resd	2
	result 	resd 	2
section .text
global _start

_start:
	
	mov 	eax, 0x4
	mov	ebx, 0x1
	mov 	ecx, msg
	mov 	edx, len
	int 	0x80
	
	mov 	eax, 0x3
	mov	ebx, 0x0
	mov 	ecx, var
	mov 	edx, 8
	int 	0x80

	mov	esi, [var]
	mov	eax, 0

convert:
	movzx	eax, byte [esi]
	test	eax, eax
	jz	print

	sub	eax, '0'
	imul	eax, eax, 10
	add 	eax, ecx
	
	inc 	esi
	jmp 	convert
	

print:
	mov	[result], eax
	
	mov 	eax, 0x4
	mov 	ebx, 0x1
	mov 	ecx, result
	mov 	edx, 8
	int 	0x80
	
	mov	eax, 0x1
	mov 	ebx, 0x0
	int 	0x80
