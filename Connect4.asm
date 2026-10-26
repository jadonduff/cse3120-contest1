; Connect 4
; Developed by Jadon Duff and Ryan Gomes

INCLUDE Irvine32.inc

.data
; 6 Rows and 7 Cols
; 0 = Nothing, 1 = Player 1, 2 = Player 2
row BYTE 6
cols Byte 7
board BYTE 42 DUP (0),1,2,3,4,5,6,7
;board BYTE 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41
message BYTE "Hello World!", 0
columnSeparator BYTE " | ", 0
rowSeparator BYTE "  |   |   |   |   |   |"

.code
;Procedure for printing the connect 4 board
;uses eax, ebx, ecx, edx
PrintBoard PROC USES eax ebx ecx edx
	mov ecx, 6
	mov	ebx, 42

	LoopBoard:
		; UPDATED: First print index 35 -> 41, then newline, (subtract 13 for next row), then 28 -> 34, ...
		; Print index 42-47 first
		push ecx
		mov	ecx, 7

		LoopRow:
			xor		eax, eax			; Clear EAX
			mov		al, [board + ebx]	; Get the current array location
			call	WriteDec

			mov eax, ebx
			add eax, 1
			div cols ; Find the remainer of (ebx + 1) / 7 to know when we print the end of a line

			cmp ah, 0
			je SkipLastSep

			mov		edx, OFFSET columnSeparator
			call	WriteString

			SkipLastSep:
			inc		ebx
			LOOP LoopRow

		sub	ebx, 14
		pop ecx

	call Crlf
	LOOP Loopboard

	ret

PrintBoard ENDP

MakeMove proc
;The column the piece should be placed in should be in ecx
;The player placing the piece should be in edx


MakeMove ENDP

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
