.code16
.section ".bstext", "ax"
.global bootsect_start

bootsect_start:
    movw    %cs, %ax
    movw    %ax, %ds
    movw    %ax, %es
    movw    %ax, %ss
    movw    $0x7c00, %sp


    # clear screen
    movw    $0x0600, %ax
    movw    $0x0700, %bx
    movw    $0x0000, %cx
    movw    $0x184f, %dx
    int     $0x10

    # set cursor
    movb    $0x02, %ah
    movb    $0x00, %bh
    movw    $0x0000, %dx
    int     $0x10

    # print message
    movw    $mbr_msg_addr, %ax 
    movw    %ax, %bp
    movw    $mbr_msg_len, %cx
    movw    $0x1301, %ax
    movb    $0x02, %bl
    int     $0x10

bs_die:
    # Allow the user to press a key, then reboot
    xorw    %ax, %ax
    int     $0x16
    int     $0x19
    # int 0x19 should never return.  In case it does anyway,
    # invoke the BIOS reset code...
    ljmp    $0xf000, $0xfff0

mbr_msg:
    .ascii  "Runing MBR...\r\n"

mbr_msg_len     = . - mbr_msg
mbr_msg_addr    = mbr_msg + 0x7c00

    .byte   0

    # the end of mbr
    .org 510
    .word 0xAA55