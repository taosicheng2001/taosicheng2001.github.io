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
