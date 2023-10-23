;Realizar un programa que permita el ingreso de n numeros
;hasta presionar enter. Luego mostrar un menu que permita
;seleccionar una operacion 1:mostrar pares 2:mostrar primos
;3:mostrar no primos y no pares

org 100h 

mov cl, 0 
mov ch, 2

inicio:
    mov ah, 1
    int 21h 
    cmp al, 13  
    je menu
    cmp al, '0'
    jb inicio
    cmp al, '9'
    ja inicio
    push ax
    inc cl  
    jmp inicio
    
menu:   
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h
    mov dl, '1'
    int 21h
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h
    mov dl, '2'
    int 21h
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h
    mov dl, '3'
    int 21h 
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h
    jmp comprobar
    
comprobar:
    cmp cl, 0
    je fin
    mov ah, 7
    int 21h
    cmp al, '0'
    jb comprobar
    cmp al, '3'
    ja comprobar
    jmp operacion
    
operacion:
    cmp al, '3'
    je npp
    cmp al, '2'
    je primo
    cmp al, '1'
    je pares
    
pares:
    mov ax, 0
    mov bx, 0
    pop ax 
    sub cl, 1
    mov ch, al
    mov bl, 2
    div bl
    cmp ah, 0
    jne pares
    mov ah, 2
    mov dl, ch
    int 21h
    cmp cl, 0
    je fin
    jmp pares  
    
primo:   
    mov ch, 2
    mov ax, 0
    mov bx, 0
    cmp cl, 0
    je fin
    pop bx
    sub bx, 30h
    sub cl, 1
    jmp esprimo
    
esPrimo:  
    cmp bl, 2
    je imprimo 
    mov ax, 0
    cmp ch, bl
    jae imprimo
    mov al, bl 
    div ch
    cmp ah, 0
    je primo
    inc ch
    jmp esPrimo
    
imprimo:
    mov ah, 2
    mov dl, bl
    add dl, 30h
    int 21h
    jmp primo  

    

npp:  

fin: int 20h   

    


