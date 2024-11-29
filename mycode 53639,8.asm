.model small               
.stack 100h                
.data                      
    menu_msg db 'Please choose a number from the options below:', 0dh, 0ah  
             db '1. Addition', 0dh, 0ah              
             db '2. Subtraction', 0dh, 0ah           
             db '3. Division', 0dh, 0ah, '$'      
    
    num1_msg db 0dh, 0ah, 'Enter the first number: $'        
    num2_msg db 0dh, 0ah, 'Enter the second number: $'       
    
    add_msg  db 0dh, 0ah, 'The result of addition is: $'              
    sub_msg  db 0dh, 0ah, 'The result of subtraction is: $'       
    div_msg  db 0dh, 0ah, 'The result of division is: $'         
    
    num1 db ?                
    num2 db ?                 
    result db ?               

.code                     
main proc                
    mov ax, @data       
    mov ds, ax            
    
    ; Display menu
menu:
    mov ah, 9             
    lea dx, menu_msg      
    int 21h               
    
    ; Get user choice
    mov ah, 1            
    int 21h               
    sub al, '0'          
    
    ; Compare choice and jump to appropriate operation
    cmp al, 1            
    je addition          
    cmp al, 2             
    je subtraction        
    cmp al, 3            
    je division          
    jmp exit             
    
addition:
    call get_numbers     
    mov al, num1         
    add al, num2         
    mov result, al      
    
    mov ah, 9            
    lea dx, add_msg       
    int 21h              
    
    mov al, result       
    call display_result   
    jmp menu              
    
subtraction:
    call get_numbers     
    mov al, num1         
    sub al, num2         
    mov result, al      
    
    mov ah, 9            
    lea dx, sub_msg      
    int 21h              
    
    mov al, result        
    call display_result   
    jmp menu              
    
division:
    call get_numbers      
    mov al, num1        
    mov ah, 0           
    div num2            
    mov result, al       
    
    mov ah, 9            
    lea dx, div_msg       
    int 21h              
    
    mov al, result        
    call display_result   
    jmp menu              
    
get_numbers proc         
    ; Get first number
    mov ah, 9             
    lea dx, num1_msg     
    int 21h              
    
    mov ah, 1             
    int 21h               
    sub al, '0'           
    mov num1, al         

    ; Get second number
    mov ah, 9             
    lea dx, num2_msg      
    int 21h               
    
    mov ah, 1             
    int 21h               
    sub al, '0'           
    mov num2, al         

    ret                   
get_numbers endp

display_result proc       
    ; Convert number to ASCII and display
    add al, '0'           
    mov dl, al            
    mov ah, 2             
    int 21h               
    
    ; For the new line
    mov dl, 0dh           
    int 21h               
    mov dl, 0ah           
    int 21h               
    
    ret                   
display_result endp

exit:                   
    mov ah, 4ch         
    int 21h             
    
end main
