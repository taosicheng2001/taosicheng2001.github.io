# Unix_Command

## awk
Usage

`awk [options] 'selection_criteria {action}' input-file`

Option

- `-F` Specify a file seperator
- `/pattern/` Make a pattern match

## tr
Usage

`tr [OPTION]... SET1 [SET2] IN`

Translate all occurrences of SET1 in IN to SET2 

Option
- `-d` delete characters in SET1 rather than translate

## rsync
Usage 

`rsync [option] .. [SRC] [DEST] `

`[SRC]` and `[DEST]` can be extend to `[USER@]HOST:[SRC/DEST]`

Transfer file from src to dest

Option

- `-r` Transfer a directory 
- `-z` Compressed mode

## find
Usage

`find path/to/file [Option]`

Find and display the result according to the params

Option
- `-name Pattern` Find files that fit the pattern
- `-o` use between two -name options to OR the selection

## ld

`ld [options] objfile`

Combines a number of object and archive files, relocate their data and ties up symbol table references.

Options
- `-z keyword` Specify feature according to `keyword`
- `-T scriptfile` Use `scriptfile` as the linker script 
- `-defsym=symbol=expression` Create a global `symbol` in the output file, containing the absolute address given by `expression`
- `-e entry` Use `entry` as the explicit symbol for beginning of your program
- `-N` Set the text and data sections to be readable and writable.
- `--start-group archives --end-group` Search all the archives until all possible references are resolved

## ldd
Usage

`ldd [option] path/to/binary`

Display shared library  dependencies of a binary

Option
- `--verbose` Display all information about dependencies
- `--unused` Display unused direct dependencies

## ar

`ar p[mod] [--output dirname] archive [member...]`

Creates, modifies and extracts from archives.

Option
- `rcs` replace or insert archive member, create or update Archive File, create or update archive member symbol table.

## make
Usage

`make [OPTION]... [TARGET]...`

Makefile command

Option
- `-C dir` Change to directory `dir` before reading the makefiles or doing something else. **If multiple -C option are specified**, each is interpreted relative to previous one.
- `-s` Silent operation, do not print the command as they are executed
- `-f file` Use `file` as makefile to run
