;Crear un programa que reciba un numero de una cifra y
;lo imprimima si es primo sino no hace nada

org 100h    
mov cl, 2

inicio:
    mov ah, 1
    int 21h
    cmp al, '0'
    jb inicio
    cmp al, '9'
    ja inicio 
    mov bl,al
    jmp esPrimo
    
esPrimo:
    cmp cl, bl
    jae imprimo
    mov ax, bx
    div cl
    cmp ah, 0
    je fin
    inc cl
    jmp esPrimo 
    
imprimo:
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h
    mov dl, bl
    int 21h
    
fin: int 20h
     




