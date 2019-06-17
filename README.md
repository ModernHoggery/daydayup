# daydayup #

## Make image ##

```
src=hello.S
obj=hello.o
elf=boot.elf
boot=boot.out
asm=boot.asm

$(boot):$(hello.S)
	gcc -c $(src) -m32 -o $(obj)
	ld -m elf_i386 $(obj) -e start -Ttext 0x7c00 -o $(elf)
	objcopy -S -O binary -j .text $(elf)  $(boot)
	objdump -S $(elf) > $(asm)

fat12:
	@dd if=/dev/zero of=$(boot) seek=1 count=2879 >> /dev/zero
	@ls -al $(boot)

run:$(asm)
	qemu -fda $(boot)

writeusb:fat12
	sudo dd if=$(boot) of=/dev/sdb
runusb:writeusb
	sudo qemu   -drive file=/dev/sdb,if=floppy
clean:
	-rm -f $(obj) $(elf) $(boot) $(asm)
```

In this Makefile, *hello.S* is the source code.
> gcc -c hello.S -o hello.o

According to the above command, we can get the *obj_file*. In fact, parameter *-c* work.
> ld

To link the *obj_file* and generate binary file as the format of ELF.
> objcopy

To trans the format of binary file, [for more](https://blog.csdn.net/linux12121/article/details/82932535).
> objdump

To disassemble, [for more](https://blog.csdn.net/q2519008/article/details/82349869). However, it's not important for us to known.