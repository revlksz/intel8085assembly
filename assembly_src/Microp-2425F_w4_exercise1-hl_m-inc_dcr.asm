
;<Program title>

jmp start

;data


;code
start: 	nop
	mvi M, 0001h
	inr M
	inx h
	inr M
	inx h
	dcr M ; look at the flags - check the instruction sheet

	sui 1 ; look at the flags - check the instruction sheet

	hlt