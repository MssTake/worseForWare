INCLUDE Irvine32.inc
.data
	;board
	row BYTE "////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////"

	; score
	score BYTE 0,0
	inputChar BYTE ?

	;lives
	lives BYTE 0,0
	
	;controls
	player byte "0",0

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
	
	;player selects game
	mov eax, blue + (black * 16)
	call SetTextColor
	mov dl,40
	mov dh,12
	call GotoXY
	mov edx,OFFSET select
	call WriteString
	call Clrscr
	je board

	invoke ExitProcess,0
main endp

;game board
board:
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
moveChar proc
moveChar endp

;games
game1 PROC
	;instructions
	mov eax, blue + (green * 16)
	call SetTextColor
	call GotoXY
	mov edx,OFFSET g1
	call WriteString
game1 endp

game3 PROC
	;instructions
	mov eax, blue + (green * 16)
	call SetTextColor
	call GotoXY
	mov edx,OFFSET g3
	call WriteString
game3 endp

game4 PROC
	;instructions
	mov eax, blue + (black * 16)
	call SetTextColor
	call GotoXY
	mov edx,OFFSET g4
	call WriteString
game4 endp

game5 PROC
	;instructions
	mov eax, blue + (black * 16)
	call SetTextColor
	call GotoXY
	mov edx,OFFSET g5
	call WriteString
game5 endp

end main