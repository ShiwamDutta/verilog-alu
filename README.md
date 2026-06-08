# RTL Design and Implementation of an ALU in Verilog

Digital Design • Verilog HDL • RTL Design

## Overview

This project implements a calculator datapath using Verilog HDL.
The design follows a modular and scalable architecture where each
arithmetic unit is implemented as an independent module.

The modules are parameterized, enabling the datapath width
to be easily scaled from 8-bit to 16-bit without redesigning
the arithmetic units.

The core arithmetic operations of the ALU are implemented using
structural or algorithmic RTL techniques, such as carry lookahead addition,
Booth multiplication, and restoring division, to realize hardware-level logic.

## Features

- Modular RTL design using Verilog HDL
- Dedicated modules for:
  - Adder / Subtractor
  - Multiplier
  - Divider
- Parameterized arithmetic units (default: 8-bit)
- Integrated ALU (Arithmetic Logic Unit) supporting multiple operations
- Testbench-based functional verification
- Waveform analysis using GTKWave

## Tools

### 1. Icarus Verilog

Used for compiling and simulating Verilog code.

Windows:  
Download from [Icarus Verilog](https://bleyer.org/icarus/)

Linux:  
Ubuntu/Debian: `sudo apt install iverilog`  
Fedora: `sudo dnf install iverilog`

### 2. GTKWave

Used to visualize and analyze waveforms.

Windows:  
It comes bundled with Icarus Verilog for Windows.  
But standalone download (official) from
[SourceForge/GTKWave](https://sourceforge.net/projects/gtkwave/)

Linux:  
Ubuntu/Debian: `sudo apt install gtkwave`  
Fedora: `sudo dnf install gtkwave`

## Folder Structure

```
calculator_alu_design/
|
├── src/           # Parameterized Verilog modules
├── tb/            # Testbench for individual modules
├── build/         # Compiled simulation files
├── waves/         # VCD waveform files
└── graph_images/  # Waveform screenshots for reference
```

## ALU Operations

| Opcode (in hex) | Operation      |
| --------------: | -------------- |
|               0 | Addition       |
|               1 | Subtraction    |
|               2 | Multiplication |
|               3 | Division       |
|               4 | AND            |
|               5 | OR             |
|               6 | XOR            |
|               7 | NOT            |
|               E | Operand 1      |
|               F | Operand 2      |

## How to Run

Ensure required directories (build, waves) exist before simulation:

```bash
mkdir build waves
```

### Compile

```bash
iverilog -o build/alu.vvp src/* tb/alu_tb.v
```

### Run Simulation

```bash
vvp build/alu.vvp
```

### View Waveform

```bash
gtkwave waves/alu.vcd
```

**Note:**
Replace `alu_tb.v` with other testbench files when testing individual modules, and update the output file name accordingly.

## License

This project is developed for academic purposes
as part of a B.Tech final year project.

## Author

Shiwam Dutta  
B.Tech. (Electronics and Communication Engineering)
