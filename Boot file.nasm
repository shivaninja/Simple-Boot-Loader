; bootloader.asm
[org 0x7C00]         ; BIOS loads the bootloader at memory location 0x7C00
bits 16

start:
    cli             ; Clear interrupts
    xor ax, ax
    mov ds, ax      ; Set DS = 0
    mov es, ax      ; Set ES = 0

    mov si, message

print_loop:
    lodsb           ; Load byte at DS:SI into AL, then SI++
    cmp al, 0
    je hang         ; If null terminator, jump to hang
    mov ah, 0x0E    ; BIOS teletype function
    int 0x10        ; Print character in AL
    jmp print_loop

hang:
    jmp $           ; Infinite loop (halt)

message db "Hello from x86 bootloader!", 0

; Pad to 510 bytes with zeros
times 510-($-$$) db 0

; Boot signature (2 bytes)
dw 0xAA55
