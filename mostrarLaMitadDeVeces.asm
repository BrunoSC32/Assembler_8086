;Capturar un numero, si y solo es par, mostrar la mitad de veces que indica
; el numero 4


org 100h
cont:
    mov cl, 0
inicio:
    mov ah, 1
    int 21h
    cmp al, '0'
    jb inicio
    cmp al, '9'
    ja inicio
    mov bl, al 
    ;Guardo el numero en bl
    mov bh, 2
    div bh
    cmp ah, 0   
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h
    je operacion
    jmp inicio 
    
operacion: 
    mov bh, 0 
    mov ax, 0
    mov al, bl
    sub al, 30h
    mov bh, 2
    div bh
    inc cl    
    cmp cl, al
    ja fin 
    jmp imprimir
    
    
imprimir:     
    mov ax, 0
    mov ah, 2
    mov dl, bl
    int 21h
    jmp operacion   
       

fin: int 20h
