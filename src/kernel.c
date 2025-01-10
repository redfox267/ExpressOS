#include "vga.h"
#include "stdint.h"
#include "gdt.h"

void kmain(void);

void kmain(void) {
	initGdt();
	println("This should print if GDT initializes");
	//uint16_t* vga = (uint16_t*) 0xb8000;
	//uint8_t c = (0x00 << 4) | 0x7;


}
