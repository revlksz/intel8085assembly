
	
start:	lxi h, order
	lxi d, variables
	mvi c, 6

sort_loop:	call sort
		inx h
		inx d
		dcr c
		jnz sort_loop
		jmp reset


sort:	mov a, m
	push h 
	xchg
	mov b, m
	xchg
	mvi h, 10h
	dcr a
	mov l, a
	mov m, b
	pop h
	ret

reset:	lxi h, 1000h
	lxi d, 0000h
	dcx h
	mvi c, 3
	
summation_loop:	nop
		call summation
		dcr c
		jnz summation_loop
		lxi h, 1006h
		mov m, d
		inx h
		mov m, e
		hlt

summation:	inx h
		mov a, m
		daa
		add d
		mov d, a


		inx h
		mov a, m
		daa
		add e
		mov e, a
		ret
		
		

	

order: db 05h, 06h, 01h, 02h, 03h, 04h
variables: db 15h, 21h, 20h, 21h, 10h,72h
