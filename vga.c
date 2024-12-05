#include "vga.h"

uint16_t column = 0;
uint16_t line = 0;
uint16_t* const vga = (uint16_t* const) 0xB8000;
const uint16_t defaultColor = (COLOR8_BLACK << 8) | (COLOR8_LIGHT_GREY << 12);
uint16_t currentColor = defaultColor;

void Reset() {
	line = 0;
	column = 0;
	currentColor = defaultColor;

	for(uint16_t y = 0; y < height; y++) {
			for(uint16_t x = 0; y < width; x++) {
					vga[y * width + x] = ' ' | defaultColor;
			}
	}
}

void newLine() {
	if(line < height  - 1) {
		line++;
		column = 0;
	}
	else {
		scrollUp();
	}
}

void scrollUp(){
	for(uint16_t y = 0; y < height; y++){
		for(uint16_t x = 0; x < width; x++){
			vga[(y-1) * width + x] = vga[y * width + x];	
		}
	}

	
}
