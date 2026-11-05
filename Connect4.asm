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
; The board contains 6 Rows and 7 Cols (7th row is for column numbers, not part of the playable board)
row BYTE 6
cols Byte 7
board BYTE 42 DUP (' '),'1','2','3','4','5','6','7'

; Here are helper separators for printing the board
columnSeparator BYTE " | ", 0
rowSeparator BYTE "  |   |   |   |   |   |"

; Here is the prompt for input to the user
prompt BYTE "Enter a number...", 0

; Winning messages
awinsmsg BYTE "You Win!", 0
bwinsmsg BYTE "You Lose.", 0


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
;   ecx: The column the piece should be dropped in (should be between 1 and 7)
;   dl: The player placing the piece ('A' or 'B')
;   board: Uses the global board array variable
; Returns:
;   None
; Uses:
;   ebx, ecx, edx
MakeMove PROC USES ebx ecx edx
	sub ecx, 1

	FindEmpty:
		cmp board[ecx], ' '
		je EmptyCell
		add ecx, 7
		jmp FindEmpty

	EmptyCell:
		; ecx contains the index of the empty cell
		;;; mov board[ecx], dl ; change the empty value to the player piece
		mov ebx, ecx

	; Animation
	MoveToTop:
		cmp ecx, 34
		ja AnimateDrop
		add ecx, 7
		jmp MoveToTop
	AnimateDrop:
		cmp ecx, ebx
		jbe AnimationDone

		cmp ecx, 6
		jbe AnimationDone

		mov board[ecx], dl

		call PrintBoard

		mov eax, 100
		call Delay

		mov board[ecx], ' '
		sub ecx, 7

		jmp AnimateDrop
	AnimationDone:
		mov board[ebx], dl
	; End of Animation

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
; Generates a random move from the AI
; Args:
;   None
; Returns:
;   eax: The ai's desired column
;   ecx: The ai's desired column
; Uses:
;   None
GetAIMove PROC
	mov		eax, 7
	Call	RandomRange
	inc		eax
	mov		ecx, eax
	ret

GetAIMove ENDP

;Checks to see if either player has 4 in a row.
;Returns a value in eax: A if player A has won, B if player B has won, and 0 if no player has won yet.
HasWon PROC

mov		ecx, 0

LoopCheckWin:
	mov		esi, ecx

	call	CheckRight
	cmp		al, 4
	je		AWins
	cmp		ah, 4
	je		BWins

	call	CheckUp
	cmp		al, 4
	je		AWins
	cmp		ah, 4
	je		BWins
	
	cmp		ecx, 41
	je		LoopCheckWinDone

	inc		ecx
	jmp		LoopCheckWin

	AWins:
		call	ClrScr
		mov		edx, OFFSET awinsmsg
		call	WriteString
		mov		eax, 5000
		call	Delay
		exit

	BWins:
		call	ClrScr
		mov		edx, OFFSET bwinsmsg
		call	WriteString
		mov		eax, 5000
		call	Delay
		exit

	LoopCheckWinDone:
		ret
HasWon ENDP

;---------Helper functions called by HasWon-----------
; Each one takes an index in esi as the starting cell and checks (upto) 4 cells in the stated direction
; Returns a value in ax where al = # of Player A pieces and ah = # of Player B pieces.

;Checks cells to the right from the start
CheckRight PROC uses esi ebx ecx edx
xor ax, ax
xor bx, bx

;Starter index in esi
;if cell mod 7 ever decreases, that means we wrapped to another row, and should stop counting
mov eax, esi
div cols ;remainder is in ah
mov dh, ah ;store the original value in dh

mov ecx, 4 ;loop at most 4 times
LR:
mov eax, esi
div cols ;remainder is in ah
cmp ah, dh ;if the new index is less than the original index mod 7, we jump to endCheck
jb endCheck

cmp board[esi], 'A'
je incA
cmp board[esi], 'B'
je incB
jmp endInc

;ax is used for division, so increment bl/bh
incA:
inc bl
jmp endInc

incB:
inc bh

endInc:
inc esi
loop LR

endCheck:
mov ax, bx
ret

CheckRight ENDP

;Checks cells diagonally up from the start
CheckUpRight PROC

CheckUpRight ENDP

;Checks cells diagonally down from the start
CheckDownRight PROC

CheckDownRight ENDP

;Checks cells upward from the start
CheckUp PROC uses esi ebx ecx edx
xor ax, ax

;starter index in esi
;check 4 cells
mov ecx, 4
LU:
;if the index is outside the board, immediately jump to the end
cmp esi, 41
ja endCheck
cmp board[esi], 'A'
je incA
cmp board[esi], 'B'
je incB
jmp endInc

incA:
inc al
jmp endInc

incB:
inc ah

endInc:
add esi, 7
loop LU

endCheck:
ret
CheckUp ENDP


; ---- Main -----------------------------
main proc
	call	Randomize  ; Randomize not learned in class but Irvine methods were. Found method from Textbook. Sets a random seed
	mov		eax,yellow + (blue * 16)
	call	SetTextColor
	call	ClrScr

	GameLoop:
		; Render Board
		call	PrintBoard
		call	Crlf
		call	Crlf

		; User Move
		mov		edx, 'A'
		call	GetUserMove
		call	MakeMove

		; Check Win
		call	HasWon

		; Render Board
		call	Crlf
		call	Crlf
		call	PrintBoard
		
		; Animate
		mov eax, 750
		call Delay
	
		; AI Move
		mov		edx, 'B'
		call	GetAIMove
		call	MakeMove

		; Check Win
		call	HasWon
	
		; Render Board
		call	Crlf
		call	Crlf
		call	PrintBoard

		; Loop
		jmp		GameLoop

	exit
main endp
end main
