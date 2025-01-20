global gdt_flush 

gdt_flush:
    MOV eax, [esp+4] ;Gets passed argument off the stack into eax
    LGDT [eax] ;Tells processor the location of the GDT

    MOV eax, 0x10 ;The offset to the GDT
    ;Each defines the location of a different segment register
    ;The following points these variables to the GDT
    MOV ds, ax ;data segment
    MOV es, ax ;extra segment
    MOV fs, ax ;extra segment
    MOV gs, ax ;extra segment
    MOV ss, ax ;stack segment
    JMP 0x08:.flush ;This does a far jump that will let us set the Code Segment
.flush:
    RET

global tss_flush
tss_flush:
    mov ax, 0x2B
    ltr ax
    ret
