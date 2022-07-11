.model small
.stack 100h
.data
    TB1 db "Nhap chuoi ky tu HOA: $"
    tb2 db 10,13,"Chuoi vua nhap la: $"
    TB3 db 10,13,"Chuoi in thuong: $"
    chuoi db 30,0,30 dup('$')
.code
    main proc
        mov ax,@data
        mov ds,ax
        
        ;IN THONG BAO NHAP CHUOI
        mov ah,09h
        lea dx,tb1
        int 21h
        
        ;NHAP CHUOI
        mov ah,0Ah
        mov dx, offset chuoi
        int 21h
        
        ;IN THONG BAO NHAP CHUOI
        mov ah,09h
        lea dx,tb2
        int 21h
        
        ;IN CHUOI NHAP DC
        lea dx, [chuoi+2]
        mov ah,09h
        int 21h
        
        call thuong
        
        mov ah,4ch
        int 21h 
    main endp
    
    thuong proc
        ;IN THONG BAO 
        mov ah,09h
        lea dx,tb3
        int 21h
        
        xor cx,cx
        mov cl,[chuoi+1]
        lea si,chuoi+2
        
        lap:
        mov dl,[si]
        cmp dl, 20h
        je  xuat
        cmp dl, 5bh
        jG  xuat
        cmp dl, 5bh
        jL  cong
        cong:
        add dl,20h
        xuat:
        mov dh,0
        inc si
        mov ah,02h
        int 21h
        loop lap
        RET
    thuong endp

end