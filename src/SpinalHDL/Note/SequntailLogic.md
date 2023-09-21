# SequentialLogic
## Registers
### Instantiation
```scala
Reg(type: Data) 
RegInit(resetValue: Data)
RegNext(nextValue: Data)
RegNextWhen(nextValue: Data: cond: Bool)
```
**Tips**: 
1. `RegInit` will reset the reg to resetvalue when the reset occurs, `RegNext` will sample the nextValue each cycle, while `RegNextWhen` only sample the nextValue when cond is true
2. reset and clock cycle are implicit
3. the last assignment wins, but if no assignment is done, the register **keeps its value**
4. `init(value: Data)` can be used to initialize `Reg` element and `bundle` element(only valid when bundle have a reset)
5. `randomBoot()` can initialize a reg with random value
6. `setAsReg()` can transform a wire into a register. The register is created **in the clock domain of wire**, and doesn't depend on the place where the `setAsReg` is used.

### register vector
We can define a vector of registers with `Vec`
```scala
Vec(Reg(T), n)
Vec.fill(n)(Reg(T))
```
`init()` can be used for register intialization here
```scala
Vec(Reg(T) init(value),n))
val v1 = Vec.fill(n)(Reg(T))
v1.foreach(_ init(value))
```

## RAM/ROM
```scala
Mem(type: Data)
```
