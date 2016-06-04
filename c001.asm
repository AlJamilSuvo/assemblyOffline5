.model small

vline Macro x     
    Local l1
    mov bx,98
    add bx,x
    l1:
    int 10h
    inc cx
    dec bx
    cmp bx,0
    jg l1     
EndM

hline Macro x
    Local l2
    mov bx,98
    add bx,x
    l2:
    int 10h
    inc dx
    dec bx
    cmp bx,0
    jg l2
EndM 


print Macro 
    mov ax,12
    mul cnx   
    add ax,12
    mov tlx,ax
    mov ax,6
    mul cny
    add ax,6
    mov tly,ax
    mov ax,100h
    mul tly
    mov dx,ax
    add dx,tlx
    mov ah,2
    xor bh,bh 
    int 10h
    mov ah,09 
    mov cx,1   
    
    
   
    
endM

    




.data
cnx dw 0
cny dw 0
tnx dw 0
tny dw 0
tc db 0 
cp db 0 


tlx dw 0
tly dw 0
dat db 9 dup(0)  
tes db 0  
winer dw 0

fl db 0


.stack 100h
.code
main proc
    mov ax,@data
    mov ds,ax
    mov ax,12h 
    mov bh,0 
    
    int 10h  
    
    mov dx,0102h
    mov ah,2
    xor bh,bh 
    int 10h
    mov ah,09 
    mov cx,1
    
  
    mov bx,15
    mov al,'P'
    int 10h  

    mov cp,1
    
    render: 
    xor cx,cx
    mov ah,2
    xor bx,bx
    xor dx,dx
    int 10h 
    
   
    
     
    
    mov tc,4
    
    mov dx,0104h
    mov ah,2
    xor bh,bh 
    int 10h
    mov ah,09 
    mov cx,1
    
  
    mov bl,tc
    mov al,cp
    add al,'0'
    int 10h
    
    
    
    
    
    
    xor bx,bx
    xor cx,cx
    l1:
    xor cx,cx
    l2:
    mov tnx,cx
    mov tny,bx
    call outerbox
    mov tnx,cx
    mov tny,bx
    call inerbox
    inc cx
    cmp cx,3
    jl l2  
    inc bx 
    cmp bx,3
    jl l1 
    
    mov cx,cnx
    mov dx,cny
    mov tnx,cx
    mov tny,dx
    mov tc,15
    call inerbox
    
    
    call logic
    
    
    
    
    
    xor cx,cx
    mov ah,0
    int 16h
    cmp ah,72
    je up
    cmp ah,80
    je down
    cmp ah,75
    je left
    cmp ah,77
    je right
    
    cmp ah,2Dh
    je p1
    
    cmp ah,18h
    je p2
    
    cmp ah,10h
    je ex
    
    jmp render  
    
    
    
     up:
    cmp cny,0
    jne l3
    mov cny,3
    l3:
    dec cny
    jmp render
    
    down:
    cmp cny,2
    jne l4
    mov cny,-1
    l4:
    inc cny
    jmp render
    left: 
    cmp cnx,0
    jne l5
    mov cnx,3
    l5:
    dec cnx
    jmp render
    right:
    cmp cnx,2
    jne l6
    mov cnx,-1
    l6:
    inc cnx
    jmp render 
    
    
    p1:
    call p1_input  
    
    jmp render
    
    p2: 
    call p2_input
    jmp render
    
    ex:
    
    mov ah,4ch
    int 21h
    
    
   
    
    main endp

outerbox proc
    push bx
    push cx
    mov ax,100
    mul tnx
    mov tnx,ax
    mov ax,100
    mul tny
    mov tny,ax
    add tnx,50
    add tny,50
    mov al,tc
    mov ah,0ch
    mov cx,tnx
    mov dx,tny
    vline 2   
    mov cx,tnx
    mov dx,tny
    hline 2
    mov cx,tnx
    add cx,100
    mov dx,tny
    hline 2
    mov cx,tnx
    mov dx,tny
    add dx,100
    vline 2
    pop cx
    pop bx 
    ret
    outerbox endp


inerbox proc 
    push bx
    push cx
    mov ax,100
    mul tnx
    mov tnx,ax
    mov ax,100
    mul tny
    mov tny,ax
    add tnx,51
    add tny,51
    mov al,tc
    mov ah,0ch
    mov cx,tnx
    mov dx,tny
    vline 0   
    mov cx,tnx
    mov dx,tny
    hline 0
    mov cx,tnx
    add cx,98
    mov dx,tny
    hline 0
    mov cx,tnx
    mov dx,tny
    add dx,98
    vline 0 
    pop cx
    pop bx 
    ret
    inerbox endp


p1_input proc 
    
    
    cmp cp,1
    jne return1
    mov ax,3
    mul cny
    mov bx,ax
    add bx,cnx
    
    
    
    mov al,dat[bx]
    cmp al,0
    jne return1 
    mov dat[bx],1
    mov tes,bl
    mov ax,12
    mul cnx   
    add ax,12
    mov tlx,ax
    mov ax,6
    mul cny
    add ax,6
    mov tly,ax
    mov ax,100h
    mul tly
    mov dx,ax
    add dx,tlx
    mov ah,2
    xor bh,bh 
    int 10h
    mov ah,09 
    mov cx,1
    
  
    mov bx,1
    mov al,'X'
    int 10h
     
    mov cp,2
    
    
    return1 :
    ret
 
    p1_input endp

p2_input proc 
    
    
    cmp cp,2
    jne return2
    mov ax,3
    mul cny
    mov bx,ax
    add bx,cnx
    
    
    
    mov al,dat[bx]
    cmp al,0
    jne return2 
    mov dat[bx],-1
    mov tes,bl
    mov ax,12
    mul cnx   
    add ax,12
    mov tlx,ax
    mov ax,6
    mul cny
    add ax,6
    mov tly,ax
    mov ax,100h
    mul tly
    mov dx,ax
    add dx,tlx
    mov ah,2
    xor bh,bh 
    int 10h
    mov ah,09 
    mov cx,1
    
  
    mov bx,14
    mov al,'O'                     
    int 10h
     
    mov cp,1
    
    
    return2 :
    ret
 
    
    
    p2_input endp 


logic proc  
    mov fl,1  
    xor cx,cx
    lo1:
    push cx
    mov tnx,cx
    xor cx,cx
    xor dx,dx
    lo2:  
    push dx
    mov tny,cx
    mov ax,3
    mul tny
    mov bx,ax
    add bx,tnx
    pop dx 
    add dl,dat[bx] 
    inc cx
    cmp cx,3
    jl lo2
    cmp dl,3
    je p11w
    cmp dl,-3
    je p22w
    pop cx
    inc cx
    cmp cx,3
    jl lo1 
    xor cx,cx 
    mov fl,2
    jmp lo3
    
    p11w:jmp p1w
    p22w:jmp p2w
    
    
    
    lo3:
    push cx
    mov tny,cx
    xor cx,cx
    xor dx,dx
    lo4:
    push dx
    mov tnx,cx
    mov ax,3
    mul tny
    mov bx,ax
    add bx,tnx 
    pop dx
    add dl,dat[bx] 
    inc cx
    cmp cx,3
    jl lo4
    cmp dl,3
    je p1w
    cmp dl,-3
    je p2w
    pop cx
    inc cx
    cmp cx,3
    jl lo3
    
    
    mov fl,3
    xor dx,dx
    add dl,[dat]  
    add dl,[dat+4]
    add dl,[dat+8]
    
    cmp dl,3
    je p1w
    cmp dl,-3
    je p2w
    
    
    mov fl,4
    xor dx,dx
    add dl,[dat+2]  
    add dl,[dat+4]
    add dl,[dat+6]
    
    cmp dl,3
    je p1w
    cmp dl,-3
    je p2w 
    
    
    
    xor bx,bx
    lo5:
    mov al,dat[bx]
    cmp al,0
    je rt
    inc bx
    cmp bx,9
    jl lo5
    
    draw: call mat_drw
    
    p1w: call p1_win
  
    
    p2w: call p2_win 
    
        
    rt:
    ret
    logic endp 
    
p1_win proc  
    
      
    mov dx,1702h
    mov ah,2
    xor bh,bh 
    int 10h
    mov ah,09 
    mov cx,1
    
  
    mov bx,15
    mov al,'P'
    int 10h
    
    
    mov dx,1704h
    mov ah,2
    xor bh,bh 
    int 10h
    mov ah,09 
    mov cx,1
    
  
    mov bx,15
    mov al,'1'
    int 10h
    
    
    mov dx,1706h
    mov ah,2
    xor bh,bh 
    int 10h
    mov ah,09 
    mov cx,1
    
  
    mov bx,15
    mov al,'W'
    int 10h
    
    call drw_fl
    
      
    mov ah,4ch
    int 21h
    
    
    
    
    
    
    
    p1_win endp 



p2_win proc 
    
    mov dx,1702h
    mov ah,2
    xor bh,bh 
    int 10h
    mov ah,09 
    mov cx,1
    
  
    mov bx,15
    mov al,'P'
    int 10h
    
    
    mov dx,1704h
    mov ah,2
    xor bh,bh 
    int 10h
    mov ah,09 
    mov cx,1
    
  
    mov bx,15
    mov al,'2'
    int 10h
    
    
    mov dx,1706h
    mov ah,2
    xor bh,bh 
    int 10h
    mov ah,09 
    mov cx,1
    
  
    mov bx,15
    mov al,'W'
    int 10h
    
    call drw_fl
    
    
    
      
    mov ah,4ch
    int 21h

    
    
    p2_win endp 




mat_drw proc  
    
    mov dx,1702h
    mov ah,2
    xor bh,bh 
    int 10h
    mov ah,09 
    mov cx,1
    
  
    mov bx,15
    mov al,cp
    add al,'M'
    int 10h
    
    
    mov dx,1704h
    mov ah,2
    xor bh,bh 
    int 10h
    mov ah,09 
    mov cx,1
    
  
    mov bx,15
    mov al,'D'
    int 10h 
    
    
    
 
    mov ah,4ch
    int 21h

    
    mat_drw endp  


drw_fl proc
    mov al,8
    mov ah,0ch
    
    cmp fl,1
    je hl
    cmp fl,2
    je vl
    cmp fl,3
    je xl 
    
    mov cx,75
    mov dx,325
    lin1:int 10h
    inc cx
    dec dx
    cmp cx,325
    jl lin1
    jmp rnt
    
    
    xl:
    mov cx,75
    mov dx,75
    lin2:int 10h
    inc cx
    inc dx
    cmp cx,325
    jl lin2
    jmp rnt
    
    
    hl:
    mov ax,100
    mul cnx
    add ax,100
    mov cx,ax 
    mov al,8
    mov ah,0ch
    mov dx,75
    lin3:int 10h
    inc dx
    cmp dx,325
    jl lin3
    jmp rnt
    
    
    vl:
    mov ax,100
    mul cny
    
    add ax,100
    mov dx,ax
    mov al,8
    mov ah,0ch
    mov cx,75
    lin4:int 10h
    inc cx
    cmp cx,325
    jl lin4
    jmp rnt
    
    rnt:
    ret
    
    drw_fl endp

    



end main