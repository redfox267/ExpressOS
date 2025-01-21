#include "gdt.h"
#include "idt.h"
#include "stdint.h"
#include "vga.h"

void kmain(void);

void kmain(void) {
    initGdt();
    println("This should print if GDT initializes");

    initIdt();
    println("This should print if IDT initializes");
}
