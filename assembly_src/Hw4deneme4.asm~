; @brief - verilen işlem değerine göre verilen sayının karesini alma veya karekökünün tamsayı değerini döndürme işlemleri

	in 00h                ; İlk giriş (00h portundan) alınır, işlem türünü belirleyecek
	cpi 00h               ; A registerindeki değeri 00h ile karşılaştırır
	jz power_calculate    ; Eğer 00h ise (işlem karesini alma), karesini alma işlemine git

	cpi 01h               ; A registerindeki değeri 01h ile karşılaştırır
	jz root_calculate     ; Eğer 01h ise (işlem karekök alma), karekök alma işlemine git

; **Karesini Alma İşlemi Başlangıcı**
power_calculate:       nop
	in 01h                ; İkinci giriş (01h portundan), sayıyı almak için yapılır
	mov b, a              ; A registerindeki sayıyı B'ye kopyala
	mov d, a              ; A registerindeki sayıyı D'ye kopyala (karesini almak için)
	mvi c, 01h            ; C registerine 1 yükle (üs sayacı)
	jmp power_loop        ; Karesini alma döngüsüne git

power_loop:             nop
	mov a, d              ; D registerindeki değeri A'ya kopyala
	call multiplication   ; Kendi içinde çarpma işlemini yapan alt yordamı çağır
	jc output_power       ; Taşma durumunda, sonucu çıkışa gönder
	mov d, a              ; Çarpım sonucunu D registerine kopyala
	inr c                 ; Sayacımızı 1 arttır (üs için)
	jmp power_loop        ; Döngüyü tekrarla

; **Karekök Alma İşlemi Başlangıcı**
root_calculate:        nop
	in 01h                ; İkinci giriş (01h portundan), sayıyı almak için yapılır
	mov c, a              ; Alınan değeri C registerine yükle
	mvi b, 01h            ; Kök bulma denemesi için başlangıç değeri olarak B'ye 1 yükle
	jmp closest_square    ; En yakın kare sayıyı bulma döngüsüne git

closest_square:      nop
	mov a, b              ; B'deki değeri A'ya yükle
	call multiplication   ; A * A işlemini yaparak kareyi hesapla
	mov h, a              ; Sonucu H registerine kopyala
	mov a, c              ; Orijinal sayı C'den A'ya kopyalanır
	sub h                 ; Orijinal sayıdan kare çıkarılarak fark hesaplanır
	jc output_root        ; Eğer kare, sayıyı aşıyorsa bir önceki B değeri en yakın karekök olur
	inr b                 ; Kare küçükse B’yi bir arttırarak bir sonraki adaya geçiyoruz
	jmp closest_square    ; Döngüyü tekrarla

; **Çıkış İşlemleri**
output_power:       nop
	mov a, c              ; Sayacın (karesini aldığımız sayı) sonucunu A’ya yükle
	out 02h               ; 02h portuna çıktı olarak gönder
	jmp end               ; Programın sonuna git

output_root:     nop
	dcr b                 ; Bir önceki B değeri en yakın karekök olarak kullanılır
	mov a, b              ; En yakın karekök sonucunu A'ya yükle
	out 02h               ; 02h portuna çıktı olarak gönder
	jmp end               ; Programın sonuna git

end:    hlt                   ; Programı durdur

; **Çarpma Alt Yordamı**
multiplication: nop
	mov e, a              ; E'ye çarpan değeri yükle
	mvi a, 00h            ; Çarpım sonucu tutulacak A'yı sıfırla
	mov d, b              ; Diğer çarpanı D'ye yükle
	jmp multiply_loop     ; Çarpma döngüsüne git

multiply_loop:     nop
	add e                 ; E'deki değeri A'ya ekle
	dcr d                 ; D'yi bir azalt
	jnz multiply_loop     ; D sıfır olmadıkça döngüyü devam ettir
	ret                   ; Çarpma işlemi tamamlanınca alt yordamdan çık
