;ingresar un fecha de la forma 29/10/23 y lo imprima en binario



org 100h 

;------------------------

imprimir8 macro reg
    mov ah, 2
    mov dl, reg
    int 21h
    mov ah, 0
    mov dl, 0
endm    

;------------------------

imprimir16 macro reg
    mov ah, 2
    mov dx, reg
    int 21h
    mov ax, 0
    mov dx, 0  
endm

;------------------------
                         
imprimirCadena macro cadena
    mov ah, 9
    mov dx, cadena
    int 21h
    mov ah, 0
    mov dx, 0
endm

;------------------------

unDigito macro 
    mov ah, 1
    int 21h
    mov ah, 0
    sub al, 30h
endm
                         
;------------------------
                         
capturasDosDigitos macro 
    unDigito
    mov dl, 10
    mul dl 
    mov bl, al
    
    unDigito
    add bl, al                        
endm
;------------------------ 
;acomoda la fecha que esta en mi pila
fecha_macro MACRO
    pop ax
    shl ax, 9
    mov bx, ax
    pop ax
    shl ax, 5
    or bx, ax
    pop ax
    or bx, ax
ENDM

;------------------------

convertirBase macro num, base
    local ciclo, sig1, letras, finMacro 
    push ax
    push bx
    push cx
    
    mov ax, num        ; Cargar el número a convertir en el registro AX
    mov bx, base       ; Cargar la base a la que se quiere convertir en el registro BX
    mov cx, 0          ; Inicializar el registro CX (que actuará como contador) a 0

ciclo:
    cmp ax, 0          ; Comparar si AX es 0
    je sig1            ; Si es 0, saltar a la etiqueta 'sig1'
    div bx             ; Dividir AX por BX (el resultado queda en AX y el residuo en DX)
    push dx            ; Guardar el residuo en la pila

    mov dx, 0          ; Reiniciar DX a 0
    inc cx             ; Incrementar el contador CX
    jmp ciclo          ; Saltar de nuevo al inicio del ciclo para seguir con la división

sig1:
    mov ah, 2          ; Establecer AH a 2 para la función de impresión de DOS
    cmp cx, 0          ; Comprobar si CX es 0
    je finmacro        ; Si es 0, finalizar el macro

    pop dx             ; Recuperar el residuo desde la pila a DX
    dec cx             ; Decrementar CX

    cmp dl, 9          ; Comparar el residuo con 9
    ja letras          ; Si el residuo es mayor a 9, saltar a la etiqueta 'letras'

    add dl, 30h        ; Convertir el número en su representación ASCII
    int 21h            ; Llamar a la interrupción para imprimir

    jmp sig1           ; Saltar de nuevo a 'sig1' para seguir con el proceso

letras:
    sub dl, 10         ; Restar 10 a DL
    add dl, 'A'        ; Convertir el número en su representación ASCII como letra
    int 21h            ; Llamar a la interrupción para imprimir
    jmp sig1           ; Saltar de nuevo a 'sig1' para seguir con el proceso

finMacro:

    pop ax
    pop bx 
    pop cx

endm

;------------------------

inicio:
    mov cl, 3

cicloCaptura:

    capturasDosDigitos  
    
    push bx 
    cmp cl, 1
    je fecha
   
    
    call imprimirSlash
        
    loop cicloCaptura

fecha:
    fecha_macro
   
mostrarRegistro:
    
    call salto              
    mov si, offset mensaje
    imprimirCadena si  
        
    imprimir16 bx

mostrarMenu:
    call salto
    mov si, offset menu
    imprimirCadena si 
    
    call salto
    mov si, offset opcion1
    imprimirCadena si 
    
    call salto
    mov si, offset opcion2
    imprimirCadena si 
    
    call salto
    mov si, offset opcion3
    imprimirCadena si   
    
verificarSeleccion:
    call salto
    
    mov ah, 8
    int 21h   
    
    cmp al, "a"
    je binario        
    
    cmp al, "b"
    je octal
    
    cmp al, "c"
    je hexadecimal
    
    jmp verificarSeleccion 
       
binario:
   call salto

   mov ax, bx
   
   shl ax, 11
   
   shr ax, 11
   
   convertirBase ax, 2
   call imprimirSlash 
   
   mov ax, bx
   shl ax, 7
   shr ax, 12
   
   convertirBase ax, 2
   call imprimirSlash
   
   mov ax, bx
   shr ax, 9
   
   convertirBase ax, 2
   
   jmp fin            
    
    
octal:
   call salto

   mov ax, bx
   
   shl ax, 11
   
   shr ax, 11
   
   convertirBase ax, 8
   call imprimirSlash 
   
   mov ax, bx
   shl ax, 7
   shr ax, 12
   
   convertirBase ax, 8
   call imprimirSlash
   
   mov ax, bx
   shr ax, 9
   
   convertirBase ax, 8 
   
   jmp fin 

hexadecimal:
   call salto

   mov ax, bx
   
   shl ax, 11
   
   shr ax, 11
   
   convertirBase ax, 16
   call imprimirSlash 
   
   mov ax, bx
   shl ax, 7
   shr ax, 12
   
   convertirBase ax, 16
   call imprimirSlash
   
   mov ax, bx
   shr ax, 9
   
   convertirBase ax, 16   

fin: int 20h 
;************************

mensaje db "el registro bx que contiene a la fecha es: $" 
menu db "Selecciona una de las siguiente opciones para visualizar la fecha$"
opcion1 db "a)Binario$"
opcion2 db "b)Octal$"
opcion3 db "c)Hexadecimal$"

;************************


 
;------------------------ 

imprimirSlash proc
    mov ah, 2
    mov dl, 2fh
    int 21h
    mov ah, 0
    mov dl, 0
    ret
imprimirSlash endp

;------------------------ 

salto proc
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h
    mov ah, 0
    mov dl, 0
    ret
salto endp    

;------------------------ 