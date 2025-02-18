; @author - Resul Evleksiz - 152120211072

; @brief - 4 işlem hesap makinesi
; Port 00h: İlk sayı
; Port 01h: İkinci sayı
; Port 02h: İşlem (1: Toplama, 2: Çıkarma, 3: Çarpma, 4: Bölme)
; Port 03h: Sonuç

jmp start	;input için başlangıca git

add_process:	nop
    ; Toplama işlemi
	mov a, b        ; İlk sayıyı A'ya geri yükle
	add c           ; A = A + C
	out 03h         ; Sonucu port 03h'e yaz
	hlt             ; Programı durdur

    ; Portlardan sayıları al
start:	nop
	in 00h          ; İlk sayıyı al
	mov b, a        ; B registerına taşı
    
	in 01h          ; İkinci sayıyı al
	mov c, a        ; C registerına taşı
    
	in 02h          ; İşlem kodunu al
	cpi 01h         ; İşlem kodu 1 mi? (Toplama)
	jnz check_sub   ; Eğer işlem kodu toplama değilse çıkarma kontrolüne git
    
    ; Toplama işlemi için PCHL'yi kullan
	lxi h, 4203h    ; 4203h(4200 + jump 3byte) adresindeki toplama işleminin adresini HL'ye yükle
	pchl            ; PCHL ile toplama işlemi adresine git (jump gibi)

check_sub:	nop
		cpi 02h         ; İşlem kodu 2 mi? (Çıkarma mı)
		jnz check_mul   ; Eğer işlem kodu çıkarma değilse çarpma kontrolüne git
    
		jmp sub_process ; Çıkarma ise işleme git

check_mul:	nop
		cpi 03h         ; İşlem kodu 3 mü? (Çarpma mı)
		jnz check_div   ; Eğer işlem kodu çarpma değilse bölme kontrolüne git
    
		jmp multi_process ; Çarpma ise işleme git


check_div:	nop
		cpi 04h         ; İşlem kodu 4 mü? (Bölme mi)
		jnz invalid     ; Eğer işlem kodu bölme değilse (hiçbiri değil, geçersiz) durdur
    
		jmp div_process ; Geçersiz değilse bölme işlemine git


invalid:	nop
		hlt             ; Geçersiz işlem kodu geldi, programı durdur


sub_process:	nop
    ; Çıkarma işlemi
		mov a, b        ; İlk sayıyı A'ya geri yükle
		sub c           ; A = A - C
		out 03h         ; Sonucu port 03h'e yaz
		hlt             ; Programı durdur

multi_process:	nop
    ; Çarpma işlemi

		mov a, b        ; İlk sayıyı A'ya geri yükle
		mov e, c        ; İkinci sayıyı E'ye taşı


multi_loop:	nop
		add d		; d ile accumulator topla
		mov d, a	; Toplananı d ye yaz
		mov a, b	; Sayımızı tekrar a ya yaz
		dcr e           ; E'yi bir azalt (counter gibi)
		jnz multi_loop  ; E sıfır değilse tekrar et

		mov a, d	; Loop (çarpma) bitince output işlemi için sonucu a ya yaz
		out 03h         ; Sonucu a dan port 03h'e yaz
		hlt             ; Programı durdur

div_process:	nop
    ; Bölme işlemi
		mov a, c        ; Bölücü(ikinci) C'deki sayıyı a ya al (0 kontrol edebilmek için)
		cpi 00h         ; Sıfıra bölme var mı kontrolü
		jz div_zero     ; Eğer C sıfırsa sıfıra bölme hatası
		mov a, b	; Sayımızı kontrolden sonra a ya al
		mvi l, 00h	; bölüm sonucu için l yi sıfırla
		dcx h		; kalan olduğunda tekrar çıkabildiği için counter'ı eksik başlat

div_loop:	nop
    		sub c           ; A = A - C (Bölüm işlemi)
    		inx h           ; Bölüm sonucu H registerına yaz (counter gibi)
    		jc div_end      ; Eğer negatifse bölmeyi bitir
    		jmp div_loop    ; Bölme işlemini tekrarla

div_zero:	nop		; Sıfıra bölmeye çalışırsa durdur
    		hlt             ; Programı durdur

div_end:	nop
    		mov a, l        ; Bölüm sonucunu A'ya yükle
    		out 03h         ; Sonucu port 03h'e yaz
    		hlt             ; Programı durdur


