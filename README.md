# Verilog Calculator Chip Design

## Overview

This project implements a calculator datapath using Verilog HDL.
The design follows a modular architecture where each arithmetic unit
is implemented as an independent module.

Instead of relying entirely on built-in arithmetic operators,
the design emphasizes structural implementation of arithmetic
circuits such as adder, subtractor, multiplier, and divider.

## Features

- Modular RTL design using Verilog HDL
- Structural implementation of arithmetic units
- Separate modules for:
  - Adder
  - Subtractor
  - Multiplier
  - Divider
- Arithmetic Logic Unit (ALU) integrating all operations
- Signed 8-bit arithmetic implementation
- Testbench based verification
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
├── src/           # Verilog source files (modules and ALU)
├── tb/            # Testbench files
├── build/         # Compiled simulation files
├── waves/         # VCD waveform files
└── graph_images/  # Waveform screenshots for reference
```

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
