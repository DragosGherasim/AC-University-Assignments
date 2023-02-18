include win64.inc ; biblioteca cu structuri si prototipuri functii Win x64 si C
option win64:0111b
			; ||+--- salvarea automata a primilor 4 parametri in shadow area
			; |+---- alocarea spatiului pe stiva pentru apelurile INVOKE
			; +----- alinierea stivei la 16 octeti
option literals:on ; Siruri "literale" in apeluri INVOKE folosind "" sau L"".

; Declara?ii tipuri ?i structuri de date
; Declara?ii prototipuri functii/proceduri

ATTR_ON equ 0F0h
ATTR_OFF equ 0Fh

getVK proto (WORD)
PrintX0 proto :QWORD, :WORD

.data ; segmentul de date (variabile globale)
	; Declaratii de variabile
	hStdOut HANDLE ?                ; Standard OutPut Handle
    hStdIn HANDLE ?                 ; Standard Input Handle
	
	table BYTE 3 dup (3 dup (' '))
	activ_indx QWORD 4
    val BYTE 'X'

.code ; Sergmentul de cod (program)

main proc uses rsi ; Functia principala "main" 
	; codul programului...
	mov hStdOut, GetStdHandle(STD_OUTPUT_HANDLE)
    .if (hStdOut == INVALID_HANDLE_VALUE)
        printf("Error reading Standard Output Handle\n")
        exit(-1)
    .endif
    mov hStdIn, GetStdHandle(STD_INPUT_HANDLE)
    .if (hStdIn == INVALID_HANDLE_VALUE)
        printf("Error reading Standard Input Handle\n")
        exit(-1)
    .endif

    .for(rsi = 0 : rsi < 9 : rsi++)
        .if rsi == activ_indx
            PrintX0(rsi, ATTR_ON)
        .else
            PrintX0(rsi, ATTR_OFF)
        .endif
    .endfor

    
    .repeat
         mov si, getVK()
         
         .switch si
            .case VK_UP
                .if activ_indx >= 3
                    PrintX0(activ_indx, ATTR_OFF)
                    sub activ_indx, 3
                    PrintX0(activ_indx, ATTR_OFF)
                .endif
            .case VK_DOWN
                .if activ_indx <= 5
                    PrintX0(activ_indx, ATTR_OFF)
                    add activ_indx, 3
                    PrintX0(activ_indx, ATTR_OFF)
                .endif
            .case VK_LEFT
                .if activ_indx != 0 && activ_indx != 3 && activ_indx != 6
                    PrintX0(activ_indx, ATTR_OFF)
                    dec activ_indx
                    PrintX0(activ_indx, ATTR_OFF)
                .endif
             .case VK_RIGHT
                .if activ_indx != 2 && activ_indx != 5 && activ_indx != 8
                    PrintX0(activ_indx, ATTR_OFF)
                    inc activ_indx
                    PrintX0(activ_indx, ATTR_OFF)
                .endif
            .case VK_SPACE
                lea rsi, table
                mov rcx, activ_indx

                .if byte ptr[rsi + rcx*sizeof(BYTE)] == ' '
                    mov dl, val
                    mov byte ptr[rsi + rcx*sizeof(BYTE)], dl

                    .if dl == 'X'
                        mov val, '0'
                    .else
                        mov val, 'X'
                    .endif
                    PrintX0(activ_indx, ATTR_ON)
                .endif
            .case VK_BACK
                lea rsi, table

                .for(rbx=0 : rbx < 9 : rbx++)
                    mov byte ptr [rsi + rbx], ' '
                .endfor

                mov activ_indx, 4
                .for(rbx=0 : rbx < 9 : rbx++)
                    .if rbx == 4
                        PrintX0(rbx, ATTR_ON)
                    .else
                        PrintX0(rbx, ATTR_OFF)
                    .endif
                .endfor
            .endsw
    .until si == VK_ESCAPE

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

PrintX0 proc _indx: QWORD, _attr: WORD
    mov rax, _indx
    xor rdx, rdx
    mov rcx, 3
    div rcx ; rax = index/3; rdx = index%3
    shl rdx, 2
    inc rdx
    ;AX = Y; DX = X
    shl eax, 16
    mov ax, dx

    SetConsoleCursorPosition(hStdOut, eax)
    SetConsoleTextAttribute(hStdOut, _attr)

    lea rax, table
    mov rcx, _indx
    putchar([rax + rcx*sizeof(BYTE)])
    putchar(8)
    ret
PrintX0 endp

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