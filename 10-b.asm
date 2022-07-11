.model small
.stack 100
.data
    tb1 db 'Nhap ma sv: $'
    tb2 db 10,13,'Xin chao: $'
    tb3 db 10,13,"nhap chuoi: $"
    tb4 db 10,13,"nhap ky tu muon tim: $"
    tb5 db 10,13,"tim thay $"
    tb6 db 10,13,"khong tim thay $"
    chuoi db 30 dup('$')
    str db 256 dup("$")
 
.code
main proc
    
    mov ax,@data
    mov ds,ax
    
    ;TB bao nhap msv
    MOV AH,09h
    LEA DX,TB1
    INT 21H
        
    ;nhap ten
    mov dx, offset chuoi
    mov ah, 0ah
    int 21h
        
    ;TB chuoi vua nhap
    MOV AH,09h
    LEA DX,TB2
    INT 21H
        
    ;in ten
    lea dx,[chuoi+2]
    mov ah,09h
    int 21h
        
    ;in tb1
    lea dx,tb3
    mov ah,9
    int 21h 
    
    ;nhap str
    lea dx,str
    mov ah,10
    int 21h
    
    ;int tb2
    lea dx,tb4
    mov ah,9
    int 21h
    
    ;nhap ky tu
    mov ah,1
    int 21h
    
    mov cx,0
    lea si,str+2
    mov cl,str+1
    
    lap: 
    mov dx,0
    mov dx,[si]
    inc si
    cmp al,dl
    je timthay
    loop lap
    
    khongtimthay:
    lea dx,tb6
    mov ah,9
    int 21h
    jmp exit
    
    timthay:
    lea dx,tb5
    mov ah,9
    int 21h
    jmp exit
    
            
    exit:
    mov ah,4ch
    int 21h
    
main endp
end