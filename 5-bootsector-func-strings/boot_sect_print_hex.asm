; receiving the data in dx 
; for the example we will assume that we're called with dx=0x1234
print_hex:
  pusha 

  mov cx, 0 ; our index var 

; get the last char of dx then convert to ascii 
; numeric ascii values: 0 (ascii 0x30) to 9 (0x39) so just add 0x30 to byte N 
; alphabetic chars A-F (0x41) - (0x46) so add 0x40
; then move the ascii byte to the correct position on the string

hex_loop:

  cmp cx, 4 ; loop 4 times
  je end

  ; 1 convert last char of dx 
  mov ax, dx ; using ax as our working register 
  and ax, 0x00f ; 0x1234 -> 0x0004 by masking first three zeros 
  add al, 0x30 ; add 0x30 to N to convert to ascii 
  cmp al, 0x39 ; if > 9 add extra 8 to represent A-F 
  jle step2
  add al, 7 ; A is ascii 65 instead of 58 so 65 -58 = 7

step2:
  ; 2 get the correct position of the string to place our ascii char
  ; bx <- base_address + string length - index of char 
  mov bx, HEX_OUT + 5 ; base + length 
  sub bx, cx ; our index var 
  mov [bx], al ; copy ascii char in al to position pointed by bx 
  ror dx, 4 ; 0x1234 -> 0x4321 -> 0x3412 -> 0x2341 -> 0x1234

  ; increment index and loop 
  add cx, 1
  jmp hex_loop

end:
  ; prepare the parm and call the func
  ; remeber that print receives parm in bx 
  mov bx, HEX_OUT
  call print 

  popa 
  ret 

HEX_OUT:
  db '0x0000', 0 