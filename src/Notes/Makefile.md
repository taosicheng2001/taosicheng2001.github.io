# Makefile

## Variable Assignment
Assignment should be implied **before recipes** if there are space inside,
all assignment inside a recipe **shouldn't contain space**.
- '=' normal assignment
- ':=' only assign once
- '?=' assign if var is undeclared

## Substraction 
We should use bash extension `$((A - B))` to make substraction. And in Makefile we **should use** `$$(($VAR1 -$VAR2))` to satisfy the syntax

## Test Without Run
`make -nB` will print out all the action without actually do the action
