.PHONY: clean

all: image

clean:
	rm -f *.o kernel.iso

kernel.o: kernel.c
	gcc -m32 -fno-stack-protector -fno-builtin -c kernel.c -o kernel.o

vga.o: vga.c
	gcc -m32 -fno-stack-protector -fno-builtin -c vga.c -o vga.o

boot.o: boot.s
	nasm -f elf32 boot.s -o boot.o

image: kernel.o vga.o boot.o
	ld -m elf_i386 -T linker.ld -o kernel boot.o kernel.o vga.o
	mv kernel Express/boot/kernel
	grub-mkrescue -o kernel.iso Express/
