section .data
    msg1    db    'Input Number: ', 0xA
    len1    equ    $-msg1

section .bss
    var1    resd    1
    var2    resd    1
    result  resd    1

section .text
    global _start

_start:
    mov    eax, 0x4
    mov    ebx, 0x1
    mov    ecx, msg1
    mov    edx, len1
    int    0x80

    mov    eax, 0x3
    mov    ebx, 0x1
    mov    ecx, var1
    mov    edx, 8
    int    0x80

    mov    eax, 0x4
    mov    ebx, 0x1
    mov    ecx, msg1
    mov    edx, len1
    int    0x80

    mov    eax, 0x3
    mov    ebx, 0x1
    mov    ecx, var2
    mov    edx, 8
    int    0x80

    mov    eax, [var1]
    add    eax, [var2]
    mov    [result], eax
    int    0x80

    mov    eax, 0x4
    mov    ebx, 0x1
    mov    ecx, result
    mov    edx, 8
    int    0x80

exit:
    mov    eax, 1
    mov    ebx, 0
    int    0x80
    
;Ainda não funfa :)
