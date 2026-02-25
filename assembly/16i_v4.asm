#ruledef
{
    ; =========================================================================
    ; 12bits instruction 
    ; =========================================================================
    
    ; ALU with 8 bits Immediate
    addi  {ad: reg}, {imm: s8} => le(imm @ ad @ 0x0)
    rsubi {ad: reg}, {imm: s8} => le(imm @ ad @ 0x1)
    ci    {ad: reg}, {imm: s8} => le(imm @ ad @ 0x2)
    andi  {ad: reg}, {imm: s8} => le(imm @ ad @ 0x3)
    ori   {ad: reg}, {imm: s8} => le(imm @ ad @ 0x4)
    xori  {ad: reg}, {imm: s8} => le(imm @ ad @ 0x5)

    ; Immediate load Register value
    li  {d: reg}, {imm: s8} => le(imm @ d @ 0x6)
    lui {d: reg}, {imm: u8} => le(imm @ d @ 0x7)

    lmi {d: reg}, [{label: pca8}] => le(label @ d @ 0x8)
    smi {d: reg}, [{label: pca8}] => le(label @ d @ 0x9)

    ; Branch with Immediate
    bzi  {a: reg}, {label: pca8} => le(label @ a @ 0xa)
    bnzi {a: reg}, {label: pca8} => le(label @ a @ 0xb)
    bi             {label:  pca} => {
        assert(label <= 0x7ff, "label too far away (cannot fit in 12 bits)")
        assert(label >= !0x7ff, "label too far away")
        le(label`12 @ 0xc) 
    }

    ; =========================================================================
    ; 8bits instruction 
    ; =========================================================================
    
    ; ALU
    add  {ad: reg}, {b:  reg} => le(b @ 0x0 @ ad @ 0xf)
    sub  {ad: reg}, {b:  reg} => le(b @ 0x1 @ ad @ 0xf)
    c    {ad: reg}, {b:  reg} => le(b @ 0x2 @ ad @ 0xf)
    and  {ad: reg}, {b:  reg} => le(b @ 0x3 @ ad @ 0xf)
    or   {ad: reg}, {b:  reg} => le(b @ 0x4 @ ad @ 0xf)
    xor  {ad: reg}, {b:  reg} => le(b @ 0x5 @ ad @ 0xf)
    ; shift
    sll  {ad: reg}, {b:  reg} => le(b @ 0x6 @ ad @ 0xf)
    srl  {ad: reg}, {b:  reg} => le(b @ 0x7 @ ad @ 0xf)
    sla  {ad: reg}, {b:  reg} => le(b @ 0x8 @ ad @ 0xf)    
    ; shift Immediate
    slli {ad: reg}, {imm: u4} => le(imm @ 0x9 @ ad @ 0xf)
    srli {ad: reg}, {imm: u4} => le(imm @ 0xa @ ad @ 0xf)
    slai {ad: reg}, {imm: u4} => le(imm @ 0xb @ ad @ 0xf)

    lm {d: reg}, [{a: reg}] => le(a @ 0xc @ d @ 0xf)
    sm {d: reg}, [{a: reg}] => le(a @ 0xd @ d @ 0xf)

    mov {d: reg}, {a: reg} => le(a @ 0xe @ d @ 0xf)


    ; =========================================================================
    ; 4bits instruction 
    ; =========================================================================


    ; =========================================================================
    ; 0bits instruction 
    ; =========================================================================

    mr   => le(0xff @ 0x0 @ 0xf)
    mg   => le(0xff @ 0x1 @ 0xf)


    halt => le(0xff @ 0xf @ 0xf)
}


#subruledef reg
{
    r{r: u4} => r
    sp => 0xe
    pc => 0xf
}

#subruledef pca
{
    #{label} => ((label - $) >> 1) - 1
}

#subruledef pca8
{
    {label: pca} => {
        assert(label <= 0x7f, "label too far away")
        assert(label >= !0x7f, "label too far away")
        label`8
    }
}



#bankdef ron
{
    #bits 8
    #addr 0x00
    #size 0x80
    #outp 0x00
}