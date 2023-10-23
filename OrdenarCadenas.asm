
;Ingresar 3 cadenas y mostraslas ordenadas

org 100h  

string1 db 56 DUP ('$')
string2 db 56 DUP ('$')
string3 db 56 DUP ('$') 


inicio: 
    mov cx, 19
    mov si, offset string1
    call captura  
    call saltoLinea
    
    mov cx, 19
    mov si, offset string2
    call captura  
    call saltoLinea 
                   
                   
    mov si, offset string1
    mov di, offset string2
    mov ah,[si]
    mov al, [di]
    
    cmp ah, al
    jb mostrar
    mov si, offset string1
    mov di, offset string3
    call inter
    
    mov si, offset string2
    mov di, offset string1
    call inter
    
    mov si, offset string3
    mov di, offset string2
    call inter                   
     
mostrar:
    mov ah, 9
    mov dx, offset string1
    int 21h
    call saltoLinea
    mov ah, 9
    mov dx, offset string2
    int 21h   


fin: int 20h 

    
inter proc
    mov cx, 19
next:
    mov bh, [si]
    mov [di], bh
    inc si
    inc di
    loop next 
    
ret
inter endp               

    
    
captura proc 
    
ciclo:
    mov ah, 1
    int 21h
    cmp al, 13
    je fin2
    mov [si], al
    inc si
    loop ciclo
    
fin2:ret 

captura endp




saltoLinea proc
    mov dl, 13
    mov ah, 2
    int 21h
    mov dl, 10
    int 21h
    ret
saltoLinea endp    
        
         
   


    


