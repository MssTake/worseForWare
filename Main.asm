INCLUDE Irvine32.inc
.data
	;board
	row BYTE "////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////"
	blank BYTE "                                                                                                                        "
	player BYTE "                                                     0                                                                  "
	dogFood byte "0",0
	speech byte "words ",0
	ball byte "O",0
	; score
	score BYTE 0,0
	inputChar BYTE ?

	;lives
	lives BYTE 0,0

	;game choice
	choice byte 0,0
	again byte "WHAT DID YOU SAY?",0

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
	select byte "CHOOSE A NUMBER FROM 1 - 5",0
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
	je board

	;welcome screeen
    mov eax, red + (black * 16)
	call SetTextColor
	mov dl,40
	mov dh,12
	call GotoXY
	mov edx,OFFSET welcome
	call WriteString
	mov eax,1374
	call Delay
	call Clrscr
	je board
	
	;game selection
	mov eax, blue + (black * 16)
	call SetTextColor
	mov dl,40
	mov dh,12
	call GotoXY
	mov edx,OFFSET select
	call WriteString
	call Clrscr
	je board
	;take in user input
	call ReadChar
	mov inputChar,al
	cmp inputChar,"2"
	cmp inputChar,"3"
	cmp inputChar,"4"
	cmp inputChar,"5"
	;compare values to determine game
	.if (choice == 1)
		jmp game1
	.endif
;	.if (choice == 2)
;		jmp game2
;	.endif
	.if (choice == 3)
		jmp game3
	.endif
	.if (choice == 4)
		jmp game4
	.endif
	.if (choice == 5)
		jmp game5
	.endif

	invoke ExitProcess,0
main endp

;game board
board:
	;allocating space for the top
	mov edx,OFFSET blank
	call WriteString
	call WriteString
	call WriteString
	;top row
	mov eax, yellow + (black * 16)
	call SetTextColor
	mov dh,17
	call GotoXY
	mov edx,OFFSET row
	call WriteString
	;bottom row
    mov eax, yellow + (black * 16)
	call SetTextColor
	mov dh,7
	call GotoXY
	mov edx,OFFSET row
	call WriteString

;moving character
moveChar:
	;player selects action button
	call ReadChar
	mov inputChar,al
	cmp inputChar,"w"
	;player moves foreward
    mov eax, yellow + (black * 16)
	call SetTextColor
	add dh,1
	call GotoXY
	mov edx,OFFSET player
	call WriteString

;finding suspect

;feeding dog
feedDog:
	;player selects action button
	call ReadChar
	mov inputChar,al
	cmp inputChar,"w"
    mov eax, yellow + (black * 16)
	call SetTextColor
	add dh,1
	call GotoXY
	mov edx,OFFSET dogFood
	call WriteString

;presenting speech

;kicking ball

;cross the street minigame
game1 PROC
	;instructions
	mov eax, blue + (green * 16)
	call SetTextColor
	call GotoXY
	mov edx,OFFSET g1
	call WriteString
	;move character loop
	je moveChar
	je moveChar
	je moveChar
	je moveChar
	je moveChar
	je moveChar
	je moveChar
	je moveChar
	je moveChar
	;go to next game
	call Clrscr
	je board
	jmp game3
game1 endp

;find the suspect minigame
;game2 PROC
;	;instructions
;	mov eax, blue + (green * 16)
;	call SetTextColor
;	call GotoXY
;	mov edx,OFFSET g2
;	call WriteString
;game2 endp

;feed the dog minigame
game3 PROC
	;instructions
	mov eax, blue + (green * 16)
	call SetTextColor
	call GotoXY
	mov edx,OFFSET g3
	call WriteString
	je feedDog
	je feedDog
	je feedDog
	je feedDog
	je feedDog
	;go to next game
	call Clrscr
	je board
	jmp game4
game3 endp

;present the speech minigame
game4 PROC
	;instructions
	mov eax, blue + (black * 16)
	call SetTextColor
	call GotoXY
	mov edx,OFFSET g4
	call WriteString
	;go to next game
	call Clrscr
	je board
	jmp game5
game4 endp

;kick the ball minigame
game5 PROC
	;instructions
	mov eax, blue + (black * 16)
	call SetTextColor
	call GotoXY
	mov edx,OFFSET g5
	call WriteString
	;go to next game
	call Clrscr
	je board
	jmp game1
game5 endp

end main