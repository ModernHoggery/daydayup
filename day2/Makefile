src=hello.S
obj=hello.o
elf=boot.elf
boot=boot.bin
asm=boot.asm
img=YuanOS.img

boot:$(obj)
	gcc -c $(src) -m32 -o $(obj)
	ld -m elf_i386 $(obj) -e start -Ttext 0x7c00 -o $(elf)
	objcopy -S -O binary -j .text $(elf) $(boot)
	objdump -S $(elf) > $(asm)

image:boot
	dd if=$(boot) of=$(img) bs=512 count=1

run:image
	qemu-system-i386 $(img)

clean:
	-rm -f $(obj) $(elf) $(boot) $(asm) $(img)
