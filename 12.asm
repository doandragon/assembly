;include 'emu8086.inc'
.MODEL SMALL
.STACK 100H
.DATA
    TB DB 'nhap ma sv: $'
    TB2 DB 10,13,'Xin chao $'
    TB3 Db 10,13,'Nhap ten file: $'
    TB4 Db 10,13,'Nhap noi dung can ghi: $'
    chuoi db 30,0,30 dup('$')
    noidung db 30,0,30 dup('$')
    tenfile db 30 dup('$')
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
        
        ;TB 
        lea dx,tb3
        int 21h
        
        ;nhap ten file
        mov ah,0ah
        lea dx,tenfile
        int 21h
        
        ;dua 0 vao cuoi ten file
        xor bx,bx
        mov bl,tenfile[1]
        mov tenfile[bx+2],0
        mov dx, offset tenfile[2]
        
        ;TB nhap noi dung
        MOV AH,09h
        LEA DX,TB4
        INT 21H
        
        ;nhap noi dung
        mov ah,0ah
        lea dx,noidung
        int 21h
        
        ;tao moi file 
        lea dx,[tenfile+2]
        mov cx,0
        mov ah,3ch
        int 21h
        mov handle,ax
        
        ;ghi noi dung
        xor cx,cx
        mov bx, handle
        mov cl,[noidung+1]
        lea dx, noidung+2
        mov ah,40h
        int 21h
   
        MOV AH,4Ch
        INT 21H
                
    MAIN ENDP
END
