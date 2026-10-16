; Connect 4
; Developed by Jadon Duff and Ryan Gomes

INCLUDE Irvine32.inc

.code
main proc
	mov		eax,yellow + (blue * 16)
	call	SetTextColor
	call	ClrScr

	exit
main endp
end main
