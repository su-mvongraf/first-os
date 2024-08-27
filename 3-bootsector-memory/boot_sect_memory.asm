mov ah, 0x0e ; move 14 to the most significant byte


; attempt one
; Fails becuase it tries to print the memory address (i.e. pointer)
; not it's contents
mov al, "1"
int 0x10
mov al, the_secret
int 0x10

; attempt 2 
; it tries to print the memory address of 'the_secrect' which is the right approach
; but doesn't take into account our place in the bootsector
mov al, "2"
int 0x10
mov al, [the_secret]
int 0x10

; attempt 3
; it adds the the_secrect to bx a "free memory sector"
; then adds the offset 0x7c00
; we need to use bx because ax is being used as a source and it can't the destination as well
; then it dereferences the contents of that pointer bx
mov al, "3"
int 0x10
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

; attempt 4
; We try a shortcut since we know that the X is stored at byte 0x2d in our binary
; That's smart but ineffective, we don't want to be recounting label offsets
; every time we change the code
mov al, "4"
int 0x10
mov al, [0x7c2d]
int 0x10


jmp $ ; infinite loop

the_secret:
    ; ASCII code 0x58 ('X') is stored just before the zero-padding.
    ; On this code that is at byte 0x2d (check it out using 'xxd file.bin')
    db "X"

; zero padding and magic bios number
times 510-($-$$) db 0
dw 0xaa55
