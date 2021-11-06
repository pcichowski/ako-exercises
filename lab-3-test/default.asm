.686
.model flat

extern _ExitProcess@4 : proc
extern __write : proc

public _main

.data

znaki_eax db 12 dup (?)

elem dd ?

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
	mov byte ptr znaki_eax[0], 0ah ; pierwszy i ostatni element znakow beda '\n'
	mov byte ptr znaki_eax[11], 0ah

	push dword ptr 12 ; liczba znakow tekstu
	push dword ptr offset znaki_eax
	push dword ptr 1
	call __write
	add esp, 12

	popa
	ret
wyswietl_EAX endp

_main proc
	
	mov esi, 1 ; ustaw esi na 1
	pierwsze_50:

	mov eax, esi
	mul eax ; policz eax^2

	sub eax, esi ; policz eax^2 - eax
	add eax, 2; policz eax^2 - eax + 2

	mov ecx, 2
	div	ecx ; policz (eax^2 - eax + 2)/2

	call wyswietl_EAX

	inc esi
	cmp esi, 51
	jne pierwsze_50 ; powtarzaj dopoki esi nie jest 50


	push	0
	call _ExitProcess@4
_main endp

END