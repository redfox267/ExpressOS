#include "vga.h"
#include "gdt.h"
#include "idt.h"
#include "timer.h"
#include "keyboard.h"

void kmain(void);

void kmain(void) {
	initGdt();
	initIdt();

	initTimer();
	for(;;);
}

