INCLUDE Irvine32.inc
.data

;board
row byte "////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////"
bottom1 byte "____                     ________                     ____ ",0
bottom1 byte "\   \\    _____     ____/||||||||\___     ______     /  // ",0
bottom1 byte " \   \\  /     \\  /   /||||||||||\  \\  /      \\  /  //  ",0
bottom1 byte "  \   \\/   /\  \\/  //||||||||||||\  \\/  //\   \\/  //   ",0
bottom1 byte "   \       // \     // \||||||||||/ \     //  \      //    ",0
bottom1 byte "    \_____//   \___//   \||||||||/   \___//    \____//     ",0
unit byte "0",0
speech byte "words ",0
ball byte "O",0

; score
score byte 0,0
inputChar byte ?

;lives
lives byte 0,0
lose1 byte "__     _____   _________    __   __    ________    _______   ",0
lose2 byte "\ \   /   //  |__    __||  |  | / //  |   ____||  /   ___ \\ ",0
lose3 byte " \ \ /   //      |  ||     |  |/ //   |  ||__     \   \\  \||",0
lose4 byte "  \ /   //       |  ||     |  | \\    |   __||     \    \\   ",0
lose5 byte "   /   //        |  ||     |  |  \\   |  ||          \    \\ ",0
lose6 byte "  /   //       __|  ||__   |  |\  \\  |  ||____   | \/    || ",0
lose7 byte " /___//       |________||  |__| \__\\ |_______||  \_______// ",0

;game over
over1 byte "  ________    ________  ",0
over2 byte "//  _____ | //  _____ | ",0
over3 byte "||  |   \\| ||  |   \\| ",0
over4 byte "||  | _____ ||  |  _____",0
over5 byte "||  |  || | ||  |   || |",0
over6 byte "||  |__|| | ||  |___|| |",0
over7 byte "||________| ||_________|",0

;script
welcome byte "WELCOME TOᵂ WORSE FOR WARE",0 
controls byte "All actions are completed with the action button"
g1 byte "CROSS THE STREET",0
g2 BTYE "FIND THE SUSPECT",0
g3 byte "FEED THE DOG",0
g4 byte "PRESENT THE SPEECH",0
g5 byte "KICK THE BALL",0

.code
main proc

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

;moving character
moveChar:
	;player selects action
	call ReadChar
	mov inputChar,al
	;program writes action
	je setGame
	mov edx,OFFSET unit
	call WriteString
ret

;finding suspect
;find:
;	;player does action
;	call ReadChar
;	mov inputChar,al
;	;program writes action
;	je setGame
;	mov edx,OFFSET unit
;	call WriteString
;ret

;feeding dog
feedDog:
	;player does action
	call ReadChar
	mov inputChar,al

	;program writes action
	je setGame
	mov edx,OFFSET unit
	call WriteString
	ret

;presenting speech
present:
	;player does action
	call ReadChar
	mov inputChar,al

	;program writes action
	je setGame
	mov edx,OFFSET speech
	call WriteString
	ret

;kicking ball
kicking:
	;player does action
	call ReadChar
	mov inputChar,al

	;program writes action
	je setGame
	mov edx,OFFSET ball
	call WriteString
	mov eax, 456
ret

;cross the street minigame
game1 proc
	;instructions
	je set info
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
	mov eax, 456
	call Delay

	;go to next game
	je board
	jmp game3
game1 endp

;find the suspect minigame
;game2 proc
;	je set info
;	mov edx,OFFSET g2
;	call WriteString
;	mov eax, 456
;	call Delay
;game2 endp

;feed the dog minigame
game3 proc
	;instructions
	je set info
	mov edx,OFFSET g3
	call WriteString
	mov eax, 456
	call Delay

	;game
	je feedDog
	je feedDog
	je feedDog
	je feedDog
	je feedDog
	mov eax, 456
	call Delay

	;go to next game
	je board
	jmp game4
game3 endp

;present the speech minigame
game4 proc
	;instructions
	je set info
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
	mov eax, 456
	call Delay

	;go to next game
	je board
	jmp game5
game4 endp

;kick the ball minigame
game5 proc
	;instructions
	je set info
	mov edx,OFFSET g5
	call WriteString
	mov eax,456
	call Delay

	;game 
	je kicking
	mov eax, 456
	call Delay

	;go to next game
	je board
	jmp game1
game5 endp

;player loses a life
;you lost the game

end main