# Chapter 3

## How to represent a number in computer ?
### Fixed Point Number
true code & one's-coomplement code & two's-complemental code

if the addtion between A and B, A and B have the same MSB, but the result has a different MSB, this means an overflow occurance.

### Floating Point Number
This consists of three parts, signature, exponent and  fraction

#### For float (32-bit) S(1) Exp.(8) Fraction(23) 
| Number | S | Exp. | Fraction | Value |
| ----- | --- | --- | ------- | ------ |
| +Inf  |  0  | 255 |    0    |   +Inf |
| -Inf  |  1  | 255 |    0    |   -Inf |
|Quiet Nan| 0 or 1 | 255 | MSB = 0 | NAN |
|Signaling NaN | 0 or 1 | 255 | MSB = 1| NAN |
|P Format Non-Zero | 0 | (0, 255) | f | 2^(e-127)(1.f) |
|N Format Non-Zero | 1 | (0, 255) | f | -2^(e-127)(1.f)|
|P Non-Format Non-Zero | 0 | 0 | f!=0 | 2^(e-126)(0.f) |
|N Non-Format Non-Zero | 1 | 0 | f!=0 | -2^(e-126)(0.f) |
|P Zero | 0 | 0 | 0 | 0 |
|N Zero | 1 | 0 | 0 | -0 |

Tips: 
1. Firstly check the Exp. , (0~255) means a Format Non-Zero
2. Secondly check the Fraction, we can distinct Non-Format Non-Zero from Zero and Signaling Nan from others
3. Thirdly specify the base (1.f or 0.f) and true Exp (e - 127 or e - 126)

#### For double (64-bit) S(1) Exp.(11) Fraction(52)
change 127 to 1023, others are the same

## CMOS circuit and tech
NMOS close when gate vol is low, PMOS close when gate vol is high. We need to let the CMOS work between JIEZHI and BAOHE zone

Poly provide **gate vol**. The input vol on poly can determine whether the VDD connect to Y or VSS connect to Y.

The more poly connected, the smaller R is, we can get a faster charing rate and a lower time delay.

## CMOS Logicy Circuit
1. Use NMOS to build positive logic , make it negative and connect to ground . And then use PMOS to build the exactly opposite logic and connect to VDD. For example, To build `~(A&B | C&D)`, we can A chuanlian B , C chuanlian D , binglian both and connect to the ground.
2. 1 pin connected to gate represents 2 transistors.
3. Decoder can be used when Memory Writing(input is address, output decide which line to write), Mux can be used when Memory Reading(input is address, output decide which linet to read)

## RS Flip Flop
RS Flip Flop will mantain the origin output when RS change from (0,1) -> (1,1) or from (1,0) -> (1,1).
## D Flip Flop
D Latch will mantain the origin output when C is 0; and set the output to D when C is 1.
D Flip Flop will mantian the origin output, only when C change from 1 to 0 the output is set to Q

