; Connect 4
; Developed by Jadon Duff and Ryan Gomes

INCLUDE Irvine32.inc

.data
; 6 Rows and 7 Cols
; 0 = Nothing, 1 = Player 1, 2 = Player 2
board BYTE 42 DUP (0)
;board BYTE 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41
message BYTE "Hello World!", 0

.code
PrintBoard PROC
	mov ecx, 6
	mov	edx, 35

	LoopBoard:
		; First print idx 35 -> 41, then newline, (subtract 13 for next row), then 28 -> 34, ...
		mov ebx, ecx
		mov	ecx, 7

		LoopRow:
			xor		eax, eax			; Clear EAX
			mov		al, [board + edx]	; Get the current array location
			call	WriteDec
			inc		edx
			LOOP LoopRow

		sub	edx, 14
		mov ecx, ebx

	call Crlf
	call Crlf
	LOOP Loopboard

	ret

PrintBoard ENDP

main proc
	mov		eax,yellow + (blue * 16)
	call	SetTextColor
	call	ClrScr
	;mov		edx, OFFSET message
	;call	WriteString
	;call	Crlf
	call	PrintBoard

	exit
main endp
end main
