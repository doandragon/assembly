INCLUDE "EMU8086.INC"
.MODEL SMALL
.STACK 100H
.DATA
    TB1 DB "Nhap ma sv: $"
    TB2 DB 10,13,"Ma sv vua nhap: $"
    TB3 DB 10,13,"Nhap chuoi so: $"
    TB4 DB 10,13,"So phan tu am: $"
    TB5 DB 10,13,"So phan tu duong: $"
    MASV DB 30 DUP("$")
    CHUOISO DB 30 DUP("$")
    ptu_am db ?
.CODE
 
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX        
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
        ;NHAP CHUOI SO, SO CACH NHAU BOI PHIM SPACE
        MOV DX,OFFSET CHUOISO
        MOV AH,0AH
        INT 21H        
        ;THONG BAO 4
        MOV DX, OFFSET TB4
        MOV AH,09H
        INT 21H        
        ;DEM SO AM
        CALL DEM_SO_AM
        XOR AX,AX
        MOV AX,BX
        MOV ptu_am,BL
        CALL PRINT_NUM_UNS        
        ;THONG BAO 5
        MOV DX, OFFSET TB5
        MOV AH,09H
        INT 21H        
        ;DEM SO DUONG
        CALL DEM_SO
        XOR AX,AX
        MOV AX,BX
        SUB AL,ptu_am
        CALL PRINT_NUM_UNS        
        MOV AH,4CH
        INT 21H
    MAIN ENDP
    
    DEM_SO_AM PROC
        XOR CX,CX
        XOR BX,BX
        MOV CL,CHUOISO[1]
        LEA SI,CHUOISO+2
        LAP:
        MOV DX,[SI]
        INC SI
        CMP DL,2DH
        JE  TANG
        LOOP LAP
        RET
        TANG:
        INC BX
        JMP LAP  
    DEM_SO_AM ENDP
    
    DEM_SO PROC
        XOR CX,CX
        XOR BX,BX
        MOV CL,CHUOISO[1]
        LEA SI,CHUOISO+2
        LAP1:
        MOV DX,[SI]
        INC SI
        CMP DL,20H
        JE  TANG1
        LOOP LAP1
        INC BX
        RET
        TANG1:
        INC BX
        JMP LAP1    
    DEM_SO ENDP
    
    DEFINE_PRINT_NUM_UNS
END