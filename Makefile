.PHONY: clean

CC := gcc
AS := nasm
CFLAGS := -m32 -fno-stack-protector -fno-builtin
ASFLAGS := -f elf32

all: kernel.iso

clean:
	rm -f *.o kernel kernel.iso
	rm -f Express/boot/kernel

kernel.o: src/kernel.c
	$(CC) $(CFLAGS) -c src/kernel.c -o kernel.o

gdt.o: src/gdt.c
	$(CC) $(CFLAGS) -c src/gdt.c -o gdt.o

vga.o: src/vga.c
	$(CC) $(CFLAGS) -c src/vga.c -o vga.o

boot.o: src/boot.s
	$(AS) $(ASFLAGS) src/boot.s -o boot.o

gdts.o: src/gdt.s
	$(AS) $(ASFLAGS) src/gdt.s -o gdts.o

util.o: src/util.c
	$(CC) $(CFLAGS) -c src/util.c -o util.o

idt.o: src/idt.c
	$(CC) $(CFLAGS) -c src/idt.c -o idt.o

idts.o: src/idt.s
	$(AS) $(ASFLAGS) src/idt.s -o idts.o


kernel: kernel.o vga.o boot.o gdt.o gdts.o util.o idt.o idts.o
	ld -m elf_i386 -T linker.ld -o kernel boot.o kernel.o vga.o gdt.o gdts.o util.o idt.o idts.o

kernel.iso: kernel Express/boot/grub
	cp kernel Express/boot/kernel
	grub-mkrescue -o kernel.iso Express/
