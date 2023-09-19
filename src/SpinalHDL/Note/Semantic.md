# Semantic

## Assignments
`:=`: Standard assignment, equivalent to `<=` in verilog
`\=`: Equaivalent `=` in verilog, the value is updated instantly in-place
`<>`: Automatic connection between 2 singals or bundles

Tips:

1. When muxing, `the last valid standard assignment :=` wins.
2. Assigning twice to the same assignee from the same scope results an `assignment overlap`
3. use `()` to bundle multiple siganls together and make assignment


## When/Switch/Mux

### When
```scala
when(cond1){
}elsewhen(cond2){
}otherwise{}
```
or
```scala
when(cond1){
}
.otherwise{
}```

### Switch
```scala
switch(x) {
 is(value1){
 }
 is(value2){
 }
 default{
 }
}
```
or
```scala
switch(x){
 is(value1, value2, value3){
 }
 is(value4, value5){
 }
}```

By setting `coverUnreachable = true` will let `switch()` function parse the default situation; By setting `strict = true` will remove the duplicated value

### Mux
`Mux(cond, whenTrue, whenFalse)`  or `cond ? whenTrue | whenFalse` will mux two value according to the cond

mux can be applied to x, if x is a BitVector(Bits, UInt, SInt)
```scala
x.mux(
    0 -> val0,
    1 -> val1,
    2 -> val2,
    default -> val3
)
```
If all the cases are covered, the `default` statement shouldnot be added.

`muxList(...)` and `muxListDc(...)` can also applied to bitwise x. Where `muxList(...)` offers a easier mapping interface and needs full coverage. `muxListDc(...)` can be used when the uncovered values are not important, they can be left unassigned.

## Rules
1. Signals and registers are operating **concurrently** with each other(parallel behavioral)
2. An assignment to a combination singal is like expressing a rule which is **always true**
3. An assignment to a register is like expressing a rule which is applied **on each cycle** of its clock domain
4. For each signal, **the last valid** assignment wins
5. Each signal and register can be manipulated as **an object** during hardware elaboration in a OOP manner.

**Tips**

The order where the assignment has no behavioral impact. More generally,  the `:=` assignment operator adds an additional new rule for left val. But **Only the last valid** assignment will win, and always false section will not be generated in SpinalHDL elboration phase.

From a generated RTL generation / SpinalHDL perspective, when you use functions in Scala which generate hardware, it is like the function was inlined. This is also true case for Scala loops, as they will appear **unrolled form** in the generated RTL.
