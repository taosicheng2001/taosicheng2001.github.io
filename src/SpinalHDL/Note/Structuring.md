# Structuring

## Component and hierarchy
1. In spinalHDL, we don't need to bind their ports at instantiation
2. Declare external ports in a `Bundle` called `io` is recommended, like `val io = new Bundle {...}`
3. We can use `Module` instead of `Component`, which are the same thing

### Input/Output Definition
```scala
in/out port Bool()
in/out Bits/UInt/SInt[(x bits)]
in/out(T)
master/slave(T)
```
Components can only **read** output and input signals of child components.

Components can read their own output port values.
### Pruned signals
SpinalHDL will generate **all the named signals and their depedencies**, while **all the useless anoymous/zero width ones** are removed from the RTL generation.
### Parametrized Hardware
If we have several parameters, it's a good practice to give a specific **configuration class**
```scala
case calss MySocConfig(axiFrequncy: HertzNumber,
                       onChipRamSize: bigInt,
                       cpu: RiscCoreConfig,
                       iCache: InstructioinCacheConfig){
                                ... 
                            require(condition)
                       }

class MySoc(config: MySocConfig) extends Component{
    ......                       
}
```
### Synthesized component names
`setName`, `getName`, `setPartialName`, `getPartialName` to deal with "partia name" and "full name" of singal element generation at synthesis

`setDefinitionName` to modify name of module generation at synthesis

## Area
1. Don't need to define all construction parameters and IO
2. Don't need to split codes
Using an `Area` to define a group of signals/logic

## Function
Scala Function can:
1. instantiate registers, combinational logic and components inside functions.
2. everything is passed bu reference
3. be defined inside a class(Bundle)

## Clock Domains
1. clock and reset signal can be combined to create a **clock domain**. Clock domain can be appiled to some area and all synchronous elements instantiated into those areas will then **implicitly** use this clock domain.
2. Register captures its clock domain when the register is created, not when it's assigned.
### Instantiation
```scala
ClockDomain(
  clock: Bool
  [,reset: Bool]
  [,softReset: Bool]
  [,clocknEnable: Bool]
  [,frequency: IClockDomainFrequency]
  [,config: ClockDomainConfig]
)
```
### ClockArea
```scala
// using an Area
val coreClockDomain = ClockDomain(coreClock, coreReset)
val coreArea = new ClockingArea(coreClockDomain){ ... }

// without an Area
val gatedClk = ClockDomain.current.readClockWire && io.enable
val gated = ClockDomain(gatedClk, ClockDomain.current.readResetWire)
val gatedC1 = gated(CounterFreeRun(16))
val gatedC2 = gated on CounterFreeRun(16)
```
### Configuration
```scala
config = ClockDomainConfig(
    clockedge = [RISING/FALLING],
    resetKind = [ASYNC/SYNC/BOOT],
    resetActiveLevel = [HIGH/LOW],
    softResetActiveLevel = [HIGH/LOW],
    clockEnableActiveLevel = [HIGH/LOW]
)
```
### Internal Clock
```
ClockDomain.internal(
    name: String,  // Name of clk and reset signal
    [config: ClockDomainConfig,]  // Configuration
    [withReset: Boolean,]  // Add a reset signal
    [withSoftReset: Boolean,]  // Add a soft reset signal
    [withClockEnable: Boolean,]  //  Add a clock enable
    [frequency: IClockDomainFrequency]
)
```
Once created, you have to assign the ClockDomain's signals
### External Clock
clock domain which is driven by the outside. It will then automatically add clock and reset wires from the top level inputs to all synchronous elements.

The arguments to the `ClockDomain.external` function are the same as in the `ClockDomain.internal` function
### Signal Priorities
`asyncReset` > `clockEnable` > `synReset` > `softReset`
### Context
retrieve the current clock domain by calling `ClockDomain.current` and the return instance has these functions to be called
```scala
frequency.getValue
has[Reset/SoftReset/ClockEnable]
read[Clock/Reset/SoftReset/ClockEnale]Wire
is[Reset/SoftReset/ClockEnable]
```
### Clock Domain Crossing
If we want to read a signal from another `ClockDomain` area, we need to add `addTag(crossClockDomain)` to the destination signal

`BufferCC(input: T, init: T = null, bufferDepth: Int = 2)` can be used for signals of only 1 bit-flip per clock cycle. For multi-bit cases, it is recommand to use `StreamFifoCC` for high bandwidth requirement or `StreamCCByToggle` for less resource usage.

### Special Clocking Area
`SlowArea(scale: Int)` create a area which is slower scale times than the current one.

`SlowArea(value MHz)` create a area with value MHz frequent

`clockDomain.withBootReset()` could specify register's resetKind as BOOT, `clockDomain.withSyncReset` could specify register's resetKind as SYNC 

`ResetArea(specialReset: Bool, en: Bool)` create a new clock domain area where a special reset signal is combined with the current clock domain reset. If `en` is true, the new area will be a **combination** between the current reset and the specialReset

`ClockEnableArea(clockEnale: Bool)` create a new clock domain area where add an additional clock enable in the current clock domain.

## Instantiate VHDL and Verilog IP
A blackbox allows user to integrate an existing VHDL/Verilog component into the designe by just **specifying its interface**.
### Defining a blackbox
```scala
class Ram(wordWidth: Int, wordWidth: Int) extends Blackbox { ... }
```
### Generics
```scala
addGeneric("wordCount", wordCount)
addGeneric("wordWidth", wordWidth)
// OR
val generic = new Generic {
    val wordCount = Ram.this.wordCount
    val wordWidth = Ram.this.wordWidth
}
```
### Instantiating
```scala
val ram = new Ram(8, 16)
```
### Clock and reset mapping
```scala
mapClockDomain(clockDomain: ClockDomain, clock: Bool = Nothing, reset: Bool = Nothing, enable: Bool = Nothing)
mapCurrentClock()
```
### IO 
`noIOPrefix()` can avoid the prefix "io_" on each of the IOs of the blackbox.
`addPrePopTask(() => renameIO(()))` can rename name of port in blackbox by **renameIO()** func
### Add RTL source
`addRTLPath(path: String)` will add RTL source code according to the file path.

## Preserving Names
### Nameable base class
All the things which can be named in SpinalHDL extends the Nameable base, and has the Nameable API
`x.setName(str: String)` set x's name to `str` 

`x.setCompositeName(y, postfix = str)` set x's name to `y_str`

### Name Extraction 
