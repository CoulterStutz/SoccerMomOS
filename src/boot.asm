bits 16
org 0x7C00

start:
    mov ax, 0x07C0   ; Set up segments
    add ax, 0x20
    mov ss, ax
    mov sp, 0xFFFF

    mov ax, 0x07C0
    mov ds, ax

    mov ah, 0x0E      ; Print 'Press y to boot, n to halt'
    mov al, 'P'
    int 0x10
    mov al, 'r'
    int 0x10
    mov al, 'e'
    int 0x10
    mov al, 's'
    int 0x10
    mov al, 's'
    int 0x10
    mov al, ' '
    int 0x10
    mov al, 'y'
    int 0x10
    mov al, ' '
    int 0x10
    mov al, 't'
    int 0x10
    mov al, 'o'
    int 0x10
    mov al, ' '
    int 0x10
    mov al, 'b'
    int 0x10
    mov al, 'o'
    int 0x10
    mov al, 'o'
    int 0x10
    mov al, 't'
    int 0x10
    mov al, ','
    int 0x10
    mov al, ' '
    int 0x10
    mov al, 'n'
    int 0x10
    mov al, ' '
    int 0x10
    mov al, 't'
    int 0x10
    mov al, 'o'
    int 0x10
    mov al, ' '
    int 0x10
    mov al, 'h'
    int 0x10
    mov al, 'a'
    int 0x10
    mov al, 'l'
    int 0x10
    mov al, 't'
    int 0x10
    mov al, ':'
    int 0x10
    mov al, ' '
    int 0x10

    mov ah, 0       ; Wait for key press
    int 0x16
    cmp al, 'y'
    je boot
    cmp al, 'Y'
    je boot

halt:
    hlt             ; Halt the CPU

boot:
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
