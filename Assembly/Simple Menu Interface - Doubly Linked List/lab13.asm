include win64.inc ; biblioteca cu structuri si prototipuri functii Win x64 si C
option win64:0111b
option literals:on ; Siruri "literale" in apeluri INVOKE folosind "" sau L"".

; Declara?ii tipuri ?i structuri de date
pELEM typedef ptr ELEM
pBYTE typedef ptr BYTE

ATTR_ON EQU 70h
ATTR_OFF equ 07h

ELEM struct
		next pELEM NULL
		prev pELEM NULL
		crd COORD { }
		text pBYTE NULL
		id byte 1
ELEM ends

MENU struct
		head pELEM NULL
		last pELEM NULL
		select pELEM NULL
MENU ends


; Declara?ii prototipuri functii/proceduri
getVK proto (WORD)
Chenar2 proto :COORD, :COORD
PutcharXY proto :WORD, :WORD, :BYTE
AddMenuItem proto :ptr MENU, :COORD, :pBYTE
PrintMenu proto
EnterCom proto


.data ; segmentul de date (variabile globale)
	; Declaratii de variabile

	stg_sus COORD {9, 4}
	drp_jos COORD {27, 10}
	info_crd COORD {0, 20}
	hStdOut HANDLE ?
	hStdIn HANDLE ?
	menu MENU {NULL, NULL}

	
.code ; Sergmentul de cod (program)

main proc uses rbx ; Functia principala "main" 
	; codul programului...
	mov hStdOut, GetStdHandle(STD_OUTPUT_HANDLE)
	.if hStdOut == INVALID_HANDLE_VALUE
		printf("Error reading Standard Output Handle\n")
		exit(-1)
	.endif

	mov hStdIn, GetStdHandle(STD_INPUT_HANDLE)
	.if hStdIn == INVALID_HANDLE_VALUE
		printf("Error reading Standard Output Handle\n")
		exit(-1)
	.endif

	Chenar2(stg_sus, drp_jos)
	AddMenuItem(&menu, 0x0005000A, "File          ")
	AddMenuItem(&menu, 0x0006000A, "Edit          ")
	AddMenuItem(&menu, 0x0007000A, "Options       ")
	AddMenuItem(&menu, 0x0008000A, "Help          ")
	AddMenuItem(&menu, 0x0009000A, "Exit          ")
	PrintMenu()

	.repeat
		mov bx, getVK()

		.switch bx
			.case VK_DOWN
				mov rax, menu.select
				.if rax && [rax].ELEM.next
					mov rax, [rax].ELEM.next
					mov menu.select, rax
					PrintMenu()
				.endif
			.case VK_UP
				mov rax, menu.select
				.if rax && [rax].ELEM.prev
					mov rax, [rax].ELEM.prev
					mov menu.select, rax
					PrintMenu()
				.endif
			.case VK_RETURN
				EnterCom()		
		.endsw
	.until r12b == 1

	exit(0) ; apel INVOKE functia C de parasire a programului
	ret
main endp ; Sfarsitul functiei main

; Alte functii/proceduri
; Exemplu proc uses rbx rsi rdi arg1:WORD, arg2:VARARG
	; |     |    |   |   |   |    +-- lista parametri si tipul acestora
	; |     |    +---+---+---+------- lista registrilor protejati utilizati
	; |     +------------------------ declaratia procedurii
	; +------------------------------ nume procedura/functie

	; codul procedurii/functiei...
	;ret
; Exemplu endp ---------------------- sfarsitul declaratitiei procedurii/functiei

PutcharXY proc _x: WORD, _y: WORD, _cv: BYTE
	mov dx, _y						; DX = Y(16 bit) => DX = 0xyyyy => EDX = 0x????yyyy
	shl edx, 16						; EDX <<16 => EDX = 0xyyyy0000
	mov dx,	_x						; DX = X => EDX = 0xyyyyxxxxx (in reprezentare hexa)

	SetConsoleCursorPosition(hStdOut, edx)
	putchar(_cv)

	ret
PutcharXY endp

Chenar2 proc _ss: COORD, _dj: COORD
	mov si, _ss.X
	mov di, _ss.Y

	PutcharXY(si, di, 201) ; colt stanga sus
	.for(si++ : si < _dj.X : si++)
		PutcharXY(si, di, 205) ; bara sus
	.endfor

	PutcharXY(si, di, 187) ; colt dreapta sus
	.for(di++ : di < _dj.Y : di++)
		PutcharXY(si, di, 186) ; bara stanga
	.endfor

	PutcharXY(si, di, 188) ; colt dreapta jos
	.for(si-- : si > _ss.X : si--)
		PutcharXY(si, di, 205) ; bara jos
	.endfor
	
	PutcharXY(si, di, 200)	; colt stanga jos
	.for(di-- : di > _ss.Y : di--)
		PutcharXY(si, di, 186) ; bora stanga
	.endfor
	
	ret
Chenar2 endp

AddMenuItem proc uses rsi rbx @menu: ptr MENU, _crd: COORD, @text: pBYTE
	mov rsi, @menu
	mov rbx, malloc(sizeof(ELEM))

	.if rbx
		mov r9, @text
		mov [rbx].ELEM.text, r9

		mov r9d, _crd
		mov [rbx].ELEM.crd, r9d

		mov [rbx].ELEM.next, NULL

		.if [rsi].MENU.last != NULL
			mov rax, [rsi].MENU.last ; copie pt last
			mov [rax].ELEM.next, rbx
			mov [rbx].ELEM.prev, rax
			mov [rsi].MENU.last, rbx

			mov r9b, [rax].ELEM.id
			inc r9b
			mov [rbx].ELEM.id, r9b
		.else
			mov [rsi].MENU.head, rbx
			mov [rsi].MENU.last, rbx
			mov [rsi].MENU.select, rbx

			mov [rbx].ELEM.id, 1
			mov [rbx].ELEM.prev, NULL
		.endif
	.else
		printf("Alocarea a esuat !\n")
	.endif

	ret
AddMenuItem endp

PrintMenu proc uses rsi
	mov rsi, menu.head ;copie pt head

	.while rsi
		mov ebx, [rsi].ELEM.crd
		SetConsoleCursorPosition(hStdOut, [rsi].ELEM.crd)

		.if menu.select == rsi
			SetConsoleTextAttribute(hStdOut, ATTR_ON)
		.else
			SetConsoleTextAttribute(hStdOut, ATTR_OFF)
		.endif

		printf("%d. %s\n", [rsi].ELEM.id, [rsi].ELEM.text)

		mov rsi, [rsi].ELEM.next
	.endw

	mov rbx, menu.head
	SetConsoleTextAttribute(hStdOut, ATTR_OFF)

	ret
PrintMenu endp

EnterCom proc uses rsi
	mov rsi, menu.select

	.if rsi
		SetConsoleCursorPosition(hStdOut, info_crd)
		printf("Ati selectat optiunea : %d", [rsi].ELEM.id)

		.if rsi == menu.last
			mov r12b, 1
		.endif 
	.endif

	ret
EnterCom endp

getVK proc
    LOCAL lpBuffer:INPUT_RECORD
    LOCAL lpRead:DWORD
    ReadConsoleInput(hStdIn, addr lpBuffer, 1, addr lpRead)
    .if (lpBuffer.EventType == KEY_EVENT) && (lpBuffer.KeyEvent.bKeyDown == 1)
        mov ax, lpBuffer.KeyEvent.wVirtualKeyCode
    .else
        xor ax, ax
    .endif
    ret
getVK endp

end ; Sfarsitul codului sursa