
;Realizar un programa que solo permita la el ingreso de N numeros
;de 8bits cada uno (< 256). Mostrar el promedio de los primos yla normal 
;de todo ellos


;No muevas bl, cl, ch
org 100h
inicio:
    
    xor cx, cx
    call capturar  
    
siguiente:      
    mov sp, dx
    call esPrimo    
 
 


fin: int 20h  

;-------------------- 

primos db 255 DUP ('$') 
esprimop db "ESPRIMO$"
contador dw 0

;-------------------- 




esPrimo proc
    cmp cl, 0
    je final
          
    xor bx, bx          
    pop bx
    sub cl, 1
    
    mov ch, 2 
ciclo:
         
    cmp ch, bl
    je guardar
    
    mov ax, bx
    
    div ch
    
    cmp al, 0
    je call esPrimo 
             
    add ch, 1           
    jmp ciclo

final:
    ret
    
esPrimo endp 


guardar proc
    ; Cargar el contador en si
    mov si, [contador]

    ; Usar si como índice para guardar bl en el arreglo primos
    mov [primos + si], bl

    ; Incrementar el contador
    inc byte ptr [contador]

    ret    
guardar endp      
    

;esPrimo proc
;    
;verificarLoop:
;    
;
;    pop bx
;
;    
;    mov ch, 2
;
;probarDivisor:
;
;    mov ax, bx
;    xor dx, dx     
;    div ch
;    
;    cmp ch, bl
;    je call guardar
;                
;    cmp ah, 0
;    je noEsPrimo
;
;    inc ch
;    jmp probarDivisor
;    
;noEsPrimo:    
;
;    loop verificarLoop
;
;    ret
;esPrimo endp

;--------------------     
     
incrementar proc
    inc dh
    ret
incrementar endp


;-------------------- 

capturar proc
    
    inc cl
    call tresDigitos
    
    push bx 
    mov dx, sp     
    call espacioOrNext
    jmp capturar
    ret
    
capturar endp    
    
;-------------------- 

espacioOrNext proc
    mov ah, 8
    int 21h
    cmp al, 13
    je siguiente
    
    mov dl, 32
    mov ah, 2
    int 21h
    ret 
    
finalEspacio: 
    call esPrimo    
    
espacioOrNext endp

;-------------------- 

tresDigitos proc
    call dosDigitos
    mov bl, 10
    mul bl
    mov bl, al
    call unDigito
    add bl, al
    ret
tresDigitos endp    
    
;-------------------- 

dosDigitos proc
    
    call unDigito
    mov bl, 10
    mul bl
    mov bl, al
    
    call unDigito
    add bl, al
    mov al, bl
    ret
DosDigitos endp

;-------------------- 

unDigito proc
    mov ah, 1
    int 21h
    cmp al, '0'
    jb unDigito
    cmp al, '9'
    ja unDigito
    sub al, 30h
    ret
    
unDigito endp





