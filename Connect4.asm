; Connect 4
; Developed by Jadon Duff and Ryan Gomes

INCLUDE Irvine32.inc

.data
; 6 Rows and 7 Cols
; 0 = Nothing, 1 = Player 1, 2 = Player 2
board BYTE 42 DUP (0)
message BYTE "Hello World!", 0

.code
main proc
	mov		eax,yellow + (blue * 16)
	call	SetTextColor
	call	ClrScr
	mov		edx, OFFSET message
	call	WriteString
	call	Crlf

	exit
main endp
end main
