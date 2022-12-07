INCLUDE Irvine32.inc
.data

;board
row byte "///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////"
bottom1 byte "_____                                           ____ ",0
bottom2 byte "\    \    _____     ____    ____    _______    ///// ",0
bottom3 byte " \    \  /////  \  /////    \   \  /////   \  /////  ",0
bottom4 byte "  \    \/////\   \/////      \   \/////\    \/////   ",0
bottom5 byte "   \   /////  \  /////        \  /////  \   /////    ",0
bottom6 byte "    \_/////    \/////          \/////    \_/////     ",0
unit byte "0",0
speech byte "words ",0
ball byte "O",0

; score
score byte 0,0

;time reader
time1 dword ?
time2 dword ?
time3 dword ?
timeTarget dword ?,0
dateTime FILETIME <>

;lives
lives byte 4,0
lose1 byte "__      ____   _________    __   __     ________   ______   ",0
lose2 byte "\\\\   /////  |||||||||||  |||| ///    |||||||||  //|||||\  ",0
lose3 byte " \\\\ /////      |||||     ||||///     |||||__    \\\\\ \|| ",0
lose4 byte "  \\\/////       |||||     ||||\\\     ||||||||    \\\\\\   ",0
lose5 byte "   \/////        |||||     ||||\\\\    |||||         \\\\\\ ",0
lose6 byte "   /////       __|||||__   ||||\\\\\   |||||____  \\\///////",0
lose7 byte "  /////       |||||||||||  |||| \\\\\  |||||||||   \\////// ",0
retGame1 byte "LETS TRY AGAIN",0
retGame2 byte "FROM THE TOP",0

;game over
over1 byte " _________    _________  ",0
over2 byte "////////|||  ////////||| ",0
over3 byte "|||||   \\|  |||||   \\| ",0
over4 byte "||||| _____  |||||  _____",0
over5 byte "|||||  ||||  |||||   ||||",0
over6 byte "|||||__||||  |||||___||||",0
over7 byte "\|||||||||/  \|||||||||/ ",0

;script
welcome byte "WELCOME TOᵂ WORSE FOR WARE",0 
controls byte "All actions are completed with the action button (any key)"
g1 byte "CROSS THE STREET",0
g2 BTYE "FIND THE SUSPECT",0
g3 byte "FEED THE DOG",0
g4 byte "PRESENT THE SPEECH",0
g5 byte "KICK THE BALL",0

.code

;main-------------------------------------

main PROC
	;welcome screen
	je board
	je setInfo
	mov edx,OFFSET welcome
	call WriteString
	mov eax,1374
	call Delay

	;instructions
	je board
	je setInfo
	mov edx,OFFSET controls
	call WriteString
	mov eax,1374
	call Delay

	;start game
	je board
	jmp game1
main ENDP

;mechanics-------------------------------------

;record start time and create target
startTime
	INVOKE GetDateTime,edx dateTime
	mov time1,edx
	;set time target
	add timeTarget,time1
	add timeTarget,50000000
ret

; record end time
endTime
	INVOKE GetDateTime,edx dateTime
	mov time2,edx
ret

;time to complete game successfully
timer:
	;subtract the times
	mov eax,time2
	sub eax,time1
	mov time3,eax
	;player loses a life if completed over 5 seconds
	.if time3 > timeTarget
		je lose
	.endif
ret

;player loses a life
lose:
	;show lost a life message
	je board
	je setInfo

	;show previous lives
	je board
	je setInfo
	mov edx, OFFSET lives
	call WriteString

	;subtract lives by 1
	mov ecx,lives
	sub ecx,1
	mov lives,edx

	;show current lives
	je board
	je setInfo
	mov edx, OFFSET lives
	call WriteString

	;if out of lives end game
	.if (lives == 0)
		jmp main
	;else send to game1
	.else
		je setInfo
		mov edx, OFFSET retGame1
		call WriteString
		mov eax, 1000
		call Delay
		je board
		je setInfo
		mov edx, OFFSET retGame2
		call WriteString
		mov eax, 1000
		call Delay
		je board
		je game1
	.endif
ret

;you lost the game
lost:
	;lose game message
	mov eax, 5000
	Call Delay
	;end program
ret

;formatting-------------------------------------

;info text format
setInfo:
	mov eax, green
	call SetTextColor
	mov dl,40
	mov dh,7
	call GotoXY
ret

;gameplay text format
setGame:
    mov eax, yellow
	call SetTextColor
	mov dl,40
	mov dh,3
	call GotoXY
ret

;board textformat
setBoard:
	mov eax, yellow
	call SetTextColor
	mov dl,1
ret

;game board
board:
	call Clrscr

	;top row
	je setBoard
	mov dh,17
	call GotoXY
	mov edx,OFFSET row
	call WriteString

	;bottom row
    je setBoard
	mov dh,7
	call GotoXY
	mov edx,OFFSET row
	call WriteString

	;the ws
	je setBoard
	mov dh,1
	call GotoXY
	mov edx,OFFSET bottom6
	call WriteString
	mov dh,2
	call GotoXY
	mov edx,OFFSET bottom5
	call WriteString
	call WriteString
	mov dh,3
	call GotoXY
	mov edx,OFFSET bottom4
	call WriteString
	call WriteString
	mov dh,4
	call GotoXY
	mov edx,OFFSET bottom3
	call WriteString
	call WriteString
	mov dh,5
	call GotoXY
	mov edx,OFFSET bottom2
	call WriteString
	call WriteString
	mov dh,6
	call GotoXY
	mov edx,OFFSET bottom1
	call WriteString
ret

;gameplay-------------------------------------

;moving character
action1:
	;player selects action
	call ReadChar
	mov inputChar,al
	;program writes action
	je setGame
	mov edx,OFFSET unit
	call WriteString
ret

;finding suspect
;action2:
;	;player does action
;	call ReadChar
;	mov inputChar,al
;	;program writes action
;	je setGame
;	mov edx,OFFSET unit
;	call WriteString
;ret

;feeding dog
action3:
	;player does action
	call ReadChar
	mov inputChar,al

	;program writes action
	je setGame
	mov edx,OFFSET unit
	call WriteString
	ret

;presenting speech
action4:
	;player does action
	call ReadChar
	mov inputChar,al

	;program writes action
	je setGame
	mov edx,OFFSET speech
	call WriteString
	ret

;kicking ball
action5:
	;player does action
	call ReadChar
	mov inputChar,al

	;program writes action
	je setGame
	mov edx,OFFSET ball
	call WriteString
	mov eax, 456
ret

;minigames-------------------------------------

;cross the street minigame
game1 proc

	;instructions
	je setInfo
	mov edx,OFFSET g1
	call WriteString
	mov eax, 456
	call Delay

	;move character loop
	mov dl,40
	mov dh,7
	je action1
	je board
	je action1
	je board
	je action1
	je board
	je action1
	je board
	je action1
	je board
	je action1
	je board
	je action1
	je board
	je action1
	je board
	je action1
	je board
	je action1
	mov eax, 456
	call Delay

	;go to next game
	je board
	jmp game3
game1 endp

;find the suspect minigame
;game2 proc
;	je setInfo
;	mov edx,OFFSET g2
;	call WriteString
;	mov eax, 456
;	call Delay
;game2 endp

;feed the dog minigame
game3 proc
	;instructions
	je setInfo
	mov edx,OFFSET g3
	call WriteString
	mov eax, 456
	call Delay

	;game
	je action3
	je action3
	je action3
	je action3
	je action3
	mov eax, 456
	call Delay

	;go to next game
	je board
	jmp game4
game3 endp

;present the speech minigame
game4 proc
	;instructions
	je setInfo
	mov edx,OFFSET g4
	call WriteString
	mov eax, 456
	call Delay

	;game
	je action4
	je action4
	je action4
	je action4
	je action4
	mov eax, 456
	call Delay

	;go to next game
	je board
	jmp game5
game4 endp

;kick the ball minigame
game5 proc
	;instructions
	je setInfo
	mov edx,OFFSET g5
	call WriteString
	mov eax,456
	call Delay

	;game 
	je action5
	mov eax, 456
	call Delay

	;go to next game
	je board
	jmp game1
game5 endp

end main