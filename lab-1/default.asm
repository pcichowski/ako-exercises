.686
.model flat

extern _ExitProcess@4 : proc

public _main

.data

.code
_main proc
	push	0
	call _ExitProcess@4
_main endp

END