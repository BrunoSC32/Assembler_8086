;Capturar un numnero, y mostrar su tabla de suma
;3
;3 + 1 = 4

org 100h

mov cl, '0'  

inicio:
    mov ah, 7
    int 21h
    cmp al, '0'
    jb inicio
    cmp al, '9'
    ja inicio
    mov bl, al
    jmp tabla
    
tabla: 
    mov ah, 2 
    mov dl, bl
    int 21h
    mov dl, '+'
    int 21h
    mov dl, 0
    inc cl
    mov dl, cl
    int 21h
    mov dl, '='   
    int 21h 
    mov dl, 0
    mov dl, cl
    add dl, bl
    sub dl, 30h
    int 21h    
    jmp verificar
    
verificar:
    cmp cl, 58
    je fin
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h
    jmp tabla
    
    
fin: int 20h 