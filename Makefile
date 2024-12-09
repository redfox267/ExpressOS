all: clean kernel boot image

clean: 
	rm -rf *.o

kernel:
	gcc -m32 -fno-stack-protector -fno-builtin -c kernel.c -o kernel.o
	gcc -m32 -fno-stack-protector -fno-builtin -c vga.c -o vga.o

boot:
	nasm -f elf32 boot.s -o boot.o

image:
	ld -m elf_i386 -T linker.ld -o kernel boot.o kernel.o vga.o
	mv kernel Express/boot/kernel
	grub-mkrescue -o kernel.iso Express/
	rm *.o
