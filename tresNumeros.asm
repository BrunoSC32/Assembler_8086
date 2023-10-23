
;Ingresar tres numeros y mostrar de mayor a menor

org 100h 

ordenado db 4 DUP ('$')    
   
inicio:
    call capturar
    mov bh, al
    call capturar
    mov ch, al 
    call capturar
    mov dh, al       
    cmp bh, ch
    ja  pasada1 
    xchg bh, ch


pasada1:
    cmp bh, dh
    ja pasada2
    xchg bh, dh 

pasada2:
    cmp ch, dh 
    ja almacenar
    xchg ch, dh 
    
almacenar:
    mov [ordenado ], bh
    mov [ordenado + 1], ch
    mov [ordenado + 2], dh 
    call saltoLinea 
    jmp mostrar
    
mostrar:      
    mov dx, offset ordenado
    mov ah, 9 
    int 21h          
    
fin: 
    int 20h  

capturar proc
    mov ah, 1
    int 21h 
    cmp al, 13
    je capturar 
    cmp al, '0'
    jb capturar
    cmp al, '9'
    ja capturar 
    jmp capturar
    ret
capturar endp

saltoLinea proc
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h 
    ret
saltoLinea endp    
    



