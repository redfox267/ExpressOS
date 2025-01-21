#include "util.h"
#include "stdint.h"

void memset(void *dest, char val, uint32_t count){
  char *temp = (char*) dest;
  for(; count!=0; count--) {
    *temp++ = val;
  }
}

// outputs a byte of data to an IO port that hooked up to a PIC
// sends data directly to PIC
// value sent is for the initalization of those ports
void outPortB(uint16_t port, uint8_t value) {
  asm volatile (
    "outb %1, %0" : : "dN" (port), "a" (value)
  );
}
