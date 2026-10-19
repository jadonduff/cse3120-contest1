; Connect 4
; Developed by Jadon Duff and Ryan Gomes

INCLUDE Irvine32.inc

.data
; 6 Rows and 7 Cols
; 0 = Nothing, 1 = Player 1, 2 = Player 2
board BYTE 42 DUP (0)
message BYTE "Hello World!", 0

.code
PrintBoard PROC
	mov ecx, LENGTHOF board
	mov edx, 0

	L1:
		xor		eax, eax			; Clear EAX
		mov		al, [board + edx]	; Get the current array location
		call	WriteDec
		inc		edx
		LOOP L1

	ret
PrintBoard ENDP

main proc
	mov		eax,yellow + (blue * 16)
	call	SetTextColor
	call	ClrScr
	mov		edx, OFFSET message
	call	WriteString
	call	Crlf
	call	PrintBoard

	exit
main endp
end main
