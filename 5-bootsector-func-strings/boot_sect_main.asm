[org 0x7c00]

mov bx, HELLO

call print 

call print_nl

mov bx, GOODBYE

call print

mov dx, 0x12fe
call print_hex

;now we hang 
jmp $

%include "boot_sect_print.asm"
%include "boot_sect_print_hex.asm"

; data/vars
HELLO:
  db 'Hello World', 0 ; add a null byte to indicate the string is done

GOODBYE:
  db 'Goodbye', 0 

; padding and magic number to indicate boot sector
times 510-($-$$) db 0
dw 0xaa55