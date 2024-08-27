mov ah, 0x0e ; tty mode
mov al, 'H' ; load the assic letter h into the al register
int 0x10 ; this is a bios interrupt
mov al, 'e' 
int 0x10 
mov al, 'l'
int 0x10
int 0x10 ; duplicate to print l twice
mov al, 'o'
int 0x10

jmp $ ; jump to current address = infinite loop

; padding and magic number
times 510 -($-$$) db 0
dw 0xaa55