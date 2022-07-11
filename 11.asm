include 'emu8086.inc'
.MODEL SMALL
.STACK 100H
.DATA
    TB DB 'nhap ma sv: $'
    TB2 DB 10,13,'Xin chao $'
    TB3 Db 10,13,'So luong ky tu co trong chuoi: $'
    n db ?
    chuoi db 30,0,30 dup('$'),'$'
.CODE
    MOV AX,@DATA
    MOV DS,AX
    
    MAIN PROC
        ; in thong bao nhap ki tu
        MOV AH,09h
        LEA DX,TB
        INT 21H
        
        ;nhap chuoi ki tu
        mov dx, offset chuoi
		mov ah, 0ah
		int 21h
        
        
        ;in chuoi xin chao + ki tu
        MOV AH,09h
        LEA DX,TB2
        INT 21H

        
        lea dx,[chuoi+2]
        int 21h
        
        
        xor cx,cx
		mov cl,[chuoi+1]
		mov n,cl
		
		;in so
		MOV DX,OFFSET TB3
		MOV AH,09H       
	    INT 21H
		
		
		MOV AH,0
		mov al,n
		CALL PRINT_NUM_UNS
        
        MOV AH,4Ch
        INT 21H
                
    MAIN ENDP
    DEFINE_PRINT_NUM_UNS
    
END