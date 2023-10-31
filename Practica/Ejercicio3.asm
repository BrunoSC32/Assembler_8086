;3.- Realizar un programa que solo permita el ingreso de 
;números (N) de 8 bits cada uno. Mostrar el
;promedio de los primos y la normal de todos ellos.

org 100h

unDigito macro
    mov ah, 1
    int 21h
    sub al, 30h
    mov ah, 0
endm

;-------------------- 

8bits macro 
    
    unDigito
    
    mov dx, 10
    mul dx
    mov bx, ax
    
    unDigito
    
    add bx, ax 
    mov ax, bx
    mov dx, 10
    mul dx    
    mov bx, ax
    
    unDigito
    
    add bx, ax
    
     
fin8bits:
endm



;--------------------

esPrimo macro reg, bool

    mov ch, 2
    
ciclo: 
    mov ah, 0 
    mov al, reg  
    
    cmp ch, reg
    je true
    
    div ch 
    
    cmp ah, 0
    je falso
    
    inc ch 
    jmp ciclo
    
true:
    mov bool, 1
    jmp finPrimo
    
falso:
    mov bool, 0
    jmp finPrimo
finPrimo:
            
endm

;--------------------
                     
capturar macro
    mov ah, 1
    int 21h
    mov ah, 0
endm


;--------------------

                     
guardar macro dato
    
    mov di, [indice]
    mov [di], dato
    add di, 1
    mov [indice] , di
                         
endm
;-------------------- 
                     
tamanio macro
    mov ax, [indice]
    mov bx, offset primos
    sub ax, bx
    mov cx, ax
endm
                     
;-------------------- 
sumar macro
    xor dx, dx
    xor bx, bx
    xor ax, ax
                   
cicloSumar:                   
    mov di, offset primos
    add di, dx
    mov al, [di]
    add bl, al
    inc dl
    loop cicloSumar             
endm                       

;--------------------
                     
imprimir macro cadena
    mov ah, 9
    mov dx, cadena     
    int 21h
endm
                         

;--------------------
                     
imprimir8bits macro reg

empezar:   
    mov al, reg
    xor ah, ah
    mov ch, 10
    div ch
    
    mov reg, ax
    
    cmp al, 0
    je finImprimir
    
    jmp empezar              
                  
finImprimir:

    
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

div10 macro reg 
    
    xor dx, dx
    mov ax, reg
    mov cx, 10
    div cx
    
endm    

;-------------------- 
 
imprimir16 macro reg
    mov ah, 2
    mov dx, reg
    int 21h
    
    endm   

;--------------------
                     
;Normal proc length, prom
;    
;    xor dx, dx
;    xor bx, bx
;    xor ax, ax
;                   
;cicloSumar:                   
;    mov di, offset primos
;    add di, dx
;    mov al, [di]
;    sub al, prom
;    mov bl, al
;    mul bl
;    
;    inc dl
;    loop cicloSumar
                         

;-------------------- 
  
comienzo: 
    xor cx, cx   
inicio:

    

    8bits
    cmp bx, 255
    ja fin
    
    inc cl
    push bx
    
    capturar
    
    cmp al, 13
    je primo 
    
    jmp inicio
    
primo:
    
    
    cmp cl, 0
    je sig
    
    pop bx
    dec cl       
    
    esPrimo bl, dl
    
    cmp dl, 0
    je primo
    
    
    guardar bl
    
    jmp primo 
    
sig:

    tamanio
    
    push cx 
    
    sumar
    
    mov al, bl
    
    pop bx
    
    div bl 
    
    push ax        
    
    mov dx, offset promedio
    
    imprimir dx
    
    pop bx 
    
    cmp bl, 9
    ja dosCifras
    
    mov dl, bl
    mov ah, 2  
    add dl, 30h
    int 21h
    
    mov dl, 2eh
    int 21h
    
    mov dl, bh
    add dl, 30h
    int 21h
    
    jmp fin
    
dosCifras: 

    imprimir3d bx, 1   
    
              
    
        


fin: int 20h

;-------------------- 

indice dw offset primos

primos db 55 DUP ('$')

promedio db "El promedio de los numeros primos es de: $"


  

