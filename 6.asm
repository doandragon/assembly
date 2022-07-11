include 'emu8086.inc'
.MODEL SMALL
.STACK 100H
.DATA
    TB1 DB 'nhap ma sv: $'
    TB2 DB 10,13,'Xin chao $'
    TB3 DB 10,13,'Nhap so can chuyen: $'
    TB4 Db 10,13,'oct to dec: $'
    TB5 DB 10,13,'oct to hex: $'
    n db ?
    tam db ?
    masv db 30,0,30 dup('$'),'$'
.CODE
    MOV AX,@DATA
    MOV DS,AX
    
    MAIN PROC
        ;THONG BAO 1
        MOV AH,09H
        LEA DX,TB1
        INT 21H
        
        ;NHAP CHUOI
        MOV DX,OFFSET MASV
        MOV AH,0AH
        INT 21H
        
        ;THONG BAO 2
        MOV DX,OFFSET TB2
        MOV AH,09H
        INT 21H
        
        ;IN MA SV
        LEA DX,MASV+2
        INT 21H
        
        ;THONG BAO 3
        MOV DX,OFFSET TB3
        INT 21H
        
        ;nhap so
        CALL SCAN_NUM
        MOV N,Cl
        mov tam,cl
        
        ;CHUYEN 10 QUA 2
        call nhi_phan
        
        ;chuyen 10 qua 16
        MOV DX,OFFSET TB5
        MOV AH,09H
        INT 21H
        XOR AX,AX
        MOV AL,N
        CALL printnum16
        
        MOV AH,4Ch
        INT 21H
                
    MAIN ENDP
    
    nhi_phan proc
        xor cx,cx
        xor dx,dx
        lap:
            mov ah,0
            mov al,tam
            mov bl,2         ;chia cho 2, phan du nam trong ah
            div bl
            mov tam,al
            
            xor dx,dx
            mov dl,ah
            push dx
            inc cl
            cmp al,0
            jne lap
            cmp al,0
            je in_tb
         in_tb:
            mov dx,offset tb4 
            mov ah,09h
            int 21h
         push_0:           ;neu chua du 16 bit thi tiep tuc day 0 vao stack
            cmp cl,16
            je  xuat
            push 0
            inc cl
            jmp push_0
         xuat:
            pop dx
            add dx,30h
            mov ah,02h
            int 21h
            loop xuat
            ret       
    nhi_phan endp
    
    printnum16 proc
        mov bx,16   ;khoi tao bl bang 16     
        mov cx,0    ;khoi tao bien dem  
        
        hexa: ;xay dung duoc stack
            div bl  ;lay so hien tai chia cho 16 
            push ax ;day gia tri ax vao ngan xep
            inc cx  ;tang bien dem them 1
            cmp al,0    ;neu thuong bang 0 thi ket thuc
            je ketqua  ;jum equal
            mov ah,0   ;clear ah va quay lai tiep tuc chia 
            jmp hexa  
            
        ketqua:    
        inkt:
            pop ax  ;lay tung gia tri o dinh ngan xep
            mov dl,ah   ;lay phan du chuyen vao dl
            
            cmp dl,10   ;10->A    
            je hex_a 
            cmp dl,11   ;11->B
            je hex_b
            cmp dl,12   ;12->C
            je hex_c
            cmp dl,13   ;13->D
            je hex_d
            cmp dl,14   ;14->E
            je hex_e
            cmp dl,15   ;15->F
            je hex_f 
            
            add dl,'0'  ;so + 0 = ky so
            jmp print  ;nhay den ham in de in so tu 0-9
            
            hex_a:  
                mov dl,'A'
                jmp print     
            hex_b:  
                mov dl,'B'
                jmp print
            hex_c:  
                mov dl,'C'
                jmp print
            hex_d: 
                mov dl,'D'
                jmp print
            hex_e:  
                mov dl,'E'
                jmp print  
            hex_f:  
                mov dl,'F' 
                jmp print 
         print: ;in 1 ky tu ra man hinh 
            mov ah,2
            int 21h        
        loop inkt
        ret ;return
    printnum16 endp
    
    DEFINE_SCAN_NUM
    
END
