.PHONY: all clean run debug

CC := /nix/store/s41zsndkfjciiwrdi4qjzxbfb6a9xqhi-gcc-wrapper-14-20241116/bin/gcc
AS := nasm
CFLAGS := -fno-stack-protector -fno-builtin -g
ASFLAGS := -f elf32

all: kernel.iso

run:
	 qemu-system-i386 kernel.iso

debug: kernel.iso
	 qemu-system-i386 -s -S kernel.iso

clean:
	rm -f *.o kernel kernel.iso
	rm -f Express/boot/kernel

%.o: src/%.c
	$(CC) $(CFLAGS) -c $< -o $@

%s.o: src/%.s
	$(AS) $(ASFLAGS) $< -o $@

boot.o: src/boot.s
	$(AS) $(ASFLAGS) src/boot.s -o boot.o

kernel: kernel.o vga.o boot.o gdt.o gdts.o util.o idt.o idts.o timer.o stdio.o keyboard.o
	ld -m elf_i386 -T linker.ld -o $@ $^

kernel.iso: kernel Express/boot/grub
	cp kernel Express/boot/kernel
	grub-mkrescue -o kernel.iso Express/
