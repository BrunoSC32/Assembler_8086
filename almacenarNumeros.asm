
;Capturar n numeros , almacenarlos de forma 
;que se muestren como numeros de dos digitos
;en el orden de ultimo numero como unidad y 
;el siguiente como decena


org 100h
Inicio:
    mov cl, 0

inicio2:
    mov ah, 1
    int 21h
    cmp al, 13 
    je esValido
    cmp al, '9'
    ja inicio2
    cmp al, '0'
    jb inicio2
    mov ah, 0
    push ax 
    add cl, 1
    jmp inicio2  
    
esValido:
    cmp cl, 0
    je fin 
    jmp saltoLinea
    
saltoLinea:
    mov ah, 2
    mov dl, 10
    int 21h  
    mov dl, 10
    int 21h
    jmp mostrar 
    
mostrar:    
    pop dx
    mov ah, 2
    int 21h 
    sub cl, 1
    cmp cl, 0
    je fin
    pop dx 
    mov ah, 2
    int 21h
    sub cl, 1
    cmp cl, 0
    je fin
    jmp saltoLinea 

fin: int 20h
    