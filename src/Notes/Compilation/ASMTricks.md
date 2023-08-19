# ASM Tricks

## INCBIN
`.incbin filename` include any data in `filename` into current ELF section, without any interruption.

## ASM in C
Read and write C variables from assembler
```
asm asm-qualifiers ( AssemblerTemplate
    : OutputOperands
    [ : InputOperands 
    [ : Clobbers ] ])

asm asm-qualifiers ( AssemblerTemplate
    : OutputOperands
    : InputOperands
    : Clobbers
    : GotoLables)
```
Qualifiers:

- volatile: disable optimizations on side effects
- inline: inlining purposes the size of the asm statement
- goto: may perform a jump to one of the labels in GotoLabels

Parameters:

- AssemblerTemplate: a string that contain assmemblr instructions
- Out/InputOperands: [[asmSymbolicName]] consstraint (cvariablename)
    - asmSymbolicName: If omiited, the use "%*n*" to reference the *n*st var in template
    - constraint: a string constant specifying constraint on the operand. `=`(overwriting c var),`+`(read and write from asm),`r`(for register),`m`(for memroy)
    - cvariblename: specify a C lvalue to hold the output.

## Bind Register to Var in C
`register <Type> <Var> asm("<Reg_Name>")` will define a local register variable and associate it with a specified register.

Tips: this usage is important when the particular inst don't provide sufficent control to select the desired register. For example, `ecall` in riscv.
