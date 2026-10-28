; # Connect4.asm
; # --------------------------------------------------
; # Title    : Connect 4
; # Authors  : Jadon Duff and Ryan Gomes
; # Class    : CSE3120
; # Project  : Contest 1
; # Software : MASM & Visual Studio Code
; # --------------------------------------------------
; # Description:
; #   Implementation of the Connect 4 game in
; #   Microsoft Macro Assembler (MASM)
; # --------------------------------------------------

; ---- Libraries ------------------------
INCLUDE Irvine32.inc


; ---- Data -----------------------------
.data

; Description:
; The board contains 6 Rows and 7 Cols
row BYTE 6
cols Byte 7
board BYTE 42 DUP ('0'),'1','2','3','4','5','6','7'

; Here are helper separators for printing the board
columnSeparator BYTE " | ", 0
rowSeparator BYTE "  |   |   |   |   |   |"

; Here is the prompt for input to the user
prompt BYTE "Enter a number...", 0


; ---- Code -----------------------------
.code


; ---- PrintBoard Procedure -------------
; Renders the current board array to the active terminal output
; Args:
;   board: Uses the global board array variable
; Returns:
;   None (Renders Board)
; Uses:
;   eax, ebx, ecx, edx
PrintBoard PROC USES eax ebx ecx edx
	call ClrScr
	mov ecx, 7
	mov	ebx, 42

	LoopBoard:
	    ; Prints the board incrementally. So, first line is index 35 -> 41, second line is 28 -> 34, and so on
		; Between each row, the 13 is subtracted from the counter
		; Note: index 42 -> 47 is printed first, which are the column numbers the user will enter
		push ecx
		mov	ecx, 7

		LoopRow:
			xor		eax, eax			; Clear EAX
			mov		al, [board + ebx]	; Get the current array location
			call	WriteChar

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


; ---- MakeMove Procedure ---------------
; Updates the global board array with a specified input by simulating a drop into the column
; Args:
;   ecx: The column the piece should be dropped in
;   dl: The player placing the piece ('A' or 'B')
;   board: Uses the global board array variable
; Returns:
;   None
; Uses:
;   ecx, edx
MakeMove PROC USES ecx edx
	sub ecx, 1

	FindEmpty:
		cmp board[ecx], '0'
		je EmptyCell
		add ecx, 7
		jmp FindEmpty

	EmptyCell:
		; ecx contains the index of the empty cell
		mov board[ecx], dl ; change the empty value to the player piece

	ret

MakeMove ENDP


; ---- GetUserMove Procedure ------------
; Gets a move from the user via standard input
; Args:
;   None
; Returns:
;   eax: The user's desired column
;   ecx: The user's desired column
; Uses:
;   edx
GetUserMove PROC USES edx
	mov		edx, OFFSET prompt
	call	WriteString
	call	ReadInt
	mov		ecx, eax
	ret

GetUserMove ENDP


; ---- GetAIMove Procedure --------------
; Generates a move from the AI
; Args:
;   None
; Returns:
;   eax: The ai's desired column
;   ecx: The ai's desired column
; Uses:
;   None
GetAIMove PROC
	mov		eax, 4
	mov		ecx, eax
GetAIMove ENDP


; ---- Main -----------------------------
main proc
	mov		eax,yellow + (blue * 16)
	call	SetTextColor
	call	ClrScr

	GameLoop:
		call	PrintBoard

		call	Crlf
		call	Crlf

		mov		edx, 'A'
		call	GetUserMove
		call	MakeMove

		call	Crlf
		call	Crlf
	
		call	PrintBoard
	
		call	GetAIMove
		call	MakeMove
	
		call	Crlf
		call	Crlf

		call	PrintBoard

	exit
main endp
end main
