.MODEL SMALL
.STACK 100H
.DATA
    TB DB 'nhap ma sv: $'
    TB2 DB 10,13,'Xin chao $'
    TB3 Db 10,13,'Noi dung doc file: $'
    chuoi db 30,0,30 dup('$')
    noidung 251 dup ('$')
    tenfile db "12.txt",0      ;sua ten file
    handle dw ?
    len db ?
.CODE
    MOV AX,@DATA
    MOV DS,AX
    
    MAIN PROC
        ;TB bao nhap msv
        MOV AH,09h
        LEA DX,TB
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
        
        ;TB doc noi dung
        lea dx,tb3
        int 21h
        
        ;mo file
        mov ah,3dh
        mov al,2
        mov dx, offset tenfile
        int 21h
        mov handle,ax
        
        
        ;doc noi dung
        mov ah,3fh
        mov bx,handle
        lea dx,noidung
        mov cx,50
        int 21h
        
        ;dong tep tin
        mov ah,3eh
        int 21h
        
        ;in noi dung
        mov dx, offset noidung
        mov ah,09h
        int 21h

        
        MOV AH,4Ch
        INT 21H
                
    MAIN ENDP
   
    
END
