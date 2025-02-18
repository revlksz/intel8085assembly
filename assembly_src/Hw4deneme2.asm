START: IN 00h ; 00h portundan işlem seçimini oku
       CPI 00h ; Seçim "0" ise kontrol et
       JZ OPERATION_ZERO ; Eğer "0" ise, üs hesaplama işlemi yapılır
       JMP OPERATION_ONE ; Aksi durumda karekök hesaplama işlemi yapılır

OPERATION_ZERO: IN 01h ; 01h portundan sayıyı oku
               MOV B, A ; Çarpma için sayıyı B’ye taşı
               MVI C, 1 ; Üs sayacını 1 olarak başlat
               MOV D, A ; Sonuç (ilk üs) olarak sayıyı D’ye taşı

POWER_LOOP: MOV A, D ; Sonucu A'ya yükle
            CALL MULTIPLY ; A = A * B (Çarpma işlemi)
            JC OUTPUT_POWER ; Eğer taşma varsa, önceki geçerli üssü çıktıla
            MOV D, A ; Sonuç geçerliyse, D'ye kaydet
            INR C ; Üs sayacını artır
            JMP POWER_LOOP ; Döngüyü tekrar et

OUTPUT_POWER: MOV A, C ; Son üssü A'ya taşı
              OUT 02h ; 02h portuna üs değerini çıktıla
              JMP END ; Programı sonlandır

;------------------------
; OPERATION_ONE: En yakın tam kareyi ve karekökü bulur
;------------------------
OPERATION_ONE: IN 01h ; 01h portundan hedef değeri oku
               MOV C, A ; Hedef değeri C'ye taşı
               MVI B, 0 ; Dizi indeksi olarak başlangıç değeri 0
               MVI D, 16 ; Liste uzunluğu (16 tane kare sayımız var)
               MVI H, FFh ; En küçük farkı başlat (ilk değer yüksek olacak)
               MVI L, 0 ; Kareye karşılık gelen kök başlangıçta 0

FIND_CLOSEST_SQUARE: MOV A, B ; Dizideki şu anki indexi A'ya taşı
                     MOV E, M ; Mevcut kare sayıyı E'ye al
                     MOV A, C ; Hedef değeri A'ya yükle
                     SUB E ; Farkı hesapla (A - E)
                     JNC POSITIVE_DIFFERENCE ; Fark pozitifse atla
                     MOV A, E ; Fark negatifse, farkı pozitif yap
                     SUB C ; A = E - C, mutlak fark

POSITIVE_DIFFERENCE: MOV D, A ; Geçerli farkı D'ye taşı
                     MOV A, H ; Şu anki en küçük farkı yükle
                     SUB D ; Şu anki fark daha küçükse atla
                     JC UPDATE_CLOSEST ; Yeni fark daha küçükse en yakın kareyi güncelle
                     JMP CHECK_NEXT_SQUARE ; Bir sonraki kare sayıyı kontrol et

UPDATE_CLOSEST: MOV H, D ; Yeni en küçük farkı H'ye taşı
                MOV L, B ; Kare kökünü L'ye (en yakın kökü) taşı

CHECK_NEXT_SQUARE: INX B ; İndexi artır
                   DCR D ; Liste sonuna geldiysek çık
                   JNZ FIND_CLOSEST_SQUARE ; Döngüyü tekrar et

OUTPUT_SQUARE_ROOT: MOV A, L ; En yakın kök değerini A’ya yükle
                    OUT 02h ; 02h portuna karekökü çıktıla
                    JMP END ; Programı sonlandır

; ------------------------
; Kareler listesi
; ------------------------
squares: db 1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144, 169, 196, 225


; ------------------------
; MULTIPLY: A = B * B işlemini toplama yoluyla yapar
; ------------------------
MULTIPLY: MOV E, A ; E’yi sonuç olarak başlat
          MVI A, 0 ; A’yı sıfırla
          MOV D, B ; Çarpan B’yi D’ye taşı (toplama sayacı)

MULTIPLY_LOOP: ADD E ; E'yi topla
               DCR D ; Çarpanı azalt
               JNZ MULTIPLY_LOOP ; Sıfır değilse döngüyü tekrar et
               RET ; Sonucu A’da döndür

END: HLT ; Programı durdur