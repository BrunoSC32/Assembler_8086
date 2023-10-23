
;Capturar n numeros, almacenarlos de forma que se muestren
;en numeros de dos digitos, donde

org 100h

mov cl, 0

inicio:
    mov ah, 1
    int 21h
    cmp al, 13
    je mostrar
    cmp al, '0'
    jb inicio
    cmp al, '9'
    ja inicio
    inc cl
    mov bl, al
    push bx
    jmp inicio
    
mostrar: 
    cmp cl, 0
    je fin 
    mov bx, 0
    mov ax, 0
    mov ah, 2
    mov dl, 13
    int 21h 
    mov dl, 10
    int 21h
    pop bx
    sub cl, 1
    mov dl, bl
    int 21h
    cmp cl, 0
    je fin
    pop bx
    sub cl, 1
    mov dl, bl
    int 21h
    jmp mostrar
    
fin: int 20h
    
    