; Connect 4
; Developed by Jadon Duff and Ryan Gomes

INCLUDE Irvine32.inc

.data
; 6 Rows and 7 Cols
; 0 = Nothing, 1 = Player 1, 2 = Player 2
row1 BYTE 7 DUP 0
row2 BYTE 7 DUP 0
row3 BYTE 7 DUP 0
row4 BYTE 7 DUP 0
row5 BYTE 7 DUP 0
row6 BYTE 7 DUP 0

.code
main proc
	mov		eax,yellow + (blue * 16)
	call	SetTextColor
	call	ClrScr

	exit
main endp
end main
