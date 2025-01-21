#include "vga.h"
#include "stdint.h"
#include "gdt.h"
#include "idt.h"

void kmain(void);

void kmain(void) {
	initGdt();
	println("This should print if GDT initializes");

	initIdt();
	println("This should print if IDT initializes");

}
