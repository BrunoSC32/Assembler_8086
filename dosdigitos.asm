
;Capturar un numero de dos cifras
;0001->0010->1100

org 100 
inicio:

    call doscifras
    mov [dia], bh 
    call signo
    
    call doscifras
    mov [mes], bh 
    call signo
    
    call doscifras 
    mov [anio], bh

     
    
              


fin:int 20h

fecha dw '$','$'
dia dw '$','$'
mes dw '$','$'
anio dw '$','$'

doscifras proc
    call capturar
    sub al, 30h
    mov bh, 10
    mul bh
    mov bh, al
    
    call capturar
    mov bl, al
    sub bl, 30h
     
    add bh, bl 
    mov bl, 0
    
    
    ret
doscifras endp        
    

capturar proc
    mov ah, 1
    int 21h
    cmp al, '0'
    jb capturar
    cmp al, '9'
    ja capturar
    ret 
    
capturar endp    
           
              
signo proc
    ret
signo endp                  
