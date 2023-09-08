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

## HashMap in C
```
#include <search.h>
hcreate();
hsearch();
hdestory();
```
