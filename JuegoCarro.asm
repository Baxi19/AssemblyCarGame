INCLUDE MACROSPALIN.LIB

;------------------------------------------------------------------------------
;                     DEFINICION DEL SEGMENTO DE DATOS
;------------------------------------------------------------------------------
DATOS SEGMENT
    
    ;Variables del programa   
    
    carro1 db "[H]$"      ;Jugador 
    carro2 db "{H]$"      ;carros para random
    limpiarVar db "   $"  ;variable para limpiar
    posicion db 2 
    carretera1 db "- - - - - - - - - - - - - - - - - - - - - - - - -$"
    carretera2 db " - - - - - - - - - - - - - - - - - - - - - - - - $"
    
    
         
    Instrucciones dw '  ',0ah,0dh

dw ' ',0ah,0dh
dw ' ',0ah,0dh
dw '           ====================================================',0ah,0dh
dw '          ||                                                  ||',0ah,0dh                                        
dw '          ||     **         **         **           **        ||',0ah,0dh
dw '          ||    ****       ****       ****         ****       ||',0ah,0dh
dw '          ||     ||         ||         ||           ||        ||',0ah,0dh
dw '          ||                                                  ||',0ah,0dh
dw '          ||                                                  ||',0ah,0dh
dw '          ||==================================================||',0ah,0dh
dw '          ||                                                  ||',0ah,0dh
dw '          ||-  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - ||',0ah,0dh 
dw '          ||                                                  ||',0ah,0dh 
dw '          ||==================================================||',0ah,0dh 
dw '          ||                                                  ||',0ah,0dh 
dw '          ||     **         **         **           **        ||',0ah,0dh
dw '          ||    ****       ****       ****         ****       ||',0ah,0dh
dw '          ||     ||         ||         ||           ||        ||',0ah,0dh
dw '           ====================================================',0ah,0dh
dw '$',0ah,0dh           
    

 DATOS ENDS 
;------------------------------------------------------------------------------
;                     DEFINICION DEL SEGMENTO DE PILA
;------------------------------------------------------------------------------

PILA SEGMENT STACK "STACK"
      db 100h dup(?)
PILA ENDS


;------------------------------------------------------------------------------
;                     DEFINICION DEL SEGMENTO DE CODIGO
;------------------------------------------------------------------------------

CODE SEGMENT
        assume CS:code, DS:datos, SS:pila

;______________________________________________________________________________

START:
  
    mov  ax,datos
    mov  ds,ax
    
;______________________________________________________________________________

  MODOVIDEO:
    mov cx,0h
    mov ah, 13h           ;Establecer modo de Video
    mov al, 02h           ;Resolucion 80*25
    mov bh, 04h           ;Numero de pagina
    int 10h
    
    colores 0ah            ;Color gris
  
;______________________________________________________________________________
  INICIARCURSOR: 

    
    ;gotoxy 28h,0ch        ;busca la pocicion
    imprime Instrucciones        ;Imprime jugador
    
    gotoxy 0Dh,0ch        ;busca la pocicion
    imprime carro1 ;Imprime jugador 
    

;______________________________________________________________________________
   
;##################################################################################    
;              Comparacion de Movimientos en el juego      
;##################################################################################
GAME:
    mov al,00             ;Limpiamos la variable
    mov ah,06             ;Recibimos datos sin eco
    mov dl,255            ;se define los caracteres de la tabla ascii
    int 21h               ;INT teclado
    
    
    cmp al,38h            ;Compara con 8
    ;cmp posicion, 32h
    je call abajo         ;Si es igual salta

    cmp al,32h            ;Compara con 2
    je call arriba              ;Si es igual salta
      
    cmp al, 35h
    je call NuevoCarro
    
      
    call movimientoCarretera 
    jmp GAME
 

;______________________________________________________________________________
   
  OBTENERPOSICION proc near:                           
   
    mov ax,03             ;Obtiene la posicion del mouse
    int 33h               ;INT mouse
    
    mov ax,cx             ;Guarda los valores en pixeles de las filas 
    ;div divisor           ;Se divide entre 8
    ;mov posx,al           ;La posicion en la variable
    
    mov ax,dx             ;Guarda los valores en pixeles de las columnas   
    ;div divisor           ;Se divide entre 8
    ;mov posy,al           ;La posicion en la variable 

    ret
endp

;______________________________________________________________________________
;Proceso para mover el carro hacia abajo con el 2
abajo proc near:                           
    
    gotoxy 0Dh,0dh        ;busca la pocicion
    imprime limpiarVar    ;Limpia el espacio
    gotoxy 0Dh,0bh        ;busca la pocicion
    imprime limpiarVar    ;Limpia el espacio
    gotoxy 0Dh,0ch        ;busca la pocicion
    imprime limpiarVar    ;Limpia el espacio
    gotoxy 0Dh,0bh        ;busca la pocicion
    imprime carro1        ;Imprime jugador
    mov posicion,33h      ;Posicion del vehiculo numero 3
    
    JMP GAME
   
endp


;______________________________________________________________________________
;Proceso para mover el carro hacia arriba con el 8 
arriba proc near:  
    
    gotoxy 0Dh,0dh        ;busca la pocicion
    imprime limpiarVar    ;Limpia el espacio
    gotoxy 0Dh,0bh        ;busca la pocicion
    imprime limpiarVar    ;Limpia el espacio
    gotoxy 0Dh,0ch        ;busca la pocicion
    imprime limpiarVar    ;Limpia el espacio                           
    gotoxy 0Dh,0dh        ;busca la pocicion
    imprime carro1        ;Imprime jugador  
    mov posicion,31h      ;Posicion del vehiculo numero 1
    
    jmp GAME

   
endp

;______________________________________________________________________________
;Proceso para el movimiento de las carreteras
movimientoCarretera proc near: 
    
    gotoxy 0dh,0ch            ;busca la pocicion
    imprime carretera1        ;Imprime carretera1 
    gotoxy 0dh,0ch            ;busca la pocicion
    imprime carretera2        ;Imprime carretera2
    ret 
    
 endp
;______________________________________________________________________________
;Proceso para aparecer los carros
NuevoCarro proc near:
    
    gotoxy 3ch,0bh        ;busca la pocicion
    imprime carro2        ;Imprime el carro ramdom
    jmp game
    
 endp

;______________________________________________________________________________
;Proceso para movimiento de los autos   
 
;______________________________________________________________________________


;______________________________________________________________________________


;______________________________________________________________________________


;______________________________________________________________________________


;______________________________________________________________________________


;______________________________________________________________________________


;______________________________________________________________________________


;______________________________________________________________________________

 
;______________________________________________________________________________


;______________________________________________________________________________


;______________________________________________________________________________


;______________________________________________________________________________


;______________________________________________________________________________

 

;______________________________________________________________________________

 SALIR:
        
;limpiar servicio          ;Limpia la pantalla  
colores 14                ;color amarillo

gotoxy 17h,9h             ;Va a la posicion
;imprime msjBye            ;Imprime el msjBye

mov  ax, 4C00h
int  21h

CODE ENDS
END START
;______________________________________________________________________________
   