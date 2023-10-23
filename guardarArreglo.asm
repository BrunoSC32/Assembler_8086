org 100h
inicio:
    mov cx, 0
    mov ah, 1
    
ciclo: 
    int 21h
    cmp al, 13    
    je next
    push ax
    inc cx
    jmp ciclo
    
next:
    mov si, offset mayus
    mov di, offset minus
    
ciclo2:
    pop ax
    cmp al, 'A'
    jb sig
    cmp al, 'Z'
    ja sig
    mov [si], al
    inc si
    jmp ciclo2
    
sig: 
    cmp al, 'a'
    jb ciclo2
    cmp al, 'z'
    ja ciclo2
    mov [di], al
    inc di
    loop ciclo2
    
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h
    
    mov dx, offset mayus
    mov ah, 9
    int 21h
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h
    mov dx, offset minus
    mov ah, 9
    int 21h 
    
fin: int 20h            


mayus db 15 DUP ('$') 
minus db 15 DUP ('$')