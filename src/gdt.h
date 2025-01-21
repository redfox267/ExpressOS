#include "stdint.h"

// limit is the upper limit of the segment (defined by a 20 bit integer), base
// is the starting point of the segment Access is the ring level (0 : highest 3
// : lowest) flags define whether the segment is a "code segment" or a "data
// segment"

/* Access bit definitions (A : B, where A is a given attribute and B is a bit):
P : 7 Refers to a valid segment, if it is not on then the segment will fail
DPL : 6 & 5 Descriptor level field, designates ring (0-3)
S : 4 Type bit, 1 = code or data segment 0 = system segment
E : 3 Executable bit, defines if the segment can be executed upon
DC : 2 Direction bit (for data selectors), 1 segment grows down, 0 it grows down
       Conforming bit (for code selectors), 1 this segment can be executed from
an equal or lower (better) privelege level, 2

RW : 1 For code segments determines if read access is allowed (1). For data
segments determines if writing is allowed (1) A : 0 Set to 1 if the segment is
accessed


*/

// An entry to the global descriptor table
struct gdt_entry_struct {
    uint16_t limit;
    uint16_t base_low;
    uint8_t base_mid;
    uint8_t access;
    uint8_t flags;
    uint8_t base_high;
} __attribute__((packed)); //"packed" makes it so that the memory is "tight", no
                           // extra memory is assigned

struct gdt_ptr_struct {
    uint16_t limit;
    unsigned int base;
} __attribute__((packed));

void initGdt();
// num specifies index in the GDT table
// granularity specifies whether the segment is in 4KiB pages or byte by byte.
void setGdtGate(uint32_t num, uint32_t base, uint32_t limit, uint8_t access,
                uint8_t gran);

// TSS
// Purpose of TSS is allow for context switching and multitasking
struct tss_entry_struct {
    // literally storing every possible variable that could be used in a process
    // so that the previous task is stored
    uint32_t prev_tss;
    uint32_t esp0;
    uint32_t ss0;
    uint32_t esp1;
    uint32_t ss1;
    uint32_t esp2;
    uint32_t ss2;
    uint32_t cr3;
    uint32_t eip;
    uint32_t eflags;
    uint32_t eax;
    uint32_t ecx;
    uint32_t edx;
    uint32_t ebx;
    uint32_t esp;
    uint32_t ebp;
    uint32_t esi;
    uint32_t edi;
    uint32_t es;
    uint32_t cs;
    uint32_t ss;
    uint32_t ds;
    uint32_t fs;
    uint32_t gs;
    uint32_t ldt;
    uint32_t trap;
    uint32_t iomap_base;
} __attribute__((packed));

void writeTSS(uint32_t num, uint16_t ss0, uint32_t esp0);
