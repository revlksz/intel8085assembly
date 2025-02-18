;@author: 152120081026 @savasokyay
;@brief:  8-bit bcd "array" sum 

start: 	lxi h, arr
	mvi c, 6   ; hard-codded value is acceptable for such program

myloop:	call sumbcd ; look at stack values and SP
	inx h ; not inr M
	dcr c ; remaining loop iter count
	jnz myloop

	; send the final (hex) result to first two ports
	out 01h ; high byte
	mov a, e
	out 00h ; low byte
	
	hlt

;@brief:  this subroutine sums 8-bit values in bcd
;@input:  [HL]
;@output: holds the 16-bit sub-result in register pair DE
sumbcd: mov b, m ; just to track the number in action
	
	; low-byte
	mov a, e
	add m
	daa
	mov e, a

	; high-byte
	mvi a, 0
	adc d ; A = D + A + CF; since A=0 it fits to handle D+CF
	mov d, a
	;high-byte should also be managed by using DAA. 
	;Complete the code as an exercise.

	ret ; it will use the stack value to return back where it called.
;data
arr: db 13h, 17h, 83h, 37h, 90h, 79h


