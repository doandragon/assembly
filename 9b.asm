.model small
.stack 100
.data
     TB DB 'nhap ma sv: $'
     TB2 DB 10,13,'Xin chao $'
     TB3 DB 10,13,'Nhap chuoi: $'
     chuoi db 30 dup('$') 
     str DB 50 dup('$') ;str gom 50 bytes chua 50 gia tri khoi dau 
     tb1 db 10,13,'Chuoi da duoc dao nguoc: $' 
.code
    main proc
        mov ax,@data
        mov ds,ax  ;khoi tao thanh ghi ds
        
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
        
        ;THONG BAO 3
        MOV DX,OFFSET TB3
        MOV AH,09H
        INT 21H
        
        ;nhap xau ki tu 
        lea dx,str
        mov ah,10;0Ah
        int 21h  
        
        ;in chuoi tb2 ra man hinh
        lea dx, tb1
        mov ah,9
        int 21h
        
        ;THUAT TOAN
        xor cx,cx
        mov cl,[str + 1] 
        lea si,[str + 2] 
        Lap:
            push [si]
            inc si   
            loop Lap
        
        mov cl, [str + 1]        
        Lap2: 
            pop dx    
            mov ah,2 
            int 21h
            Loop Lap2
        
        ; tro ve DOS dùng hàm 4 CH cua INT 21H
		MOV AH, 4CH
		INT 21H
    main endp
end  