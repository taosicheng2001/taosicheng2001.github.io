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
