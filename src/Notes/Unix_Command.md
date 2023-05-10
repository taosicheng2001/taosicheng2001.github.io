# Unix_Command

## awk
Usage

`awk [options] 'selection_criteria {action}' input-file`

Option

- `-F` Specify a file seperator

## rsync
Usage 

`rsync [option] .. [SRC] [DEST] `

`[SRC]` and `[DEST]` can be extend to `[USER@]HOST:[SRC/DEST]`

Transfer file from src to dest

Option

- `-r` Transfer a directory 
- `-z` Compressed mode

## ldd
Usage

`ldd [option] path/to/binary`

Display shared library  dependencies of a binary

Option
- `--verbose` Display all information about dependencies
- `--unused` Display unused direct dependencies

