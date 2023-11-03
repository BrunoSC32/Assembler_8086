;ingresar una fecha

org 100h 

;-----------------

nDigitos macro
    local ciclo, primerDigito, finMacro
    xor bx, bx
    xor ax, ax
                   
ciclo:    
    mov ah, 1
    int 21h
    mov ah, 0 
    
    cmp al, 13
    je finMacro
    
    sub al, 30h
    
    cmp bx, 0
    je primerDigito
    
    xchg bx, ax
    
    mov cl, 10
    mul cl
    
    add ax, bx
    xchg ax, bx
    
    jmp ciclo
    
primerDigito:
    mov bx, ax
    jmp ciclo
    
finMacro:
endm        
   
;-----------------
dosCifras macro 

    mov ah, 1
    int 21h    
    sub al, 30h
    
    mov bl, 10
    mul bl
    
    mov bl, al
    
    mov ah, 1
    int 21h   
    sub al, 30h
    
    add bl, al
endm

;----------------- 

acomodarFecha macro
    
    pop bx 
    shl bx, 9
    
    pop ax
    shl ax, 5
    
    or bx, ax
    
    pop ax
    or bx, ax
endm   
    

;-----------------

imprimirCadena macro cadena
    mov dx, cadena
    mov ah, 9
    int 21h
endm


;----------------- 
                  
convertirAnios macro reg
    xor dx, dx 
     
    mov ax, reg
    mov bx, 365
    div bx
    
endm   
                     
;----------------- 
                  
convertirMes macro reg
    xor dx, dx
    
    mov ax, reg
    mov bx, 30
    div bx
                      
endm
;-----------------

sumarFechas macro fecha1, fecha2
    
    mov ax, fecha1
    and ax, 0000000000011111b 
    shr fecha1, 5
    
    mov bx, fecha2
    and bx, 0000000000011111b
    shr fecha2, 5
    
    ;guardo el dia de mi nueva fecha en cx
    add ax, bx                            
    mov cx, ax
    
    mov ax, fecha1
    and ax, 0000000000001111b
    shr fecha1, 4
    
    mov bx, fecha2
    and bx, 0000000000001111b
    shr fecha2, 4
    
    add ax, bx
    shl ax, 5
    or cx, ax
    
    mov ax, fecha1
    and ax, 0000000001111111b 
    
    mov bx, fecha2
    and bx, 0000000001111111b
    
    add ax, bx
    shl ax, 9
    or cx, ax 
endm
    
    

;-----------------

imprimirFecha macro fecha
    
    mov ax, fecha
    and ax, 0000000000011111b
    shr fecha, 5
    
    mov bl, 10
    div bl
    mov bh, ah
    
    mov ah, 2
    mov dl, al
    add dl, 30h
    int 21h
    
    mov dl, bh
    add dl, 30h
    int 21h
     
    mov dl, 2fh
    int 21h
    
    mov ax, fecha
    and ax, 0000000000001111b
    shr fecha, 4 
     
    mov bl, 10
    div bl
    mov bh, ah
    
    mov ah, 2
    mov dl, al
    add dl, 30h
    int 21h
    
    mov dl, bh
    add dl, 30h
    int 21h
    
    mov dl, 2fh
    int 21h
    
    mov ax, fecha
    and ax, 0000000001111111b  
                         
    mov bl, 10
    div bl
    mov bh, ah
    
    mov ah, 2
    mov dl, al
    add dl, 30h
    int 21h
    
    mov dl, bh
    add dl, 30h
    int 21h
                             
endm     

;-----------------

inicio:
    
    dosCifras
    push bx
    call slash 
    
    
    dosCifras 
    push bx
    call slash 
    
    dosCifras
    push bx
    
    acomodarFecha
    push bx
    
    call salto
    mov si, offset menu1
    imprimirCadena si
    
    nDigitos
    
    convertirAnios bx
    
    push ax
    mov bx, dx
    
    convertirMes bx 
    
    push ax
    push dx
    
    pop ax; dia
    pop bx  ; mes
    pop cx; anio
    
    push ax
    push bx
    push cx
    
    acomodarFecha  
    
    push bx
    
    pop si
    pop di
    
    sumarFechas si, di  
    
    call salto
    
    imprimirFecha cx
    
fin: int 20h 
;-----------------

menu1 db "Ingrese el numero de dias a sumar: $"

;-----------------

slash proc
    mov ah, 2
    mov dl, 2fh
    int 21h
    ret
slash endp 

;-----------------

salto proc
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h
    ret
salto endp    