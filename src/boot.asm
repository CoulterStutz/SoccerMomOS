mov ax, 9ch
mov ss, ax
mov sp, 4096d
mov ax, 7c0h

; blank bootloader

jmp $

times 510-($-$$) db 0
dw 0xAA55
