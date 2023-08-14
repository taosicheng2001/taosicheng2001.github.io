# C Tricks

## SEXT(x, len)
`#define SEXT(x, len) ({ struct { int64_t n : len; } __x = { .n = x}; (uint64_t)__x.n; })`

Use Bit-Field to Sign Extend `x` to `len` length

## Label Address
```
const void ** _end = && _end_;
...
goto *(_end);
...
_end_:;
```
use `goto` to jump to `_end_` address

## C Struct Initial
```
struct{
    int a;
    int b;
}X;
X x = (X){.a = a, .b = b};
```

## Function Declaration
It's not nessecary to give the name of parameter in function declaration, the only thing needed is the type of parameters.

## Typedef
`typedef void(*handler_t)(void *buf)` This sentence define a new type named `handler_t`, which is a function pointer with `void *buf` as parameter.

## Extern list
```
file1.c
char font[128] = {0x01,0x02,0x03};

file2.c
extern char font[]
```

Used `[]` to declare a extern reference to list

## ASM
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
