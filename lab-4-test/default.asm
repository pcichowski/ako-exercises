.686
.model flat

extern _ExitProcess@4 : proc

;public _main

.data

.code

_max_4 proc
	push ebp
	mov ebp, esp


	;	d [ebp + 20]
	;	c [ebp + 16]
	;	b [ebp + 12]
	;	a [ebp + 8]
	;	CALL [ebp + 4]

	mov eax, [ebp + 8] ; wpisz a
	cmp eax, [ebp + 12] ; porownaj a i b
	jge a_wieksza

	; przypadek a < b
	mov eax, [ebp + 12] ; wpisz b
	cmp eax, [ebp + 16] ; porownaj b i c
	jge b_wieksza

	; przypadek a < b  i  b < c
	mov eax, [ebp + 16] ; wpisz c
	cmp eax, [ebp + 20] ; porownaj c i d
	jmp zakoncz

	; przypadek kiedy a < b < c < d
	; d najwieksze
wpisz_d:
	mov eax, [ebp + 20]	

zakoncz:
	pop ebp
	ret

a_wieksza:
	; przypadek a >= b
	mov eax, [ebp + 8] ; a
	cmp eax, [ebp + 16] ; porownaj a i c
	jge sprawdz_a_d

b_wieksza:
	;przypadek b >= c >= a
	mov eax, [ebp + 12]
	cmp eax, [ebp + 20] ; porownaj b i d
	jge zakoncz
	jmp wpisz_d

sprawdz_a_d:
	mov eax, [ebp + 8] ; a
	cmp eax, [ebp + 20] ;porownaj a i d
	jge zakoncz
	jmp wpisz_d

_max_4 endp	


_plus_jeden PROC
	push ebp		; zapisanie zawartoœci EBP na stosie
	mov ebp,esp		; kopiowanie zawartoœci ESP do EBP - standard prolog

	push ebx	; przechowanie zawartoœci rejestru EBX

	mov ebx, [ebp+8]	; wpisanie do rejestru EBX adresu zmiennej zdefiniowanej w kodzie w jêzyku C
	mov eax, [ebx]		; odczytanie wartoœci zmiennej
	inc eax				; dodanie 1
	mov [ebx], eax		; odes³anie wyniku do zmiennej
	; uwaga: trzy powy¿sze rozkazy mo¿na zast¹piæ jednym rozkazem w postaci: inc dword PTR [ebx]

	pop ebx
	pop ebp
	ret
_plus_jeden ENDP

_liczba_przeciwna proc
	push ebp
	mov ebp, esp
	
	push ebx

	mov ebx, [ebp + 8] ; adres zmiennej w ebx

	neg dword ptr [ebx] ; negacja wartosci pod adresem w ebx

	pop ebx
	pop ebp
	ret 
_liczba_przeciwna endp

_odejmij_jeden proc
	push ebp
	mov ebp, esp
	push ebx

	mov ebx, [ebp + 8]


	pop ebx
	pop ebp
	ret
_odejmij_jeden endp

END