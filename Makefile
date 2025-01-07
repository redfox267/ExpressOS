.PHONY: clean

all: image

clean:
	rm -f *.o kernel.iso

kernel.o: src/kernel.c
	gcc -m32 -fno-stack-protector -fno-builtin -c src/kernel.c -o kernel.o

gdt.o: src/gdt.c
	gcc -m32 -fno-stack-protector -fno-builtin -c src/gdt.c -o gdt.o

vga.o: src/vga.c
	gcc -m32 -fno-stack-protector -fno-builtin -c src/vga.c -o vga.o

boot.o: src/boot.s src/gdt.s
	nasm -f elf32 src/boot.s -o boot.o
	nasm -f elf32 src/gdt.s -o gdts.o

image: kernel.o vga.o boot.o gdt.o 
	ld -m elf_i386 -T linker.ld -o kernel boot.o kernel.o vga.o gdt.o gdts.o
	mv kernel Express/boot/kernel
	grub-mkrescue -o kernel.iso Express/
	rm *.o
