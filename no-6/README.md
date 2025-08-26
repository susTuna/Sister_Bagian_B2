# Minecraft ASM Converter Tool
This project provides a set of Python scripts to convert a custom assembly language, tailored for a Minecraft CPU, into a .schem file that can be used in Minecraft.

## Prerequisities
**1. MCSchematic Library**

Install `mcschematic` python library
```bash
pip install mcschematic
```
## How it Works
The process is broken down into two main steps:

**1. Assembly to Machine Code**

The `assembler.py` script takes an assembly language file like `programs/Instructions.as` as input and converts it into machine code (a series of 16-bit binary instructions), saving it as a `.mc` file.

**2. Machine Code to Schematic** 

he `schematic.py` script reads the `.mc` file and generates a Minecraft schematic `.schem` file. This schematic file contains a structure of blocks (repeaters and wool) that represents the machine code, which can then be imported into a Minecraft world.

The `main.py` script automates this two-step process.

## How to Use
**1. Write your assembly code**

Create a new `.as` file in the programs directory with your custom assembly instructions.

```as
; only available instructions are such
ADD ; r1 r2 r3 -> r1 + r2           = r3
SUB ; r1 r2 r3 -> r1 - r2           = r3
XOR ; r1 r2 r3 -> r1 XOR r2         = r3
XNR ; r1 r2 r3 -> r1 XNOR r2        = r3
OR  ; r1 r2 r3 -> r1 OR r2          = r3
NOR ; r1 r2 r3 -> r1 NOR r2         = r3
AND ; r1 r2 r3 -> r1 AND r2         = r3
NND ; r1 r2 r3 -> r1 NAND r2        = r3
IMP ; r1 r2 r3 -> r1 IMPLIES r2     = r3
NMP ; r1 r2 r3 -> r1 NOT_IMPLIES r2 = r3
SHR ; r1 r2    -> r1 >> 1           = r2
LDI ; r1 A     -> A                 = r1
; only available registers are such
r0 ; zero register doesnt write to anything
r1
r2
...
r15
; example
ADD r1 r2 r3
LDI r1 69
```

**2. Run the main script**

Execute the `main.py` script from your terminal, passing the name of your assembly file (without the extension) as an argument.

```bash
python main.py YourProgramName
```
**3. Find the output**

The script will generate a `.mc` file and a `.schem` file in the `programs` directory.

**4. Import into Minecraft**

Use a tool like **WorldEdit** to import the `.schem` file into your Minecraft world.

## Acknowledgement
This project is a modified version of the original source code by [mattbatwings](https://github.com/mattbatwings).