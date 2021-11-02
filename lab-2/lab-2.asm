; wczytywanie i wyœwietlanie tekstu wielkimi literami
; (inne znaki siê nie zmieniaj¹)
.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC ; (dwa znaki podkreœlenia)
extern __read : PROC ; (dwa znaki podkreœlenia)
public _main
.data
tekst_pocz db 10, 'Proszê napisaæ jakiœ tekst '
db 'i nacisnac Enter', 10
koniec_t db ?
magazyn dd 80 dup (?)
nowa_linia db 10
liczba_znakow dd ?

male_litery dd 0c485h, 0c487h, 0c499h, 0c582h, 0c584h, 0c3b3h, 0c59bh, 0c5bah, 0c5bch
duze_litery dd 0c484h, 0c486h, 0c498h, 0c581h, 0c583h, 0c393h, 0c59ah, 0c5b9h, 0c5bbh

.code
_main PROC
; wyœwietlenie tekstu informacyjnego
; liczba znaków tekstu
 mov ecx,(OFFSET koniec_t) - (OFFSET tekst_pocz)
 push ecx
 push OFFSET tekst_pocz ; adres tekstu
 push 1					; nr urz¹dzenia (tu: ekran - nr 1)
 call __write			; wyœwietlenie tekstu pocz¹tkowego
 add esp, 12			; usuniecie parametrów ze stosu
						; czytanie wiersza z klawiatury
 push 80				
 ; maksymalna liczba znaków
 push OFFSET magazyn
 push 0					; nr urz¹dzenia (tu: klawiatura - nr 0)
 call __read			; czytanie znaków z klawiatury
 add esp, 12			; usuniecie parametrów ze stosu
						; kody ASCII napisanego tekstu zosta³y wprowadzone
						; do obszaru 'magazyn'
						; funkcja read wpisuje do rejestru EAX liczbê
						; wprowadzonych znaków
	mov liczba_znakow, eax
						; rejestr ECX pe³ni rolê licznika obiegów pêtli
	mov ecx, eax
	mov ebx, 0			; indeks pocz¹tkowy
ptl: 
	mov dx, magazyn[ebx] ; pobranie kolejnego znaku

	cmp dx, 'a'
	jb dalej			; skok, gdy znak nie wymaga zamiany

	cmp dx, 'z'
	ja dalej			; skok, gdy znak nie wymaga zamiany

	; jezeli znak jest w tabeli polskie male to zamien,
	; jezeli nie to dalej
	xor	cl, cl			; wyzeruj cl
	sprawdz_kolejne_litery:
	inc	cl
	; if znak == male_polskie_litery[cl] then dx = duze_polskie_litery[cl]
	cmp dx, male_polskie_litery[cl]

	cmp cl, 9
	jne	sprawdz_kolejne_litery

	sub dx, 20H			; zamiana na wielkie litery		
	jmp do_pamieci

polskie:
	
do_pamieci:
	mov magazyn[ebx], dx; odes³anie znaku do pamiêci
dalej: 
	inc ebx				; inkrementacja indeksu
	loop ptl			; sterowanie pêtl¹
						; wyœwietlenie przekszta³conego tekstu

	push liczba_znakow
	push OFFSET magazyn
	push 1
	call __write		; wyœwietlenie przekszta³conego tekstu

	add esp, 12			; usuniecie parametrów ze stosu
	push 0
	call _ExitProcess@4 ; zakoñczenie programu
_main ENDP
END