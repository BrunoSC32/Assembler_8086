
;capturar numeros de 3 cifras

org 100h 

;Multiplica por 10 el reg usando ax y dx
multi10 macro reg
    
    mov ax, reg   
    mov dx, 10
    mul dx
    mov reg, ax
endm  

;------------------- 

div10 macro reg 
    
    xor dx, dx
    mov ax, reg
    mov cx, 10
    div cx
    
endm

;-------------------

;captura un numero de una cifra en reg 
unDigito macro reg
    
    mov ah, 1
    int 21h  
    sub al, 30h
    mov ah, 0
    mov reg, ax
    
endm 

;-------------------

dosDigitos macro reg
    
    unDigito reg
    
    multi10 reg
    
    unDigito ax
    
    add reg, ax
    
endm    
    
;------------------- 
    
tresDigitos macro 
    
    dosDigitos bx 
    
    multi10 bx
    
    unDigito ax
    
    add bx, ax    
                
endm 

;--------------------
                     
guardar macro array, reg, i
    mov si, array
    add si, i
    mov [si], reg
    
    endm                              
                     
;--------------------
                     
imprimir16 macro reg
    mov ah, 2
    mov dx, reg
    int 21h
    
    endm                     

;-------------------- 

imprimir8 macro reg
    mov ah, 2
    mov dl, reg
    int 21h
    
    endm 

;-------------------- 

imprimir3d macro reg, labelSuffix

uno&labelSuffix:    
    div10 reg
    mov reg, ax
    
    add dx, 30h
    push dx
    
    cmp reg, 0
    je dos&labelSuffix
    
    jmp uno&labelSuffix

dos&labelSuffix:

    pop reg
    imprimir16 reg
    pop reg 
    imprimir16 reg
    pop reg        
    imprimir16 reg
    
endm   

;--------------------
                     
caracter macro car
    mov ah, 2
    mov dx, 20h
    int 21h
    mov dx, car
    int 21h 
    mov dx, 20h
    int 21h
endm
                        

;--------------------  

inicio: 
    xor cx, cx 


cicloCaptura:
    
    tresDigitos
    
    push bx
    
    inc cl  
    
    cmp cl, 3
    je operacionSuma
    
    call salto
    
    jmp cicloCaptura
    
operacionSuma:
    
    pop ax
    pop bx
    pop cx
    
    call ordenar 
     
    mov di, offset numeros 
    guardar di, ax, 0
    guardar di, bx, 2
    guardar di, cx, 4
    
    mov ax, [numeros + 4]
    mov bx, [numeros + 2]
    add bx, ax
    
resultadoSuma:
    
    mov di, offset resultados
    guardar di, bx, 0
    
    
operacionMulti:
    
    mov ax, [numeros]
    mov bx, [numeros + 4]
    sub ax, bx
    
resultadoMulti:
    
    mov di, offset resultados
    guardar di, ax, 2  
    
imprimirSuma:
    
    mov bx, [resultados] 
    call salto 
    
    mov si, 0   

tabla_Sumas:
    cmp si, 9
    jae imprimirMulti    
    
    mov bx, [resultados]
    imprimir3d bx, 1
    
    caracter 2bh 
    
    mov dl, [del1al9 + si]
    add dl, 30h
    imprimir8 dl
    
    mov bx,[resultados]
    sub dl, 30h
    add bx, dx
    
    mov dx, 20h
    imprimir16 dx
    
    imprimir3d bx, 2
    
    call salto 
    inc si
    jmp tabla_Sumas 

imprimirMulti:
    mov bx, [resultados + 2] 
    call salto 
    
    mov si, 0 
        
tabla_Multi:
    cmp si, 9
    jae fin    
    
    mov bx, [resultados + 2]
    imprimir3d bx, 3
    
    caracter 2ah 
    
    mov dl, [del1al9 + si]
    add dl, 30h
    imprimir8 dl
    
        
    
    mov ax,[resultados + 2]
    sub dl, 30h
    mul dx
    mov bx, ax 

    
    
    mov dx, 20h
    imprimir16 dx
    
    imprimir3d bx, 4
    
    call salto 
    inc si
    jmp tabla_Multi 
    

fin: int 20h 

;*********************

numeros dw 4 DUP ('$')

resultados dw 3 DUP ('$') 

del1al9 db 1,2,3,4,5,6,7,8,9

;*********************

salto proc
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h
    ret
salto endp

;---------------------
              
             
ordenar proc
    
    cmp ax, bx
    ja nchg1_2
    xchg ax, bx 
    
nchg1_2:
    
    cmp bx, cx
    ja nchg2_3
    xchg bx, cx
    
nchg2_3:
    
    cmp ax, bx
    ja finOrdenar
    xchg ax, bx
    
finOrdenar:
    ret   
    
ordenar endp 

;--------------------- 


;--------------------- 

