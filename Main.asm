INCLUDE Irvine32.inc
.data
	;board
	row BYTE "////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////"
	unit byte "0",0
	speech byte "words ",0
	ball byte "O",0

	; score
	score BYTE 0,0
	inputChar BYTE ?

	;lives
	lives BYTE 0,0

	;game messages
	over1 byte " ________   ________",0
	over2 byte "/  _____ | /  _____ |",0
	over3 byte "|  |    \| |  |    \|",0
	over4 byte "|  | ____  |  | ____ ",0
    over5 byte "|  |   | | |  |   | |",0
	over6 byte "|  |___| | |  |___| |",0
	over7 byte "|________| |________|",0
	lose1 byte "__     ____   ________    __   __   _______    _______",0
	lose2 byte "\ \   /   /  |__    __|  |  | / /  |   ____|  |   __  |",0
	lose3 byte " \ \ /   /      |  |     |  |/ /   |  |__      \  \ \_|",0
	lose4 byte "  \ /   /       |  |     |  | \    |   __|      \  \",0
	lose5 byte "   /   /        |  |     |  |  \   |  |       _  \  \ ",0
	lose6 byte "  /   /       __|  |__   |  |\  \  |  |____   | \_|  |",0
	lose7 byte " /___/       |________|  |__| \__\ |_______|  |______|",0
	welcome byte "WELC^^O^^ME T^^0^^ W^^O^^RSE F^^O^^R WARE",0
	controls byte "All actions are completed with the action button (w)"
	g1 BYTE "CROSS THE STREET",0
	;g2 BTYE "FIND THE SUSPECT",0
	g3 BYTE "FEED THE DOG",0
	g4 BYTE "PRESENT THE SPEECH",0
	g5 BYTE "KICK THE BALL",0
	;g2 wasnt letting me build for some reason

.code
;game
main proc
	;welcome screen
	je board
    mov eax, green
	call SetTextColor
	mov dl,40
	mov dh,12
	call GotoXY
	mov edx,OFFSET welcome
	call WriteString
	mov eax,1374
	call Delay

	;instructions
	je board
    mov eax, green
	call SetTextColor
	mov dl,40
	mov dh,12
	call GotoXY
	mov edx,OFFSET controls
	call WriteString
	mov eax,1374
	call Delay

	;start game
	je board
	jmp game1
main endp

;game board
board:
	call Clrscr
	;top row
	mov eax, yellow
	call SetTextColor
	mov dl,1
	mov dh,17
	call GotoXY
	mov edx,OFFSET row
	call WriteString
	;bottom row
    mov eax, yellow
	call SetTextColor
	mov dl,1
	mov dh,7
	call GotoXY
	mov edx,OFFSET row
	call WriteString
	ret

;text setups
setInfo:
ret
setGame:
ret

;moving character
moveChar:
	;player selects action button
	call ReadChar
	mov inputChar,al
	cmp inputChar,"w"
	;program writes action
    mov eax, yellow
	call SetTextColor
	mov dl,40
	add dh,1
	call GotoXY
	mov edx,OFFSET unit
	call WriteString
	ret

;finding suspect

;feeding dog
feedDog:
	;player selects action button
	call ReadChar
	mov inputChar,al
	cmp inputChar,"w"
	;program writes action
    mov eax, yellow
	call SetTextColor
	mov dl,40
	mov dh,7
	call GotoXY
	mov edx,OFFSET unit
	call WriteString
	ret

;presenting speech
present:
	;player selects action button
	call ReadChar
	mov inputChar,al
	cmp inputChar,"w"
	;program writes action
    mov eax, yellow
	call SetTextColor
	mov dl,40
	mov dh,7
	call GotoXY
	mov edx,OFFSET speech
	call WriteString
	ret

;kicking ball
kicking:
	;player selects action button
	call ReadChar
	mov inputChar,al
	cmp inputChar,"w"
	;program writes action
    mov eax, yellow
	call SetTextColor
	mov dl,40
	mov dh,3
	call GotoXY
	mov edx,OFFSET ball
	call WriteString
	ret

;cross the street minigame
game1 PROC
	;instructions
	mov eax, green
	call SetTextColor
	mov dl,40
	mov dh,17
	call GotoXY
	mov edx,OFFSET g1
	call WriteString
	mov eax, 456
	call Delay

	;move character loop
	mov dl,40
	mov dh,7
	je moveChar
	je board
	je moveChar
	je board
	je moveChar
	je board
	je moveChar
	je board
	je moveChar
	je board
	je moveChar
	je board
	je moveChar
	je board
	je moveChar
	je board
	je moveChar
	je board
	je moveChar

	;go to next game
	je board
	jmp game3
game1 endp

;find the suspect minigame
;game2 PROC
;	;instructions
;	mov eax, green
;	call SetTextColor
;	mov dl,40
;	mov dh,7
;	call GotoXY
;	mov edx,OFFSET g2
;	call WriteString
;	mov eax, 456
;	call Delay
;game2 endp

;feed the dog minigame
game3 PROC
	;instructions
	mov eax, green
	call SetTextColor
	mov dl,40
	mov dh,7
	call GotoXY
	mov edx,OFFSET g3
	call WriteString
	mov eax, 456
	call Delay

	;game
	je feedDog
	je board
	je feedDog
	je board
	je feedDog
	je board
	je feedDog
	je board
	je feedDog

	;go to next game
	je board
	jmp game4
game3 endp

;present the speech minigame
game4 PROC
	;instructions
	mov eax, green
	call SetTextColor
	mov dl,40
	mov dh,7
	call GotoXY
	mov edx,OFFSET g4
	call WriteString
	mov eax, 456
	call Delay

	;game
	je present
	je present
	je present
	je present
	je present

	;go to next game

	je board
	jmp game5
game4 endp

;kick the ball minigame
game5 PROC
	;instructions
	mov eax, green
	call SetTextColor
	mov dl,40
	mov dh,7
	call GotoXY
	mov edx,OFFSET g5
	call WriteString
	mov eax,456
	call Delay

	;game 
	je kicking

	;go to next game
	je board
	jmp game1
game5 endp

end main