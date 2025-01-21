.PHONY: all clean

CC := gcc
AS := nasm
CFLAGS := -m32 -fno-stack-protector -fno-builtin
ASFLAGS := -f elf32

all: kernel.iso

clean:
	rm -f *.o kernel kernel.iso
	rm -f Express/boot/kernel

%.o: src/%.c
	$(CC) $(CFLAGS) -c $< -o $@

%s.o: src/%.s
	$(AS) $(ASFLAGS) $< -o $@

boot.o: src/boot.s
	$(AS) $(ASFLAGS) src/boot.s -o boot.o

kernel: kernel.o vga.o boot.o gdt.o gdts.o util.o idt.o idts.o
	ld -m elf_i386 -T linker.ld -o kernel boot.o kernel.o vga.o gdt.o gdts.o util.o idt.o idts.o

kernel.iso: kernel Express/boot/grub
	cp kernel Express/boot/kernel
	grub-mkrescue -o kernel.iso Express/
