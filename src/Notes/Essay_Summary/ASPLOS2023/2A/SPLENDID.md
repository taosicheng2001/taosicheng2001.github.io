# ASPLOS2023

## SPLENDID

### ABSTRACT
decompiler-based **collaboration**

Pro: provide natural compiler-parallelized starting point for further parallelization or refinement
Con: don't generate portable parallel source code compatible with any compiler of the source language

SPLENDID:

an **LLVM-IR to C/OpenMP decompiler** that enables collaborate parallization by producing standard parallel OpenMP code

### INTRODUCTION
Parallelization will always benefit from the collaboration between programmer and compiler

Collaboration Approaches:
1. Compiler maps the programmmer-expressed parallelism to utilize parallel resources of the hardware
2. Compiler first presents its parallelization to the programmer

Presenting compiler parallelization through decompilation <span style="color:red"> WHY? </span>

Translating parallel IR to portable prallel source code is *not a trivial task*
- mosst parallel program model impose strict requeirements for loop structure
- parallel runtime library call will be exposed and become unportable
- assigning variables with physical registers will intrudes significant overhead in understanding code semantics

SPLENDID:

- The first LLVM-to-C/OpenMP decompiler that provides portable natural translation from parallel LLVM-IR to OpenMP-parallel source code. 
- Explicitly represents parallelism through the widely used parallel programming model, OpenMP
- Restore variable names

### MOTIVATION
Three roadblocks preventing decompilation from enabling collaborative parallelization
- Lack of Explicit Prallelism
- Obfuscated Control Flow Translation
- Variable Names Irrelevant to Semantics

### DESIGN AND IMPLEMENTATION
#### Parallel Source Code Generation
1. Parallel Semantic Analyzer
2. Parallel Region Detransformer
3. Pragma Generator

#### Natural Control-Flow Generation
Loop Rotate Detransformer

#### Variable Generation
1. Variable Proposer
2. Variable Generator

## Conclusion
SPLENDID convert LLVM-IR to compiler-parallized source code. To make the source code more natural, the parallization is presented by Open-MP pragma and variable is recoverd semantically, which also makes the source code portable.

