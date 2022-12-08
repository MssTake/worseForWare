;.386	
;.model flat, stdcall
include Irvine32.inc
;includelib Irvine32.lib
;include Macros.inc
;.stack 4096
;ExitProcess proto, dwExitCode:dword

;irvine library time
FILETIME STRUCT
    loDateTime DWORD ?
    hiDateTime DWORD ?
FILETIME ENDS

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
score dword ?
finalScore byte "FINAL SCORE: "
inputChar byte ?

;time reader
time1 dword ?,0
time2 dword ?,0
time3 dword ?,0
timeTarget dword ?,0
dateTime FILETIME <>

;lives
lives dword ?
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
over1 byte "  ________      ________  ",0
over2 byte " ///////|||    ///////||| ",0
over3 byte "|||||   \\|   |||||   \\| ",0
over4 byte "|||||  _____  |||||  _____",0
over5 byte "|||||   ||||  |||||   ||||",0
over6 byte "|||||___||||  |||||___||||",0
over7 byte " \||||||||/    \||||||||/ ",0

;script
welcome byte "WELCOME TO WORSE FOR WARE",0 
controls byte "All actions are completed with the action button (any key)"
g1 byte "CROSS THE STREET",0
;g2 BTYE "FIND THE SUSPECT",0
g3 byte "FEED THE DOG",0
g4 byte "PRESENT THE SPEECH",0
g5 byte "KICK THE BALL",0

.code

;main-------------------------------------
main proc
	;start with four lives
	mov edx,4
	mov lives,edx

	;welcome screen
	jmp board
	jmp setInfo
	mov edx,OFFSET welcome
	call WriteString
	mov eax,1374
	call Delay

	;instructions
	jmp board
	jmp setInfo
	mov edx,OFFSET controls
	call WriteString
	mov eax,1374
	call Delay

	;start game
	jmp board
	jmp game1
main endp

;minigames-------------------------------------

;cross the street minigame
game1 proc
	;instructions
	jmp setInfo
	mov edx,OFFSET g1
	call WriteString
	mov eax, 456
	call Delay
	;game
	jmp startTime
	mov dl,40
	mov dh,7
	je action1
	jmp board
	je action1
	jmp board
	je action1
	jmp board
	je action1
	jmp board
	je action1
	jmp board
	je action1
	jmp board
	je action1
	jmp board
	je action1
	jmp board
	je action1
	jmp board
	je action1
	mov eax, 456
	call Delay
	jmp board
	je endTime
	;go to next game
	jmp board
	jmp game3
game1 endp

;find the suspect minigame
;game2 proc
	;instructions
;	jmp setInfo
;	mov edx,OFFSET g2
;	call WriteString
;	mov eax, 456
;	call Delay
	;game
;game2 endp

;feed the dog minigame
game3 proc
	;instructions
	jmp setInfo
	mov edx,OFFSET g3
	call WriteString
	mov eax, 456
	call Delay
	;game
	jmp startTime
	je action3
	je action3
	je action3
	je action3
	je action3
	mov eax, 456
	call Delay
	jmp board
	je endTime
	;go to next game
	jmp board
	jmp game4
game3 endp

;present the speech minigame
game4 proc
	;instructions
	jmp setInfo
	mov edx,OFFSET g4
	call WriteString
	mov eax, 456
	call Delay
	;game
	jmp startTime
	je action4
	je action4
	je action4
	je action4
	je action4
	mov eax, 456
	call Delay
	jmp board
	je endTime
	;go to next game
	jmp board
	jmp game5
game4 endp

;kick the ball minigame
game5 proc
	;instructions
	jmp setInfo
	mov edx,OFFSET g5
	call WriteString
	mov eax,456
	call Delay
	;game 
	jmp startTime
	je action5
	mov eax, 456
	call Delay
	jmp board
	je endTime
	;go to next game
	jmp board
	jmp game1
game5 endp

;gameplay-------------------------------------

;moving character
action1:
	;player selects action
	call ReadChar
	mov inputChar,al
	;program writes action
	jmp setGame
	mov edx,OFFSET unit
	call WriteString
ret

;finding suspect
;action2:
;	;player does action
;	call ReadChar
;	mov inputChar,al
;	;program writes action
;	jmp setGame
;	mov edx,OFFSET unit
;	call WriteString
;ret

;feeding dog
action3:
	;player does action
	call ReadChar
	mov inputChar,al

	;program writes action
	jmp setGame
	mov edx,OFFSET unit
	call WriteString
ret

;presenting speech
action4:
	;player does action
	call ReadChar
	mov inputChar,al

	;program writes action
	jmp setGame
	mov edx,OFFSET speech
	call WriteString
ret

;kicking ball
action5:
	;player does action
	call ReadChar
	mov inputChar,al

	;program writes action
	jmp setGame
	mov edx,OFFSET ball
	call WriteString
	mov eax, 456
ret

;mechanics-------------------------------------

;record start time and create target
startTime:
	INVOKE GetDateTime,ADDR dateTime
	mov time1,edx
	;set time target
	mov edx,time1
	add edx,50000000
	mov timeTarget,edx
ret

; record end time
endTime:
	INVOKE GetDateTime,ADDR dateTime
	mov time2,edx
	jmp timer
ret

;time to complete game successfully
timer proc
	;subtract the times
	mov eax,time2
	sub eax,time1
	mov time3,eax
	;player loses a life if completed over 5 seconds
	.if (time3 GT timeTarget)
		jmp lose
	;player earns one point
	.else
	mov edx,1
	add score,edx
	.endif
timer endp

;player loses a life
lose proc
	;show lost a life message
	jmp setBoard
	jmp board
	jmp setInfo
	mov dh,1
	call GotoXY
	mov edx,OFFSET lose7
	call WriteString
	mov dh,2
	call GotoXY
	mov edx,OFFSET lose6
	call WriteString
	call WriteString
	mov dh,3
	call GotoXY
	mov edx,OFFSET lose5
	call WriteString
	call WriteString
	mov dh,4
	call GotoXY
	mov edx,OFFSET lose4
	call WriteString
	call WriteString
	mov dh,5
	call GotoXY
	mov edx,OFFSET lose3
	call WriteString
	call WriteString
	mov dh,6
	call GotoXY
	mov edx,OFFSET lose2
	call WriteString
	mov dh,7
	call GotoXY
	mov edx,OFFSET lose1
	call WriteString
	mov eax, 456
	call Delay
	;show previous lives
	jmp board
	jmp setInfo
	mov edx, OFFSET lives
	call WriteString
	mov eax, 456
	call Delay
	;subtract lives by 1
	mov edx,lives
	sub edx,1
	mov lives,edx
	;show current lives
	jmp board
	jmp setInfo
	mov edx, OFFSET lives
	call WriteString
	mov eax, 456
	call Delay
	;if out of lives end game
	.if (lives == 0)
		jmp lost
	;else send to game1
	.else
		jmp setInfo
		mov edx, OFFSET retGame1
		call WriteString
		mov eax, 1000
		call Delay
		jmp board
		jmp setInfo
		mov edx, OFFSET retGame2
		call WriteString
		mov eax, 1000
		call Delay
		jmp board
		jmp game1
	.endif
lose endp

;you lost the game
lost proc
	;show final score
	jmp setBoard
	jmp board
	jmp setInfo
	mov edx, OFFSET finalScore
	call WriteString
	jmp setInfo
	mov edx,score
	call WriteString
	;lose game message
	jmp setBoard
	jmp board
	jmp setInfo
	mov dh,1
	call GotoXY
	mov edx,OFFSET over7
	call WriteString
	mov dh,2
	call GotoXY
	mov edx,OFFSET over6
	call WriteString
	call WriteString
	mov dh,3
	call GotoXY
	mov edx,OFFSET over5
	call WriteString
	call WriteString
	mov dh,4
	call GotoXY
	mov edx,OFFSET over4
	call WriteString
	call WriteString
	mov dh,5
	call GotoXY
	mov edx,OFFSET over3
	call WriteString
	call WriteString
	mov dh,6
	call GotoXY
	mov edx,OFFSET over2
	call WriteString
	mov dh,7
	call GotoXY
	mov edx,OFFSET over1
	call WriteString
	mov eax, 5000
	Call Delay
	;end program
lost endp

;formatting-------------------------------------

;info text format
setInfo proc
	mov eax, green
	call SetTextColor
	mov dl,40
	mov dh,7
	call GotoXY
setInfo endp

;gameplay text format
setGame proc
    mov eax, yellow
	call SetTextColor
	mov dl,40
	mov dh,3
	call GotoXY
setGame endp

;board textformat
setBoard proc
	mov eax, yellow
	call SetTextColor
	mov dl,1
setBoard endp

;game board
board proc
	call Clrscr
	;top row
	jmp setBoard
	mov dh,17
	call GotoXY
	mov edx,OFFSET row
	call WriteString
	;bottom row
    jmp setBoard
	mov dh,7
	call GotoXY
	mov edx,OFFSET row
	call WriteString
	;the two Ws
	jmp setBoard
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
board endp

end main