; program przyk³adowy (wersja 64-bitowa)
extern _write : PROC
extern ExitProcess : PROC
public main
.data
tekst db 10, 'Nazywam sie . . . ' , 10
db 'Moj pierwszy 64-bitowy program asemblerowy '
db 'dziala juz poprawnie!', 10
.code
main PROC
mov rcx, 1 ; uchwyt urz¹dzenia wyjœciowego
mov rdx, OFFSET tekst ; po³o¿enie obszaru ze znakami
; liczba znaków wyœwietlanego tekstu
mov r8, 85
; przygotowanie obszaru na stosie dla funkcji _write
sub rsp, 40
; wywo³anie funkcji ”_write” z biblioteki jêzyka C
call _write
; usuniêcie ze stosu wczeœniej zarezerwowanego obszaru
add rsp, 40
; wyrównanie zawartoœci RSP, tak by by³a podzielna przez 16
sub rsp, 8
; zakoñczenie wykonywania programu
mov rcx, 0 ; kod powrotu programu
call ExitProcess
main ENDP
END