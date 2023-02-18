include win64.inc                ; biblioteca cu structuri si functii Win x64
option win64:0111b
option literals:on

pELEM TYPEDEF ptr ELEM
pBYTE TYPEDEF ptr BYTE
ELEM STRUCT
    prev pELEM NULL
    next pELEM NULL
    data pBYTE NULL
ELEM ENDS

LIST STRUCT
    first pELEM NULL
    activ pELEM NULL
    last  pELEM NULL
LIST ENDS

input proto (ptr) :ptr BYTE
ClearScreen proto
getVK proto (WORD)

PrintList proto :ptr LIST
AddFirst proto :ptr LIST
AddLast proto :ptr LIST
AddAbove proto :ptr LIST
AddBelow proto :ptr LIST
DeleteActiv proto :ptr LIST
DeleteList proto :ptr LIST

.data
    hStdOut HANDLE ?                ; Standard OutPut Handle
    hStdIn HANDLE ?                 ; Standard Input Handle
    list LIST {NULL, NULL, NULL}

.code                               ; sergmentul de cod (program)
  main proc uses rbx                ; functia principala "main" 
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
    PrintList(&list)
    .repeat
        mov bx, getVK()
        .switch bx
            .case VK_F1
                AddFirst(&list)
                PrintList(&list)
            .case VK_F2
                AddLast(&list)
                PrintList(&list)
            .case VK_F3
                AddAbove(&list)
                PrintList(&list)
            .case VK_F4
                AddBelow(&list)
                PrintList(&list)
            .case VK_DELETE
                DeleteActiv(&list)
                PrintList(&list)
            .case VK_F8
                DeleteList(&list)
                PrintList(&list)
            .case VK_UP
                mov rax, list.activ
                .if rax != NULL && [rax].ELEM.prev != NULL
                    mov rax, [rax].ELEM.prev
                    mov list.activ, rax
                .endif
                PrintList(&list)
            .case VK_DOWN
                mov rax, list.activ
                .if rax != NULL && [rax].ELEM.next != NULL
                    mov rax, [rax].ELEM.next
                    mov list.activ, rax
                .endif
                PrintList(&list)
        .endsw
    .until bx == VK_ESCAPE
    DeleteList(&list)
    exit(0)                         ; parasirea programului
    ret
  main endp                         ; sfarsitul functiei main

PrintList proc uses rbx rsi _list:ptr LIST
    mov rsi, _list
    ClearScreen() 
    SetConsoleTextAttribute(hStdOut, 0x4E)           ; 0xC0 = galben (14) pe fundal rosu (4)    
    printf("F1=AddTop F2=AddBottom F3=AddAbove F4=AddBelow DEL=Delete F8=DelList UP/DOWN=navigate ESC=EXIT\n")
    SetConsoleTextAttribute(hStdOut, 0x0E)           ; 0x0E = galben (14) pe fundal negru (0) 
    printf("   Prev:            Activ:           Next:            Text F:%p A:%p L:%p\n", list.first, list.activ, list.last)
    mov rbx, [rsi].LIST.first                       ; RBX = @first
    .if rbx == NULL
        SetConsoleTextAttribute(hStdOut, 0x0C)       ; 0x0C = rosu (12) pe fundal negru (0) 
        printf("*** lista vida ***\n")
    .endif
    .while rbx != NULL
        .if rbx == [rsi].LIST.activ
            SetConsoleTextAttribute(hStdOut, 0xF0)  ; 0x0F = negru (0) pe fundal alb (15)
        .else
            SetConsoleTextAttribute(hStdOut, 0x0F)   ; 0x0F = alb (15) pe fundal negru (0)
        .endif    
        printf("   %p %p %p '%s'\n", [rbx].ELEM.prev, rbx, [rbx].ELEM.next, [rbx].ELEM.data)
        mov rbx, [rbx].ELEM.next
    .endw
    SetConsoleTextAttribute(hStdOut, 0x07)           ; 0x0F (default) = gri (7) pe fundal negru (0)
    ret
PrintList endp

 ; functie pentru afisarea unui mesaj trimis ca parametrum si returneaza
 ; pointer la un spatiu alocat dinamic cu o copie a textului introdus 
input proc uses rbx _msg:ptr BYTE
  local _buffer[101]:BYTE
  local _read:DWORD
    printf(_msg)                             ; afisarea mesagului
    ; ReadConsole returneaza in variabila read numarul de caractere
    ; citire inclusiv '\n' corespunzator apararii tastei ENTER
    ReadConsole(hStdIn, &_buffer, 100, &_read, NULL)
    ; buffer[read-2]='\0' pt. a "sterge" '\n' de la final
    lea  rax, _buffer                       ; RAX = &buffer
    mov  ebx, _read                         ; RBX = zeroextend(read)
    mov  byte ptr [rax+rbx-2], 0            ; &(buffer+read-2) = '\0'
    dec  rbx                                ; RBX-- = strlen+1
    mov  rbx, malloc(rbx)                   ; RBX = malloc(strlen+1)
    strcpy(rbx, &_buffer)                   ; copiere continut buffer
    mov  rax, rbx                           ; RAX = RBX valoarea returnata
    ret
input endp

AddFirst proc uses rbx rsi _list:ptr LIST
    mov rsi, _list
    mov rbx, malloc(sizeof(ELEM))           ; RBX = pointer la un nou element (new)
    .if rbx
        mov [rbx].ELEM.data, input("Valoarea primului element: ")
        mov rax, [rsi].LIST.first           ; RAX = @first (copy of "first")
        .if rax == NULL                     ; if @first==NULL // lista vida
            mov [rbx].ELEM.prev, NULL       ;  { new.prev = NULL
            mov [rbx].ELEM.next, NULL       ;    new.next = NULL
            mov [rsi].LIST.first, rbx       ;    first = new
            mov [rsi].LIST.activ, rbx       ;    activ = new
            mov [rsi].LIST.last, rbx        ;    last = new }
        .else                               ; else {
            mov [rbx].ELEM.prev, NULL       ;    new.prev = NULL
            mov [rbx].ELEM.next, rax        ;    new.prev = @first
            mov [rax].ELEM.prev, rbx        ;    first.prev = new
            mov [rsi].LIST.first, rbx       ;    first = new
        .endif                              ;  }
    .else
        printf("Eroare la alocarea memoriei pentru nod!")
    .endif
    ret
AddFirst endp

AddLast proc uses rbx rsi _list:ptr LIST
    mov rsi, _list
    mov rbx, malloc(sizeof(ELEM))           ; RBX = pointer la un nou element (new)
    mov [rbx].ELEM.data, input("Valoarea ultimului element: ")
    .if rbx
        mov rcx, [rsi].LIST.last            ; RCX = @last (copy of "last")    
        .if rcx == NULL                     ; if @last==NULL // lista vida
            mov [rbx].ELEM.prev, NULL       ;  { new.prev = NULL
            mov [rbx].ELEM.next, NULL       ;    new.next = NULL
            mov [rsi].LIST.first, rbx       ;    first = new
            mov [rsi].LIST.activ, rbx       ;    activ = new
            mov [rsi].LIST.last, rbx        ;    last = new }
        .else                               ; else {
            mov [rbx].ELEM.next, NULL       ;    new.next = NULL
            mov [rbx].ELEM.prev, rcx        ;    new.prev = @last
            mov [rcx].ELEM.next, rbx        ;    last.next = new
            mov [rsi].LIST.last, rbx        ;    last = new
        .endif                              ;  }
    .else
        printf("Eroare la alocarea memoriei pentru nod!")
    .endif
    ret
AddLast endp

AddAbove proc uses rbx rsi _list:ptr LIST
    mov rsi, _list
    mov rbx, malloc(sizeof(ELEM))           ; RBX = pointer la un nou element (new)
    .if rbx
        mov [rbx].ELEM.data, input("Valoarea elementului superior: ")
        mov rcx, [rsi].LIST.activ           ; RCX = @activ (copy of "activ")
        .if rcx == NULL                     ; if @activ==NULL // lista vida
            mov [rbx].ELEM.prev, NULL       ;  { new.prev = NULL
            mov [rbx].ELEM.next, NULL       ;      new.next = NULL
            mov [rsi].LIST.first, rbx       ;    first = @new
            mov [rsi].LIST.activ, rbx       ;    activ = @new
            mov [rsi].LIST.last, rbx        ;    last = @new }
        .else                               ; else {
            mov rax, [rcx].ELEM.prev        ;    RCX = @activ.prev
            mov [rcx].ELEM.prev, rbx        ;    activ.prev = new
            mov [rbx].ELEM.next, rcx        ;    new.next = @activ
            mov [rbx].ELEM.prev, rax        ;    new.prev = @activ.prev
            .if rax != NULL                 ;    if @activ.prev != NULL
                mov [rax].ELEM.next, rbx    ;       (@activ.prev).next = new
            .else                           ;    else
                mov [rsi].LIST.first, rbx   ;       first = new
            .endif
        .endif                              ;  }
    .else
        printf("Eroare la alocarea memoriei pentru nod!")
    .endif
    ret
AddAbove endp

AddBelow proc uses rbx rsi _list:ptr LIST
    mov rsi, _list
    mov rbx, malloc(sizeof(ELEM))           ; RBX = pointer la un nou element (new)
    .if rbx
        mov [rbx].ELEM.data, input("Valoarea elementului inferior: ")
        mov rax, [rsi].LIST.activ           ; RAX = @activ (copy of "activ")
        .if rax == NULL                     ; if @activ==NULL // lista vida
            mov [rbx].ELEM.prev, NULL       ;  { new.prev = NULL
            mov [rbx].ELEM.next, NULL       ;    new.next = NULL
            mov [rsi].LIST.first, rbx       ;    first = new
            mov [rsi].LIST.activ, rbx       ;    activ = new
            mov [rsi].LIST.last, rbx        ;    last = new }
        .else                               ; else {
            mov rcx, [rax].ELEM.next        ;    RCX = @activ.next
            mov [rax].ELEM.next, rbx        ;    activ.next = new
            mov [rbx].ELEM.prev, rax        ;    new.prev = @activ
            mov [rbx].ELEM.next, rcx        ;    new.next = @activ.next
            .if rcx != NULL                 ;    if @activ.next != NULL
                mov [rcx].ELEM.prev, rbx    ;       (@activ.next).prev = new
            .else                           ;    else
                mov [rsi].LIST.last, rbx    ;       last = new
            .endif
        .endif                              ;  }
    .else
        printf("Eroare la alocarea memoriei pentru nod!")
    .endif
    ret
AddBelow endp

DeleteActiv proc uses rbx rsi _list:ptr LIST
    mov rsi, _list
    mov rbx, [rsi].LIST.activ           ; RBX = @activ
    .if rbx != NULL                     ; if @activ != NULL
        mov rax, [rbx].ELEM.prev        ;   { RAX = @activ.prev
        mov rcx, [rbx].ELEM.next        ;     RCX = @activ.next
        .if rax != NULL                 ;     if @activ.prev != NULL
            mov [rax].ELEM.next, rcx    ;       { (@activ.prev).next = @activ.next
            mov [rsi].LIST.activ, rax   ;          activ = @actic.prev }
        .else                           ;       else {
            mov [rsi].LIST.first, rcx   ;          first = @activ.next
            mov [rsi].LIST.activ, rcx   ;          activ = @activ.next
        .endif                          ;       }
        .if rcx != NULL                 ;     if @activ.next != NULL
            mov [rcx].ELEM.prev, rax    ;       { (@activ.next).prev = @activ.prev
            mov [rsi].LIST.activ, rcx   ;          activ = @actic.next }
        .else                           ;       else {
            mov [rsi].LIST.last, rax    ;          first = @activ.prev
            mov [rsi].LIST.activ, rax   ;          first = @activ.prev
        .endif
        free([rbx].ELEM.data)           ;     eliberare memorie pt informatia nodului
        free(rbx)                       ;     eliberare memorie pt nod
    .endif                              ;    }
    ret
DeleteActiv endp

DeleteList proc uses rbx rsi _list:ptr LIST
    mov rsi, _list
    mov rbx, [rsi].LIST.first           ; RBX (@node) = @first
    .while rbx != NULL                  ; while (@node != NULL) {
        free([rbx].ELEM.data)           ;    eliberare informatia din nod
        mov rcx, rbx                    ;    RCX = @node (copie nod curent)
        mov rbx, [rbx].ELEM.next        ;    @node = @node.next
        free(rcx)                       ;    eliberare nodul curent (copia din RCX)
    .endw                               ; } // la final RBX = NULL
    mov [rsi].LIST.first, rbx           ; first = NULL
    mov [rsi].LIST.activ, rbx           ; activ = NULL
    mov [rsi].LIST.last, rbx            ; last = NULL
    ret
  DeleteList endp

ClearScreen proc uses rbx
    LOCAL noCh:DWORD
    LOCAL sbi:CONSOLE_SCREEN_BUFFER_INFO
    GetConsoleScreenBufferInfo(hStdOut, &sbi)
    mov  ax, sbi.dwSize.X
    mov  cx, sbi.dwSize.Y
    mul  cx             ; DX:AX = AX*CX = sbi.dwSize.X * sbi.dwSize.Y
    cwde                ; EAX = DX:AX
    mov ebx, eax        ; EBX (reg protejat) = EAX
    FillConsoleOutputCharacter(hStdOut, ' ', ebx, NULL, &noCh)
    FillConsoleOutputAttribute(hStdOut, 07h, ebx, NULL, &noCh)
    SetConsoleCursorPosition(hStdOut, NULL)
    SetConsoleTextAttribute(hStdOut, 07h)
    ret
ClearScreen endp

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

end