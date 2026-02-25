#include "16i_v4.asm"
#include "pesudo.asm"
#include "graphic.asm"

bootloader:
    ; r0 = ron_addr
    lmi r0, [#load_ron_addr]
    
    ; r1 = ram_addr
    lmi r1, [#load_ram_addr]

    .loop:
        ; ron_addr -= 1
        ; ram_addr -= 1
        addi r0, -2

        ; move to ram
        lm r2, [r0]
        sm r2, [r1]

        addi r1, -2

        ; compare r2
        mov r2, r0
        bne r2, main, #.loop
    
    addi r1, 2
    b r1

load_ron_addr:
#d16 le(eof`16)

load_ram_addr:
#d16 le(0xfffe)

main:
    mg


    ; r0 = color
    li r0, 0
    ; r1 = mask
    li r1, 0
    lui r1, 0x80
    .render:
        lmi r2, [#frame_size]
        .loop:
            or r0, r1
            sm r0, [r2]
            addi r0, 1
            addi r2, -1
            
            bnzi r2, #.loop
        bi #.render

    halt


frame_size:
#d16 le(FRAME_SIZE`16)
frame_cmd_addr:
#d16 le(FRAME_CMD_ADDR)

eof:
    ; end of file