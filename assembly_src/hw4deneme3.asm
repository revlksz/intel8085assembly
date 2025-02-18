; @author - Resul Evleksiz
; @number - 152120211072

in 00h                 	; İlk giriş (00h portundan) alınır, işlem türünü belirleyecek
cpi 00h                	; A registerindeki değeri 00h ile karşılaştırır
jz power_calculate     	; Eğer 00h ise (işlem karesini alma), karesini alma işlemine git

cpi 01h                	; A registerindeki değeri 01h ile karşılaştırır
jz root_calculate      	; Eğer 01h ise (işlem karekök bulma), karekök alma işlemine git

jmp end			; ikisinden biri değilse bitişe git



; @brief - 8  bite sığabilen en yüksek kuvveti bulma
power_calculate:	nop
			in 01h             ; İkinci giriş (01h portundan), hedef sayıyı alır
    			mov b, a           ; A registerindeki sayıyı B'ye kopyala
    			mov d, a           ; A registerindeki sayıyı D'ye kopyala (karesini almak için)
    			mvi c, 01h         ; C registerine 1 yükle (üs sayacı)
    			jmp power_loop     ; kuvvet bulma döngüsüne git



; @brief - en yakın tamkare sayının karekökünü bulma
root_calculate:	nop
    		in 01h             ; İkinci giriş (01h portundan), sayıyı alır
    		mov c, a           ; Alınan değeri C registerine yükle
    		mvi b, 01h         ; Kök bulma denemesi için başlangıç değeri olarak B'ye 1 yükle
    		jmp closest_square ; En yakın tamkare sayıyı bulma döngüsüne git

; @brief - kuvvet veya karekök sonucunu 02h portuna yazdırma (eşit mesafeli olmadığı için 03h yazdırılamaz hiçbir zaman)
output_power:	nop
    		mov a, c           ; Bulduğumuz kuvvet değerini A’ya yükle
    		out 02h            ; 02h portuna çıktı olarak gönder
    		jmp end           

output_root:	nop
    		mov a, b           ; En yakın karekök sonucunu A'ya yükle
    		out 02h            ; 02h portuna çıktı olarak gönder
    		jmp end            

end:	hlt                ; Programı durdur



; @brief - kuvvet değerini bulmak için gereken döngü
power_loop:	nop
    		mov a, d           	; D registerindeki değeri A'ya kopyala
    		call multiplication 	; Kendi içinde çarpma işlemini yapan alt yordamı çağır
    		jc output_power     	; Taşma durumunda, sonucu çıkışa gönder
    		mov d, a           	; Çarpım sonucunu D registerine kopyala
    		inr c              	; Sayacımızı 1 arttır (kuvvet için)
    		jmp power_loop    	; Döngüyü tekrarla




; @brief - kendine en yakın tamkareyi bulmak için 1 den itibaren tamkare ifadeleri tek tek kontrol eden routine
closest_square:	nop
		mov a, b              ; B'deki değeri A'ya yükle
		call multiplication   ; A * A işlemini yaparak kareyi hesapla
		mov h, a              ; Sonucu H registerine kopyala
		mov a, c              ; Orijinal sayı C'den A'ya kopyalanır
		sub h                 ; Orijinal sayıdan kare çıkarılarak fark hesaplanır
		jc output_root        ; Eğer kare, sayıyı aşıyorsa bir önceki B değeri en yakın karekök olur
		inr b                 ; Kare küçükse B’yi bir arttırarak bir sonraki adaya geçiyoruz
		jmp closest_square    ; Döngüyü tekrarla




; @brief - üstel ifadede kullanılacak çarpma işlemi ve loopu
multiplication:	nop
    		mov e, a           ; E'ye çarpan değeri yükle
    		mvi a, 00h         ; Çarpım sonucu tutulacak A'yı sıfırla
    		mov d, b           ; Diğer çarpanı D'ye yükle
    		jmp multiply_loop  ; Çarpma döngüsüne git

multiply_loop:	nop
    		add e              ; E'deki değeri A'ya ekle
    		dcr d              ; D'yi bir azalt
    		jnz multiply_loop  ; D sıfır olmadıkça döngüyü devam ettir
    		ret                ; Çarpma işlemi tamamlanınca alt yordamdan çık