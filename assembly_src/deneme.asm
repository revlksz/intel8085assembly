;@author : 152120211072 - Resul Evleksiz

;order	   -> 03h, 02h, 01h, 04h, 06h, 05h
;variables -> 15h, 21h, 20h, 21h, 10h, 72h  





start: lxi h, order 	  ;address of first index of variables array will b in hl register
       lxi d, number_arr ;address of first index of order array will be in de register
       mvi c, 6 	  ;number of variables is 6

;	main loop for sorting
loop: call sorting	  ;calls sorting subroutine for sort process
      inx h		  ;inc for hl register(next index of variables)
      inx d		  ;inc for de register(next index of order)
      dcr c       	  ;iteration number should be decreased
      jnz loop 		  ;if count not 0, go loop
      hlt

sorting: mov a, m 	 
	 ani 0fh 	;for ex: 04h -> 4 and 4 will be in a
	 mov b, a	
	
	 cpi 01h
	 jz store_value

	 cpi 02h
	 jz store_value

	 cpi 03h
	 jz store_value

	 cpi 04h
	 jz store_value

	 cpi 05h
	 jz store_value

	 cpi 06h
	 jz store_value
	
	 jmp end_sorting

store_value: lxi h, number_arr
	     mov a, m

	     dcr b
	     mov m, a

end_sorting: ret


sorted_arr: equ 1000h	;resorted array will be in 1000h
order:	    db 03h, 02h, 01h, 04h, 06h, 05h	;order can be change
number_arr: db 15h, 21h, 20h, 21h, 10h, 72h	;data which will be sorted