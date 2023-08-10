# Makefile

## Syntax

### Variable Assignment
Assignment should be implied **before recipes** if there are space inside,
all assignment inside a recipe **shouldn't contain space**.
- '=' normal assignment: these references are expanded whenever this variable is subsituted
- ':=' only assign once: these references are expanded once when the variable is defined.
- '?=' assign if var is undeclared

### Conditional Sentence
The syntax of conditional branch are like:
```
<conditional-directive>
<text-if-true>
endif
```
`<conditional-directive>` can be 
1. `ifeq(<arg1>, <arg2>)`
2. `ifneq(<arg1>, <arg2>)`
3. `ifdef <variable-name>`
4. `ifndef <variable-name>`

### Escape Character
1. `$$` to escape `$`

### Automatic Variables
1. `$@` refers to target file or **Archive File**
2. `$^` refers to all dependent files
3. `$<` refers to the first dependent file
4. `$?` refers to dependent files that are newer than target file
5. `$%` refers to archive member
6. `$+` refers to all dependent files without removing duplicated file
7. `$*` refers to the stem which an implicit rule matches.

## Functions

### WildCard
`$(wildcard pattern)` will be replaced by a **space-seperated list of names of existing files that match one of the given patterns**.
1. pattern can be expanded to patterns, seperated by space. E.g. `$(wildcard *.c *.h)`
2. the results of this function are sortd when each individual expression is sorted separately.
3. **MOST IMPORTANT** existing files in the list will be used verbatim

### FindString
`$(findstring <find>, <in>)` will return string `<find>` if string `<in>` has substring `<find>`

### Subst
`$(subst from, to, text)` will replace each occurrence of `from` in `text` to `to`

### Word
`$(word n, text)` will return the `n`th word of text.
1. the legitimate values of n starts from 1.
2. if `n` is bigger that the number of word in `text`, the value is empty.

### Dir
`$(dir names)` will extract the directory-part of each file name in names. The directory-part of file name is everything up through(and including) the last slash in it.
1. If the file name contains no slash, the directory-part will be string "./".

### NotDir
`$(notdir names)` will **extract all but the directory-part** of each file name in names. 
1. If the file name contains no slash, it is left unchanged, otherwise everything through the last slash will be removed from it.
2. A file name that ends with slash will become an empty string.

### BaseName
`$(basename names)` will extract all but the suffix of each name in names.
1. If the file names contains a preiod, the basename is everything starting up tp tne last period, **the periods in directory part are ignored**

### Sort
`$(sort list)` will sort the words in  `list` in lexical oreder, **removing duplicate words**. The output is a list of words separated by single space.

## Add(Pre/Suf)fix
`$(addsuffix suffix, names)` will add suffix `suffix` to each of name in `names`, which are seperated by whitespace.
`$(addprefix prefix, names)` will add prefix `prefix` to each of name in `names`, which are seperated by whitespace.

### AbsPath
`$(abspath names)` will return an absolute name that doesnot contain any "." or ".." components, nor any repeated path separators("/") for each file name in `names`

### RealPath
`$(realpath names)` will return the canonical absolute name for each file name in `names`. **Symbolic links will be resolved**

### Join
`$(join list1, list2)` will concatenate the two arguments word by word, i.e. the nth word of result comes from the nth word of each argument.
1. if one arguments has more words than the other, the extra words are copied unchanged into result.
2. Whitespace between the words in the lists is not perserved and is replaced by single space.

### Flavor
`$(flavor variable)` will return a string that tells you the flavor of `variable`,
1. return string of "undefined" if `variable` was never defined
2. return string of "recursive" if `variable` was recursively expanded variable
3. return string of "simple" if `variable` was simply expanded variable

### Shell
`$(shell CMD)` will execute `CMD` in shell environment and return the stdout of the execution as result.

## Tricks

### Substraction 
We should use bash extension `$((A - B))` to make substraction. And in Makefile we **should use** `$$(($VAR1 -$VAR2))` to satisfy the syntax

### Test Without Run
`make -nB` will print out all the action without actually do the action

### Check whether a variable is null
Use `ifeq(<var>,)` to check whether variable `<var>` is null
