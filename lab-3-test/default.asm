.686
.model flat

extern _ExitProcess@4 : proc
extern __write : proc
extern __read : proc

public _main

.data

znaki_eax db 12 dup (?)

obszar db 12 dup (?)	; rezerwacja 12 znaków

wczytywana_liczba db 0

flaga_liczba_ujemna db 0, 0, 0, 0

.code

wyswietl_EAX proc
	
	pusha

	mov	esi, 10 ; indeks w tablicy znaki_eax , 10 bo maksymalna wartosc eax ma tyle cyfr
	mov ebx, 10 ; dzielnik rowny 10

konwersja:
	mov edx, 0 ; wyzeruj starsz¹ czêœæ dzielnej
	div ebx ; dzielenie przez 10, iloraz w eax, reszta w edx

	add dl, 30h ; zamiana na ascii

	mov znaki_eax[esi], dl ; zapisz znak w ascii

	dec esi ; zmniejsz indeks
	cmp eax, 0 ; porownaj dzieln¹ z zerem
	jne konwersja ; powtarzaj dopoki dzielna nie jest zerem

wypelnij:
	or esi, esi
	jz wyswietl ; wyswietl kiedy esi == 0

	mov byte ptr znaki_eax[esi], 20h ; zapisz spacje
	dec esi
	jmp wypelnij

wyswietl:
	mov znaki_eax[0], 20h ; zapisz spacje
	mov cl, flaga_liczba_ujemna[3]
	cmp cl, 1
	jne gotowe

	mov znaki_eax[0], 45 ; zapisz znak minusa

gotowe:
	;mov byte ptr znaki_eax[0], 0ah ; pierwszy i ostatni element znakow beda '\n'
	mov byte ptr znaki_eax[11], 0ah

	push dword ptr 12 ; liczba znakow tekstu
	push dword ptr offset znaki_eax
	push dword ptr 1
	call __write
	add esp, 12

	popa
	ret
wyswietl_EAX endp

wczytaj_8 proc
	push ebx
	push ecx
	push edx
	push edi
	push esi

wczytaj_liczbe: ; petla wykonujaca sie dwa razy

	mov cl, wczytywana_liczba[0]
	inc cl
	mov [wczytywana_liczba], cl ; inkrementuj iterator
	
	mov ebx, eax

	push dword ptr 10 ; wczytywanie 10 znakow
	push offset obszar ; wczytujemy do adresu
	push 0 ; numer urzadzenia
	call __read

	add esp,12 ; usuniecie param ze stosu

	xor eax, eax ; wyzeruj eax
	xor esi, esi
petla_glowna:
	
	mov dl, obszar[esi] ; wczytaj kolejne znaki
	inc esi

	cmp dl, 10 ; jezeli enter to sprawdz ktora liczba jest wczytywana
	je gotowe

	cmp dl, '7'
	ja petla_glowna ; kazdy znak wiekszy od 7 jest ignorowany

	cmp dl, '0' 
	jb sprawdz_liczba_ujemna ; jezeli mneijsza od 0 to sprawdzaj dalej

	; poczatek konwersji

	sub dl, '0' ; konwertuj ascii na cyfre

dopisz:

	shl eax, 3 ; przesuj eax o trzy miejsca
	or al, dl ; dopisz trzy bity z wejscia do eax
	jmp petla_glowna ; wczytuj dalsze liczby

sprawdz_liczba_ujemna:
	
	cmp dl, 45
	jne petla_glowna ; jezeli nie jest myslnikiem, to ignoruj znak

	; ustaw flage na liczbe ujemna
	xor ecx, ecx
	mov cl, wczytywana_liczba[0]
	mov flaga_liczba_ujemna[ecx], 1
	jmp petla_glowna ; wczytuj dalej liczby
gotowe:

	mov cl, wczytywana_liczba[0]
	cmp cl, 1
	je wczytaj_liczbe ; jezeli wczytalismy tylko jedna liczbe to zrob wszystko od nowa
						; inaczej zapisz na wynik

	mov cl, flaga_liczba_ujemna[1]
	cmp cl, 1
	jne pierwsza_nieujemna

	; pierwsza liczba jest ujemna

	neg ebx ; zamien liczbe na przeciwna

pierwsza_nieujemna:
	
	mov cl, flaga_liczba_ujemna[2]
	cmp cl, 1
	jne obie_dodatnie

	neg eax

obie_dodatnie:
	; obie dodatnie

	add eax, ebx
	
	test eax,eax 
	jns koniec
	
	neg eax
	mov flaga_liczba_ujemna[3], 1

koniec:
	pop ebx
	pop ecx
	pop edx
	pop edi
	pop esi
	ret
wczytaj_8 endp

_main proc
	
	call wczytaj_8

	call wyswietl_EAX
	
	push	0
	call _ExitProcess@4
_main endp

END