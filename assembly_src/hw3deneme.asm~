;<Program title>

jmp start

;data


;code
start: nop

In 00h ; 00h input portundan değerin okunması

Mov b, A ; okunan değerin(İlk sayının) akümülatörden b register ına alınması

In 01h ;001h input portundan ikinci değerin okunması 

Mov c, A ; okunan değerin(ikinci sayının) akümülatörden c register ına alınması

In 02h ;  002h input portundan hangi işlemin yapılacağının belirlenmesi için değerin
       ; okunması(okunan değer akümülatörde bırakılacaktır.)

lxi h, 4200h ; H-L register çiftine 4200 değerinin 
             ;yüklenmesi(Bu komut pdf de belirtildiği gibi programda sadece bir kez kullanılmıştır)


;HANGİ İŞLEMİN YAPILACAĞININ BELİRLENMESİ

; 

CMP l ; Akümülatördeki hangi işlemin yapılacağının belirlenmesi için tutulan sayının H-L register 
      ;çiftiydeki 4200 ile karşılaştırılması. 
JZ addition
Inx h 

CMP l 
JZ subtraction 
Inx h

CMP l 
JZ multiplication
Inx h

CMP l
JZ division


addition: Nop
Mov a, b 

add c

jmp result

subtraction: nop

mov a, b

sub c

jmp result


multiplication: nop

mov a, b

mov d, c

Loop: nop

dcr d

jz Exit_loop

add b

jmp Loop

Exit_loop: nop

jmp result

division: nop

Mov a,b

Loop2: nop

CMP c

JC Exit_division

Sub c

inr d

JMP Loop2

Exit_division: nop


Mov a, d

result: nop

out 03h

hlt