src=hello.S
obj=hello.o
elf=boot.elf
boot=boot.bin
asm=boot.asm

$(boot):$(hello.S)
	gcc -c $(src) -m32 -o $(obj)
	ld -m elf_i386 $(obj) -e start -Ttext 0x7c00 -o $(elf)
	objcopy -S -O binary -j .text $(elf) $(boot)
	objdump -S $(elf) > $(asm)

run:$(asm)
	qemu-system-i386 -fda $(boot)

clean:
	-rm -f $(obj) $(elf) $(boot) $(asm)
