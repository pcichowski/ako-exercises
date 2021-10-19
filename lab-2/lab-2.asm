; Przyk³ad wywo³ywania funkcji MessageBoxA i MessageBoxW
.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxA@16 : PROC
extern _MessageBoxW@16 : PROC
public _main
.data
tytul	dw	'Z', 'n', 'a', 'k', 'i', 0
tekst	dw	'T', 'o', ' ', 'j', 'e', 's', 't', ' ', 'p','i','e','s', ' ',  0d83dh, 0dc08h, ' '
		dw	'i', ' ', 'k', 'o', 't', ' ', 0d83dh, 0dc15h, 0

.code
_main PROC

	push 0
	push offset tytul
	push offset tekst
	push 0
	call _MessageBoxW@16


	push	0						; kod powrotu programu
	call	_ExitProcess@4

_main ENDP
END