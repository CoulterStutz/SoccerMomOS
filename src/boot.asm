bits 16
org 0x7C00

start:
    mov ax, 0x07C0   ; Set up segments
    add ax, 0x20
    mov ss, ax
    mov sp, 0xFFFF

    mov ax, 0x07C0
    mov ds, ax

    ; Load kernel into memory (assuming kernel starts at sector 2)
    mov ah, 0x02     ; Read sector function
    mov al, 1        ; Number of sectors to read
    mov ch, 0        ; Cylinder number
    mov cl, 2        ; Sector number
    mov dh, 0        ; Head number
    mov dl, 0        ; Drive number
    mov bx, 0x1000   ; Load address
    int 0x13         ; BIOS interrupt call

    jmp 0x1000:0000  ; Jump to loaded kernel

times 510 - ($ - $$) db 0   ; Fill the rest of the sector with 0s
dw 0xAA55                   ; Boot signature
