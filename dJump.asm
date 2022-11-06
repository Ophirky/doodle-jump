IDEAL
MODEL small
STACK 100h
DATASEG
    y dw 100
    color db 4

    PLATFORM_HEIGHT equ 10
    PLATFORM_WIDTH equ 50
    
CODESEG
    ; procs ;
    proc CreatePlatform
        push bp
        mov bp, sp
        sub sp,4

        mov [y], 100 ; reseting the y var

        ; in cx, we have the right x coordinate
        mov bx, PLATFORM_HEIGHT
        CreatePlatformY:
            mov cx, si ; si is user x
            mov di, cx  ; di is base of platform
            sub di, PLATFORM_WIDTH
            CreatePlatformX:
                mov bh,0h
                mov dx, [y]
                mov al, [color]
                mov ah,0ch
                int 10h
            dec cx
            cmp cx, di
            jne CreatePlatformX

        inc [y]
        dec bx
        cmp bx, 0
        jne CreatePlatformY

        add sp, 2
        mov sp,bp
        pop bp
        ret

    endp CreatePlatform

    start:
        mov ax, @data
        mov ds, ax
        ; Graphic mode
        mov ax, 13h
        int 10h

        ; creating a platform ;
        ;mov si, 319
        ;call CreatePlatform

        ;mov si, 50
        ;call CreatePlatform

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