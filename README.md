# 16I

A hand-drawing 16-bits multicycle CPU with custom instruction set

![](./imgs/screenshot.png)

## Getting Start

I use [customasm](https://hlorenzi.github.io/customasm/) to comiple custom assembly.

There are 3 file `16i_v4.asm` `pesudo.asm` `graphic.asm`

- `16i_v4.asm` contain all instruction.
- `pesudo.asm` contain pesudo instruction such as long jump/compare-and-branch
- `graphic.asm` contain sample color code

## Instruction Set

A simple 16-bits instruction set.

It contain I(immediate) format, R(register) format, and B(branch) format.
All immediate is 8 bits width.

![![](./imgs/16ISA.png)](./imgs/16ISA.pdf)

## Architecture

### Clock

This design utilize 3 master-slave flip-flop as counter.

![](./imgs/clock.png)

### Registers

16 level-trigger registers pack together with shared data bus and address bus.

![](./imgs/regs.png)

### Memory Control Unit

I split memory 2 part.

- 0x0000 ~ 0x7FFF ROM/Graphic RAM
- 0x8000 ~ 0xFFFF RAM

When instruction `mg` execute,
the lower half of memory space will be replace with Graphic RAM.
The `mr` switch back to ROM.


![](./imgs/mcu.png)

### Arithmetic Logic Unit

Support `Add`, `Sub`, `Cmp`, `And`, `Or`, `XOr`, and bit shift.

First 3 operation is implement with ripple adder.
Bit shift is base on barrel shifter which complete in 1 cycle.

![](./imgs/alu.png)

### Decode and Execute

![](./imgs/ex.png)


