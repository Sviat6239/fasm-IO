format elf64 executable 3 ; ELF64 executable format
entry _entry ; entry point

segment readable executable ; code (executable) segment
    _entry: ; entry point label

        ; write: syscall write(fd=1, buf=entryprompt, count=entryprompt_len)
        mov rax, 1 ; syscall number: 1 = write
        mov rdi, 1 ; arg0: file descriptor (1 = stdout)
        mov rsi, entryprompt ; arg1: pointer to the message buffer
        mov rdx, entryprompt_len ; arg2: number of bytes to write
        syscall

        ; write newline (just a line feed)
        mov rax, 1
        mov rdi, 1
        mov rsi, newline
        mov rdx, newline_len
        syscall
        
        ; read: syscall read(fd=0, buf=userinput, count=200)
        mov rax, 0 ; syscall number: 0 = read
        mov rdi, 0 ; arg0: fd = 0 (stdin)
        mov rsi, userinput ; arg1: pointer to input buffer
        mov rdx, 200 ; arg2: maximum bytes to read (buffer size 200)
        syscall
        ; after read, rax contains the number of bytes read (or negative error)
        mov r10, rax ; save number of bytes read in r10 (r10 is preserved across syscall)

        ; write newline
        mov rax, 1
        mov rdi, 1
        mov rsi, newline
        mov rdx, newline_len
        syscall

        ; write message: 'You have been entered: '
        mov rax, 1
        mov rdi, 1
        mov rsi, msg1
        mov rdx, msg1_len
        syscall

        ; write the actual user input using saved length in r10
        mov rax, 1
        mov rdi, 1
        mov rsi, userinput
        mov rdx, r10 ; use saved length (number of bytes)
        syscall

        ; exit(status=0): syscall exit
        mov rax, 60 ; syscall number: 60 = exit
        xor rdi, rdi ; status = 0
        syscall
        
segment readable writable ; data section (readable/writable)

    entryprompt db "Enter stm: " ; prompt (no terminating NUL)
    entryprompt_len = $ - entryprompt ; prompt length

    userinput rb 200 ; input buffer (200 bytes)

    msg1 db "You have been entered: " ; message before echoing input
    msg1_len = $ - msg1 ; message length

    newline db " ", 10 ; space + LF (remove the space if not needed)
    newline_len = $ - newline ; newline length