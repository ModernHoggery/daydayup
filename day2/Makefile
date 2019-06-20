src=boot.S
obj=boot.o
elf=boot.elf
boot=boot.bin
asm=boot.asm
img=YuanOS.img

boot:$(obj)
	gcc -c $(src) -m32 -o $(obj)
	ld -o $(elf) $(obj) -Tboot.ld
	objcopy -S -O binary $(elf) $(boot)
	objdump -S $(elf) > $(asm)

image:boot
	dd if=$(boot) of=$(img) bs=512 count=1

run:image
	qemu-system-i386 $(img)

clean:
	-rm -f $(obj) $(elf) $(boot) $(asm) $(img)
