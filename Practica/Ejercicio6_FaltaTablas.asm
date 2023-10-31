
;contabilizar las repeticiones de un caracter determinado por usted
;segun el numero de repeticiones de ese caracter   

org 100h
inicio:

capturarCadena:
    call capturar
    
    cmp al, 13
    je selecionarCaracter
                         
    mov si, offset indice
    mov di, [si]
    mov [di], al
    inc di
    mov [si], di 
    
    
    jmp capturarCadena                         
    
selecionarCaracter:
    
    call salto
    call capturar
    
    mov cx, [indice]
    sub cx, offset cadena
    mov si, 0
    
ciclo:
    
    mov bl, [cadena + si]
    
    cmp bl, al
    je aumentar
         
    inc si
    
    loop ciclo
    
    jmp tablas
 
aumentar:
    inc bh 
    dec cl
    inc si
    cmp cl, 0
    je tablas
    jmp ciclo
    
    
tablas:
         
    mov cx, 10
    mov si, 0
    
cicloTabla:
    call salto
    
    mov dl, bh
    add dl, 30h
    call imprimir
    
    call asterisco
    
    mov dl, [numeros + si]
    add dl, 30h  
    call imprimir
    mov dl, 20h
    call imprimir
    
    mov al, bh
    mul [numeros + si]
       
    cmp al, 9
    ja dosCifras
                 
    mov dl, al
    add dl, 30h                 
    call imprimir 
    
    inc si
    
    loop cicloTabla
    
dosCifras:
    
    mov bl, 10
    div bl
    mov dl, al
    add dl, 30h
    call imprimir
    mov al, bh
    mul [numeros + si]
    div bl
    mov dl, ah
    add dl, 30h
    call imprimir
     
    dec cl
    inc si
    cmp cl, 0
    je fin
    jmp cicloTabla            
  

fin: int 20h

;********************* 

indice dw offset cadena

cadena db 30 DUP ('$')

numeros db 1,2,3,4,5,6,7,8,9,10

;*********************


capturar proc
    mov ah, 1
    int 21h
    ret
capturar endp    

;---------------------

imprimir proc
    mov ah, 2
    int 21h  
    ret
imprimir endp    

;---------------------

salto proc
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h
    ret
salto endp    

;--------------------- 

asterisco proc
    mov ah, 2
    mov dl, 20h
    int 21h   
    mov dl, 2Ah
    int 21h
    mov dl, 20h
    int 21h
    ret
asterisco endp    
    