#include "vga.h"
#include "stdint.h"

void kmain(void);

void kmain(void) {



	//NOTE this works
	//uint16_t* vga = (uint16_t*) 0xb8000;
	//uint8_t c = (0x00 << 4) | 0x7;

	const char* msg = "Welcome to Express";
	//NOTE works 
	//for(uint16_t i = 0; msg[i] != '\0'; i++) {
	//	vga[i] = (c << 8) | msg[i];
	//}


	print(msg);
	print("\ntest\ttab");
	//char* msg = "Welcome to ExpressOS";
		
	//uint8_t color = (COLOR8_LIGHT_GREY << 4) | (COLOR8_BLACK);

	//for(uint16_t i =0; msg[i] != '\0'; i++) {
	//	vga[i] = ((uint16_t) color << 8) | msg[i];
	//}

	//Reset();
	//print("hello world \r\n");
}
