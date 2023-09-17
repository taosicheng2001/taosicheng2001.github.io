# DataType

## Comparison
```scala
Equality: x === y 
Inequality: x =/= y
```
These comparison can be applied to compare `Bool`,  `Bits`, `UInt`, `SInt`, `Enum`, `Vec`

```scala
Greater Than: x >y
Greater Than or Equal: x >= y
Less Than: x < y
Less Than or Equal: x <= y
```
These comparison can be applied to compare `UInt`, `SInt`

## Range
```scala
index1 downto index2 // [index1, index2]
index1 to index2     // [index2, index1]
index1 until index2  // (index2, index1]
```

## Element
```scala
index -> value // assignment for index
Range -> value // assignment for ranger(index1>index2)
default -> value // remaing element assignment
```

## Bool
### Declaration
```scala
Bool() 
True 
False
Bool(value: Boolean)
```
All these sentense create a Bool type.

### EdgeDectection
```scala
x.edge[()]
x.edge(initAt: Bool)
x.rise[()]
x.rise(initAt: Bool)
x.fall[()]
x.fall(initAt: Bool)
x.edges[()]
x.edges(initAt: Bool)
x.toggle[()]
```

### Logic
```scala
!x
x && y
x & y
x || y
x | y
x ^ y
~x
x.set[()]
x.clear[()]
x.setWhen(cond)
x.clearWhen(cond)
x.riseWhen(cond)
x.fallWhen(cond)
```

### Type Cast
```scala
x.asBits
x.asUInt
x.asSInt
x.asUInt(bitCount)
x.asBits(bitCount)
```
The last two usage will resize and put the Bool value in LSB and padding with zeros

### Tips:
1. `Bool`(spinalHDL type) is different from `Boolean`(scala type)


## Bits

### Declaration
```scala
Bits()
Bits(x bits)
B(value: Int [, x bits])
B(value: BigInt [, x bits])
B"[[size'] base] value"
B([x bits,] elements: Element*)
```
base here is 'h', 'd', 'o', 'b'

the size of a Bits will be inferred to the widest assignment

### BitExtraction
```scala
x(y: Int)
x(y: UInt)
x(offset: Int, width bits)
x(offset: UInt, width bits)
x(range: Range)
x.subdivideIn(y slices)
x.subdivideIn(y bits)
x.msb
x.lsb
```

### Logic
```scala
~x
x & y
x | y
x ^ y
x.xorR
x.andR
x.orR
x >> y: Int // reduce width
x >> y: UInt // keep width
x << y: Int // increase width
x << y: UInt // may increase width
x |>> y // keep width
x |<< y // keep width
x.rotateLeft(y)
x.rotateRight(y)
x.clearAll[()]
x.setAll[()]
x.setAllTo(value: Boolean)
x.setAllTo(value: Bool)
```

### Misc
```scala
x.getWidth
x.bitsRange
x.valueRange
x.high
x.reversed
x ## y // return type is Bits
x.resize(y)
x.resized
x.resizeLeft(x) // Keep the MSB at the same place
x.getZero
x.getAllTrue
```

## U/SInt

### Declaration
```scala
U/SInt[()]
U/SInt(x bits)
U/S(value: Int [, x bits])
U/S(value: BigInt [, x bits])
U/S"[[size']base]value"
U/S([x bits,] elements: Element*)
```

### BitExtraction
most usage is the same as Bits
`x.sign` will access the most sign bit, which is only available for SInt

### Arithmetic
```scala
x + y
x +^ y
x +| y
x - y
x -^ y
x -| y
x * y
x / y
x % y
~x
-x
```
with Carry and Saturation Arithmetic is special

### Logic 
the same as `Bits` 

### Type Cast
```scala
x.asBool // extract LSB of x
x.asBools // Cast into a array og Bool
S(x: T)
U(x: T)
x.intoSInt
// when x is UInt
x.twoComplement(en: Bool)
// when x is SInt
x.abs
x.abs(en: Bool)
x.absWithSym
```

### Misc
most usage is the same as `Bits`
```scala
x.minValue
x.maxValue
x @@ y // return type is the same as x
x.expand // expand x with 1 bit
```

## Enum
### Declaration and Encoding
```scala
val MyEncoding = SpinalEnumEncoding("dynamicEncoding", _ * 2 + 1)
object Enumeration extands SpinalEnum([MyEncoding]){
    val element0, element1, ... ,elementN = newElement()
    [defaultEncoding = SpinalEnumEncoding("staticEncoding")(
        element0 -> val0,
        ...
        elemetnN -> valn
    )]
}
```
We can choose dynamicEncoding or staticEncoding if needed, or just use default encoding

### Type
Enum value type is `spinal.core.SpinalEnumElement[UartCtrlTxState.type]` or `UartCtrlTxState.E`

Enum bundle type is `spinal.core.SpinalEnumCraft[UartCtrlTxState.type]` or `UartCtrlTxState.C`

### Type Cast
the other can be found in `Bits`
`e.assignFromBits(bits)` will cast `Bits` into `Enum`(e must be a Enum())

## Bundle
### Declaration
```scala
case class myBundle[(para0: AnyType, ...., paraN: AnyType)] extends Bundle {
    val bundleItem0 = AnyType
        ...
    val bundleItemN = AnyType
    val data = (cond) generate (AnyType) // only generate this signal when cond is true
}
```
### Direction
if all elements of the bundle go in the same direction, there is no need to modify the bundle,  just use `in` or `out` to specify the direction
```scala
val io = new Bundle {
    val input = in(MyBundle())
    val output = out(MyBundle())
}
```
we can implement function `def asMaster(): Unit` to specify the direction of each element **from the master's view**, and use `master` or `slave` to specify the direction
```scala
case class HandShake(payloadWidth: Int) extends Bundle with IMasterSlave {
    val valid = Bool()
    val ready = Bool()
    val payload = Bits(payloadWidth bits) 

    override def asMaster(): UInt = {
        out(valid, payload)
        in(ready)
    }
}

val io = new Bundle {
    val output = master(HandShake(8))
    val input = slave(HandShake(8))
}
```
### Type Cast
`x.asBits` will cast bundle into `Bits` in the order where they are defined

`x.assignedFromBits(y)` will convert Bits(y) into Bundle(x)

`x.assignedFromBits(y, hi, io)` will convert Bits(y) into Bundle(x) with high/low boundary

## Vec
### Declaration
```scala
Vec.fill(size: Int)(type: Data)
Vec(x, y, ...)
```
`Vec.fill` only declares a vector with type and size

`Vec` only create a vector with indexws point to xy..., which doesnot create new hardware signals

### Type Cast
`x.asBits` will cast vector into Bits in indexs' order

### Lib Function
all the lib function are from `import spinal.lib._`
```scala
x.sCount(condition: T => Bool)
x.sCount(value: T)
x.sExists(condition: T => Bool)
x.sContains(value: T)
x.sFindFirst(condition: T => Bool)
x.reduceBalancedTree(op: (T, T) => T)
x.shuffle(indexMapping: Int => Int)```
