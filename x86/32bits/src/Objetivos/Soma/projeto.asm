section .text
global _start
_start:

    mov eax, 1234567890
    mov ebx, 5
    add eax, ebx

    ; Convert EAX to ASCII and store it onto the stack
    sub esp, 16             ; reserve space on the stack
    mov ecx, 10
    mov ebx, 16
    .L1:
    xor edx, edx            ; Don't forget it!
    div ecx                 ; Extract the last decimal digit
    or dl, 0x30             ; Convert remainder to ASCII
    sub ebx, 1
    mov [esp+ebx], dl       ; Store remainder on the stack (reverse order)
    test eax, eax           ; Until there is nothing left to divide
    jnz .L1

    mov eax, 4              ; SYS_WRITE
    lea ecx, [esp+ebx]      ; Pointer to the first ASCII digit
    mov edx, 16
    sub edx, ebx            ; Count of digits
    mov ebx, 1              ; STDOUT
    int 0x80                ; Call 32-bit Linux

    add esp, 16             ; Restore the stack

    mov eax, 1              ; SYS_EXIT
    xor ebx, ebx            ; Return value
    int 0x80                ; Call 32-bit Linux