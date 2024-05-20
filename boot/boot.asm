[org 0x7c00]              
[bits 16]

section code

.init:
    mov eax, 0xb800
    mov es, ax              
    mov eax, 0

.main:
    mov byte [es:0x00], 'H'
    mov byte [es:0x01], 0x30

.clear:
    mov byte [es:eax], 0
    inc eax
    mov byte [es:eax], 0x30
    inc eax
    cmp eax, 2 * 25 * 80
    jl .clear

hello:                     
    mov esi, hello_str     
    mov edi, 0x02          
.print:
    lodsb                  
    or al, al              
    jz .done               
    mov [es:edi], al       
    inc edi                
    mov byte [es:edi], 0x07
    inc edi                
    jmp .print             
.done:
    jmp $                  

hello_str db 'hello', 0    

times 510 - ($ - $$) db 0x00

db 0x55
db 0xaa
