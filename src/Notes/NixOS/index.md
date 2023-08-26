# NixOS
## 8.25
Language, Libarraies, Developer tools, Generic build mechanism, composition and configuration mechanism, ecosystem and package mechaisms, NixOS module system. 

Assigning names and accessing values, Declaring and calling funcitons, Built-in and library functions, impurities to obtain build inputs, derivations that describe build tasks.

**Nix language use lazy evaluaton, and only computes values when needed**

`nix repl` to enter nix evironment
`nix-instantiate --eval` to evaluate the expression in Nix file, this will read from `default.nix` if no filename is specified.
`:p` to print out the expression 
`:q` to exit the nix repl

Variable in Nix can be primitive data types, lists, attribute sets, and function

An attribute set is a collection of name-value-pairs, where name must be unique.
```
{
 string = "Hello";
 float = 3.141;
 attribute-set =  {
    a = "Heelo";
    b = 2;
    d = false;
 };
}
```

Recursive attribue set `rec{ ... }` allows access to attributes from within the set
```
rec {
    one  = 1;
    two = one + 1;
    three = two + 1;
}
```

`let ... in ...` allow assigning names to values for repeatted use.( which means can names can be used in `in` place). Names can be assigned in any order, and expressions on the right of the assignment can refer to other assigned names.
```
let
    a = 1;
in 
a + a
```

Attributes in a set are accessed with a dot and the attribute name.

`with ...; ...` allows access to attributes without repreatedly referening their attribute set.
```
let 
    a = {
        x = 1;
        y = 2;
        z = 3;
        };
in 
with a; [x y z]
```

`inherit ...` is shorthand for assigning the value of a name from an existing scope to the same name in a nested scope.
```
let
    a = { x = 1; y = 2};
in 
{
    inherit (a) x y;
}
```

`${...}` the value of a Nix ecpression can be inserted into a character string with this . Only strings or values that can be represented as a character string are allowed.
```
let
    name = "Nix";
in
    "hello ${name}"
```

Indented strings are demoted by single quotes \"\", which will be expalined as multi-line strings

Functions. Whenever you see a colon in nix, on its left is the **fuction argument** , on its right is the **function body**.

One Arguments (Including one var or attributes set)
```
let 
    f= x : x.a;
in f { a = 1;}
```

Multi-Arguments 
```
let 
    f = x: y: x + y;
in 
f 1 2
```
In this situation, the expression ` x: y: x + y` equals to `x: (y: x + y)` 
