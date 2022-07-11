.model small
.stack 100h
.data
     tb1 db "Nhap ma sv: $"
     tb2 db 10,13,"Ban vua nhap: $"
     tencu dw "12.txt",0
     tenmoi dw "moi.txt",0
     handle dw ?
     chuoi db 30 dup('$')
.code
    main proc
        mov ax,@data
        mov ds,ax
        mov es, ax

        
        ;TB nhap ma sv
        mov ah,09h
        lea dx,tb1
        int 21h
        
        ;nhap ma sv
        mov ah,0ah
        lea dx,chuoi
        int 21h
        
        ;TB 2
        mov ah,09h
        lea dx,tb2
        int 21h
        
        ;in ma sv
        lea dx,chuoi[2]
        int 21h
        
        ;doi ten file
        mov ah,56h
        lea dx,tencu
        lea di,tenmoi
        int 21h
        
        mov ah,4ch
        int 21h
    main endp

end