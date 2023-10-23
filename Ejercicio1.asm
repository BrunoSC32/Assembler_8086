
;Dados dos numeros, sumarlos, si alguno es par, multiplicarlos si alguno es
;multiplo de 3 y sino restarlos al no cumplir con ninguno de los anteriores

org 100h
inicio:

    mov dh, 5
    mov dl, 7
    mov bl, 2      
    mov bh, 3
    
    ; pare ver si es par
    
    mov bl, 2
    mov al, dh
    div bl
    cmp ah, 0
    je suma    
    
    mov ax, 0
    mov al, dl
    div bl
    cmp ah, 0
    je suma
             
    ;Para ver si es multiplo de 3             
             
    mov ax, 0
    mov al, dh
    div bh
    cmp ah, 0
    je multi
    
    mov ax, 0
    mov al, dl
    div bh  
    cmp ah, 0
    je multi
    jmp restar
    
restar:
    cmp dh, dl
    jae restarDhDl
    jmp restarDlDh
    
restarDhDl:
    sub dh, dl  
    jmp fin
    
restarDlDh:
    sub dl, dh 
    jmp fin
    
multi:
    mov ax, 0
    mov al, dl
    mul dh
    jmp fin
    
suma: 
    add dh, dl

fin: int 20h



;Dados dos numeros, verificar si el cociente sera mayor que 0, sino lo fuese
;multiplicarlos 

org 100h
inicio:
    mov ch, 5
    mov cl, 2
    
    mov ax, 0
    mov al, ch
    div cl
    
    cmp al, 0
    ja fin
    
    mov ax, 0 
    mov al, ch
    mul cl
fin:int 20h