.model small
.stack 100h
.data
 tb1 db "nhap vao so n = $" 
 tb2 db 10,13, "n! = $"
 x dw ?   
 y dw ?
 z dw ?

.code
main proc
    mov ax,@data
    mov ds,ax
     
  ; nhap so thu n 
    ; AH,1 cho nhap 1 ky tu; AH,2 in ra 1 ky tu; AH,9 in ra 1 chuoi; AH,4 ket thuc chuong trinh
    mov ah,9
    lea dx, tb1
    int 21h ; chi in ra dx vs dl    
    call nhap_so ; goi ham
    ;luu vao z
    mov ax,x
    mov z,ax   
    
  ; tinh giai thua 
    mov ah,9
    lea dx, tb2
    int 21h
    
    mov bx,z
    mov ax,1
    giaithua:
      mul bx ; ax.bx
      dec bx ; tuong tu i-- ( bx - 1) ; de z.(z-1).(z-2)... .1
      cmp bx,0 
      je xong ; neu bx = 0 thi nhay vao day
      jmp giaithua ; con khong thi vao day
      
     xong:
       mov x,ax
       call print
       
     mov ah,4
     int  21h     
main endp
; dung de code ham con

; nhap so 
nhap_so proc
    mov x,0
    mov y,0
    mov bx,10
        nhap:
            mov ah,1
            int 21h
            cmp al,13 ; kt xem al co phai enter khong de biet da nhap xong
            je nhapxong ; nhay neu al = 10 
            sub al,30h ; neu k bang thi al - 30h (de ep kieu), ep ve so
            xor ah,ah ; cho ah ve 0 (xoa ah
            mov y,ax ;gan ax =y
            mov ax,x
            mul bx ; mac dinh hieu la ax mul bx
            ; div bx thi hieu la ax : bx ( neu chia 16 bit chia dc bao nhieu luu vao ax du luu vao dx; chia 8 bit thi kq luu vao al du luu vao ah)
            add ax,y
            mov x,ax
            jmp nhap ; nhay khong can dieu kien
            
        nhapxong:
            ret ; return 
nhap_so endp
; ham hien thi
print proc 
    mov ax,x
    mov bx,10
    mov cx,0
         chia: 
            mov dx,0
            div bx
            push dx ; cho dx vào ngan x?p
            inc cx ; dem so chu so vd 123 co 3 chu so giong i++
            cmp ax,0
            je hienthi ; neu ax = 0
            jmp chia ; con khong thi
            
          hienthi:
           pop dx ; xoa bo phan tu dau tien o dau ngan xep
            
           add dl,30h ; ep len ascii , tru la dua ve dang so
           mov ah,2
           int 21h
           dec cx ; giong i--
           cmp cx,0
           jne hienthi ; nhay neu cx khong bang 0
           ret ; 

print endp           


end main