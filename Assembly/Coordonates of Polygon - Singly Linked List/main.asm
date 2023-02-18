include win64.inc	; biblioteca cu structuri si functii Win x64
option win64:7
option literals:on

pPOINT_T typedef ptr POINT_T

POINT_T struct
	next pPOINT_T NULL
	POS COORD <>
POINT_T ends

PollyAdd proto :ptr pPOINT_T, : COORD
PollyPrint proto (QWORD)
PollyDelete proto : ptr pPOINT_T

.data	; segmentul de date (variabile)
	hStdOut HANDLE ?			; Standard Output Handle
	hStdIn HANDLE ?				; Standard Input Handle
	lpBuffer INPUT_RECORD <>
	lpRead DWORD ?
	lpMode DWORD ?
	head pPOINT_T NULL
	Vkey word ?
	dwLast_ButtonState DWORD 0

.code	; Sergmentul de cod (program)

  main proc	; functia principala "main" 
	 mov hStdOut, GetStdHandle(STD_OUTPUT_HANDLE)
	.if (hStdOut == INVALID_HANDLE_VALUE)
		puts("Error reading Standard Output Handle")
		exit(-1)
	.endif

	mov hStdIn, GetStdHandle(STD_INPUT_HANDLE)
	.if (hStdIn == INVALID_HANDLE_VALUE)
		puts("Error reading Standard Input Handle")
		exit(-1)
	.endif

	; Pentru activare eveminentele mouse-ului pentru consola curenta
	GetConsoleMode(hStdIn, &lpMode)
	and lpMode, NOT ENABLE_QUICK_EDIT_MODE	; dezactivare Quick Edit Mode
	;or  lpMode, ENABLE_EXTENDED_FLAGS
	or  lpMode, ENABLE_MOUSE_INPUT			; activare mouse mode
	SetConsoleMode(hStdIn, lpMode)
	xor rbx, rbx

	.repeat
		ReadConsoleInput(hStdIn, &lpBuffer, 1, &lpRead)
		.if lpBuffer.EventType == MOUSE_EVENT
			; lpBuffer.MouseEvent.dwButtonState returneaza starea butoanelor mouse-ului
			;    bitul 0 cel mai nesemnifivativ = starea (1/0 = apasat/neapasat) butonului stanga
			;    bitul 1 = starea butonului dreapta (1/0 = apasat/neapasat)
			;    bitul 2 = starea butonului din mijloc (rotita) (1/0 = apasat/neapasat)
			mov eax, lpBuffer.MouseEvent.dwButtonState
			mov ecx, dwLast_ButtonState
			and eax, 1
			and ecx, 1
			.if !ecx && eax
				PollyAdd(&head, lpBuffer.MouseEvent.dwMousePosition)
			.endif

			mov eax, lpBuffer.MouseEvent.dwButtonState
			and eax, 2
			and ecx, 2
			.if !ecx && eax
				PollyPrint()

				.switch rax
					.case 0
						printf("\nis invalid...")
					.case 1
						printf("\nis a dot...")
					.case 2
						printf("\nis a line...")
					.case 3
						printf("\nis a triangle...")
					.case 4
						printf("\nis a polygon...")
						inc rbx
				.endsw

				PollyDelete(&head)
			.endif

			.if lpBuffer.MouseEvent.dwEventFlags == MOUSE_MOVED ; ; Mouse Move Event
				; lpBuffer.MouseEvent.dwMousePosition = coordonata mouse (COORD)
				; lpBuffer.MouseEvent.dwMousePosition.X = coordonata X
				; lpBuffer.MouseEvent.dwMousePosition.Y = coordonata Y
			.endif
		.endif
		mov eax, lpBuffer.MouseEvent.dwButtonState			
		mov dwLast_ButtonState, eax
		.if (lpBuffer.EventType == KEY_EVENT) && (lpBuffer.KeyEvent.bKeyDown == 1)
		;  lpBuffer.KeyEvent.bKeyDown == 1  => eveniment apsare tasta
		;  lpBuffer.KeyEvent.bKeyDown == 0  => eveniment eliberare tasta
				; lpBuffer.KeyEvent.uChar.AsciiChar		; cod ASCII (BYTE)
				; lpBuffer.KeyEvent.wVirtualKeyCode		; virtual key (WORD)
			mov ax, lpBuffer.KeyEvent.wVirtualKeyCode
			mov Vkey, ax
		.endif
	.until Vkey == VK_ESCAPE

	PollyDelete(&head)
	printf("\nTotal polygons: %llu.", rbx)

	exit(0)	; parasirea programului
	ret
  main endp	; sfarsitul functiei main

  PollyAdd proc @head: ptr pPOINT_T, _crd : COORD
	malloc(sizeof(POINT_T))

	.if rax
		mov edx, _crd
		mov [rax].POINT_T.POS, edx
		mov [rax].POINT_T.next, NULL

		mov rcx, @head
		.if rcx
			mov rdx, [rcx]

			.if rdx
				.while rdx && [rdx].POINT_T.next
					mov rdx, [rdx].POINT_T.next
				.endw

				mov [rdx].POINT_T.next, rax
			.else
				mov [rcx], rax
			.endif
		.endif
	.endif
	ret
  PollyAdd endp

  PollyPrint proc uses rsi
	mov rsi, head
	xor rdi, rdi

	.while rsi
		printf("\n(%hu, %hu) ", [rsi].POINT_T.POS.X, [rsi].POINT_T.POS.Y)
		inc rdi
		mov rsi, [rsi].POINT_T.next
	.endw

	mov rax, rdi

	ret
  PollyPrint endp

  PollyDelete proc uses rbx @head: ptr pPOINT_T
	mov rbx, @head
	mov rbx, [rbx]

	.while rbx
		mov rcx, rbx
		mov rbx, [rbx].POINT_T.next
		free(rcx)
	.endw

	mov rax, @head
	mov qword ptr [rax], NULL

	ret
  PollyDelete endp

end ; starsitul codului sursa