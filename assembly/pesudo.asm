#ruledef
{
    nop => asm{ addi r0, 0 }


    ; Conditional jump
    bgt {a: reg}, {imm: s8}, {label: pca8} => asm{
        ci {a}, {imm}
        andi {a}, GT
        bnzi {a}, {label}
    }
    ble {a: reg}, {imm: s8}, {label: pca8} => asm{
        ci {a}, {imm}
        andi {a}, GT
        bzi {a}, {label}
    }
    
    bge {a: reg}, {imm: s8}, {label: pca8} => asm{
        ci {a}, {imm}
        andi {a}, GE
        bnzi {a}, {label}
    }
    blt {a: reg}, {imm: s8}, {label: pca8} => asm{
        ci {a}, {imm}
        andi {a}, GE
        bzi {a}, {label}
    }
    
    bgtu {a: reg}, {imm: s8}, {label: pca8} => asm{
        ci {a}, {imm}
        andi {a}, GTU
        bnzi {a}, {label}
    }
    bleu {a: reg}, {imm: s8}, {label: pca8} => asm{
        ci {a}, {imm}
        andi {a}, GTU
        bzi {a}, {label}
    }
    bgtu {a: reg}, {b:   s8}, {label: pca8} => asm{
        c {a}, {b}
        andi {a}, GTU
        bnzi {a}, {label}
    }
    bleu {a: reg}, {b:   s8}, {label: pca8} => asm{
        c {a}, {b}
        andi {a}, GTU
        bzi {a}, {label}
    }

    bgeu {a: reg}, {imm: s8}, {label: pca8} => asm{
        ci {a}, {imm}
        andi {a}, GEU
        bnzi {a}, {label}
    }
    bltu {a: reg}, {imm: s8}, {label: pca8} => asm{
        ci {a}, {imm}
        andi {a}, GEU
        bzi {a}, {label}
    }

    beq {a: reg}, {imm: s8}, {label: pca8} => asm{
        ci {a}, {imm}
        andi {a}, EQ
        bnzi {a}, {label}
    }

    bne {a: reg}, {imm: s8}, {label: pca8} => asm{
        ci {a}, {imm}
        andi {a}, EQ
        bzi {a}, {label}
    }
    bne {a: reg}, {b:  reg}, {label: pca8} => asm{
        c {a}, {b}
        andi {a}, EQ
        bzi {a}, {label}
    }
    bne {a: reg}, {imm: s8}, {label:  reg} => asm{
        ci {a}, {imm}
        andi {a}, EQ
        bzi {a}, #branch
        branch:
            mov pc, {label}
    }
    bne {a: reg}, {b:  reg}, {label:  reg} => asm{
        c {a}, {b}
        andi {a}, EQ
        bzi {a}, #branch
        branch:
            mov pc, {label}
    }

    b {label: pca8} => asm{
        bi {label}
    }
    b {label:  reg} => asm{
        mov pc, {label}
    }
}

; Compare flags
#const GT  = 1 << 0
#const GE  = 1 << 1
#const GTU = 1 << 2
#const GEU = 1 << 3
#const EQ  = 1 << 4
#const N   = 1 << 5
#const V   = 1 << 6
#const C   = GEU
#const Z   = EQ