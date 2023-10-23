;Datos: Nombre, apellido, ci, telefono, 
;departamento y barrio

org 100h
inicio: 
                      
    mov dx, offset setNombre                      
    call imprimirCadena

firtsName:
    call capturar
    
    cmp al, 13
    je validarName
    
    mov bx, 0
    call guardar 
    
    jmp firtsName
    
validarName:    
      
    mov bx, 0
    mov di, offset nombre
    call tamanio 
    
    cmp bl, 3
    jb WrongName
    
    jmp sig1
    
WrongName: 
    
    mov dx, offset errorNombre
    call imprimirCadena
    call salto
    mov dx, offset noEsFactible
    call imprimirCadena
    jmp fin    
    
sig1:

    call salto
    mov dx, offset setApellido
    call imprimirCadena
    
lastName:
    
    call capturar
    
    cmp al, 13
    je validateLastName
                
    mov bx, 2                
    call guardar                
                      
    jmp lastName
    
validateLastName:
    
    mov bx, 2
    mov di, offset apellido
    call tamanio            
    
    cmp bl, 3
    jb wrongLastName
    
    jmp sig2
    
wrongLastName:
    
    mov dx, offset errorApellido
    call imprimirCadena 
    call salto
    mov dx, offset noEsFactible
    call imprimirCadena
    jmp fin
    
sig2:

    call salto
    mov dx, offset setCi
    call imprimirCadena
    
dni:
    
    call capturar
    
    cmp al, 13
    je validateDni
    
    mov bx, 4
    call guardar
    
    jmp dni
    
validateDni:
              
    mov bx, 4
    mov di, offset ci              
    call tamanio
    mov cx, bx
    
    cmp cx, 7
    jne wrongDni

    mov di, offset ci
    mov si, cx 
    
cicloDni:
    
    mov bl, [di]
    
    cmp bl, '0'
    jb wrongDni
    
    cmp bl, '9'
    ja wrongDni
    
    inc di
    
    loop cicloDni 
    
    jmp sig3
    
wrongDni: 
    
    mov dx, offset errorCi
    call imprimirCadena
    call salto
    mov dx, offset noEsFactible
    call imprimirCadena
    jmp fin
        
sig3:

    call salto
    mov dx, offset setTelefono
    call imprimirCadena

phoneNumber:
    
    call capturar
    
    cmp al, 13
    je validateNumber
                
    mov bx, 6                
    call guardar
    
    jmp phoneNumber
    
validateNumber:
    
    mov bx, 6
    mov di, offset telefono
    call tamanio
    mov cx, bx
    
    cmp cx, 8
    jne wrongNumber
    
    mov di, offset telefono
    mov si, cx 
    
cicloNumber:
   
    mov bl, [di]
    
    cmp bl, '0'
    jb wrongNumber
    
    cmp bl, '9'
    ja wrongNumber
    
    inc di
    
    loop cicloNumber 
    
    mov bl, [telefono]
    
    cmp bl, '4' 
    
    jne wrongRegion
    
    jmp sig4
    
wrongNumber:
    
    mov dx, offset errorNumero
    call imprimirCadena
    call salto
    mov dx, offset noEsFactible
    call imprimirCadena
    jmp fin
    
wrongRegion:
    
    mov dx, offset errorRegion
    call imprimirCadena
    call salto
    mov dx, offset noEsFactible
    call imprimirCadena
    jmp fin    
    
sig4:

    call salto
    mov dx, offset setDepartamento        
    call imprimirCadena
    
    call salto 
    mov dx, offset setBarrio
    call imprimirCadena
    
ponerBarrio:
    
    call capturar
    
    cmp al, 13
    je validateBarrio
    
    mov bx, 10
    call guardar
    
    jmp ponerBarrio
    
validateBarrio:
    
    mov bl, [barrio]
    
    cmp bl, 'c'
    je factible
    
    cmp bl, 'C'
    je factible
    
    cmp bl, 'q'
    je factible
    
    cmp bl, 'Q'
    je factible
    
    cmp bl, 'r'
    je factible
    
    cmp bl, 'R'
    je factible 
    
    jmp wrongBarrio
    
wrongBarrio:

    mov dx, offset errorBarrio
    call imprimirCadena
    call salto
    mov dx, offset noEsFactible
    call imprimirCadena
    jmp fin 
    
factible:

    mov dx, offset esFactible
    call imprimirCadena
    jmp fin    
                 

fin: int 20h

;************************ 

indices dw offset nombre, offset apellido, offset ci, offset telefono, offset departamento, offset barrio

nombre db 25 DUP ('$')
apellido db 25 DUP ('$') 
ci db 25 DUP ('$') 
telefono db 25 DUP ('$')
departamento db 25 DUP ('$') 
barrio db 25 DUP ('$')

setNombre db "Ingrese su nombre: $"
setApellido db "Ingrese su apellido: $"
setCi db "Ingrese su ci: $"
setTelefono db "Ingrese su numero de telefono: $"
setDepartamento db "Su departamento es: Cochabamba$"
setBarrio db "Ingrese su barrio: $"      

esFactible db "El registro es factible $"
noEsFactible db "El registro no es factible $"                     

errorNombre db "Nombre invalido, el nombre debe tener al menos 3 caracteres $"
errorApellido db "Apellido invalido, el apellido debe tener al menos 3 caracteres $"
errorCi db "El ci no debe poseer ninguna letra y debe tener 7 digitos $"
errorNumero db "El numero que introdujo no es valido $"
errorRegion db "El numero que introdujo no pertenece a la region de cochabamba $"  
errorBarrio db "El Barrio intrucido no existe $"

barrio1 db "Cala Cala"
barrio2 db "Queru Queru"
barrio3 db "Recoleta"

                         
;************************

capturar proc
    mov ah, 1
    int 21h
    ret
capturar endp

;------------------------

salto proc 
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h
    ret
salto endp                             
                         
;------------------------   

guardar proc
    mov si, offset indices
    add si, bx
    mov di, [si]
    mov [di], al
    inc di
    mov [si], di
    ret
guardar endp    
    

;------------------------ 
;mover a bx el indice de la lista
;mover a di la direccion de la lista    

tamanio proc
    mov si, [indices + bx]
    sub si, di
    mov bx, si
    ret
tamanio endp    

;------------------------   

imprimirCadena proc
    mov ah, 9
    int 21h
    ret
imprimirCadena endp    

;------------------------ 
                               