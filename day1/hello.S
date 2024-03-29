.global start
.code16
start:

    jmp entry

entry:
    mov $0,%ax
    mov %ax,%ds
    mov %ax,%es
    mov %ax,%ss
    mov $0x7c00,%sp

    mov $msg,%si
    call puts
    mov $my,%si
    call puts

puts:
  movb (%si),%al
  add $1,%si
  cmp $0,%al
  je finish
  movb $0x0e,%ah
  movw $15,%bx
  int $0x10
  jmp puts

finish:
  hlt
  ret

msg: .asciz "\r\nmy bootloader is running"
my: .asciz "\r\nwelcome to YuanOS"

.org 510
.word 0xaa55
