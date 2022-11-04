IDEAL
MODEL small
STACK 100h
DATASEG
    x dw 160
    y dw 100
    color db 4

    message db 'Hello World$'
CODESEG
    ; procs ;
    proc CreatePlatform
        mov bx, 10
        CreatePlatformY:
            mov cx, 50
            CreatePlatformX:
                mov bh,0h
                mov dx,[y]
                mov al,[color]
                mov ah,0ch
                int 10h
            loop CreatePlatformX
        inc [y]
        dec bx
        cmp bx, 0
        jne CreatePlatformY
        ret
    endp CreatePlatform

    start:
        mov ax, @data
        mov ds, ax
        ; Graphic mode
        mov ax, 13h
        int 10h

        ; creating a platform ;
        call CreatePlatform
        ; Wait for key press
        mov ah, 00h
        int 16h

        ; Return to text mode
        mov ah, 0
        mov al, 2
        int 10h
    exit :
    mov ax, 4C00h
    int 21h
END start