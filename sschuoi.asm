.model small
.stack 100
.data
    tb1 db 'Nhap ma sv: $'
    tb2 db 10,13,'Xin chao: $'
    tb3 db 10,13,"Nhap chuoi 1: $"
    tb4 db 10,13,"Nhap chuoi 2: $"
    tb5 db 10,13,"Giong nhau.$"
    tb6 db 10,13,"Khong giong nhau.$"
    chuoi db 30 dup('$')
    str1 db 256 dup("$")
    str2 db 256 dup("$")
.code
main proc
    
    mov ax,@data
    mov ds,ax
    
    ;THONG BAO 1
    MOV AH,09h
    LEA DX,TB1
    INT 21H
        
    ;NHAP CHUOI
    mov dx, offset chuoi
    mov ah, 0ah
    int 21h
        
    ;THONG BAO 2
    MOV AH,09h
    LEA DX,TB2
    INT 21H
        
    ;IN CHUOI
    lea dx,[chuoi+2]
    mov ah,09h
    int 21h
        
    ;THONG BAO 3
    lea dx,tb3
    mov ah,9
    int 21h 
    
    ;NHAP STR 1
    lea dx,str1
    mov ah,10
    int 21h
    
    ;THONG BAO 4
    lea dx,tb4
    mov ah,9
    int 21h
    
    ;NHAP STR 2
    lea dx,str2
    mov ah,10
    int 21h
    
    XOR CX,CX
    lea si,str1+2
    mov cl,str1+1
    
    ;CHO STR1 VAO STACK
    lap: 
    mov dx,0
    mov dx,[si]
    push dx
    INC SI
    loop lap
    
    mov cl,str2+1
    MOV BL,CL
    inc bl
    LAP2:
    lea SI,STR2+bx
    dec bl
    pop dx
    CMP Dx,[si]
    JNE KHONG     
    LOOP LAP2
    
    MOV DX,OFFSET TB5
    mov ah,9
    int 21h
    JMP EXIT
    
    KHONG:
    MOV DX,OFFSET TB6
    mov ah,9
    int 21h
     
    exit:
    mov ah,4ch
    int 21h
    
main endp
end