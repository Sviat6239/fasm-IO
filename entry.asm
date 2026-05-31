format elf64 executable 3
entry _entry

segment readable executable
    _entry:

        mov rax, 1
        mov rdi, 1
        mov rsi, entryprompt
        mov rdx, entryprompt_len
        syscall

        mov rax, 1
        mov rdi, 1
        mov rsi, newline
        mov rdx, newline_len
        syscall
        
        mov rax, 0
        mov rdi, 0
        mov rsi, userinput
        mov rdx, 200
        syscall
        mov r10, rax

        mov rax, 1
        mov rdi, 1
        mov rsi, newline
        mov rdx, newline_len
        syscall

        mov rax, 1
        mov rdi, 1
        mov rsi, msg1
        mov rdx, msg1_len
        syscall

        mov rax, 1
        mov rdi, 1
        mov rsi, userinput
        mov rdx, r10
        syscall

        mov rax, 60
        xor rdi, rdi
        syscall
        
segment readable writable

    entryprompt db "Enter stm: "
    entryprompt_len = $ - entryprompt

    userinput rb 200

    msg1 db "You have been entered: "
    msg1_len = $ - msg1

    newline db " ", 10
    newline_len = $ - newline