# Tricks

## Vim Autocmd
add `autocmd BufWritePost *.md !command` into `.vimrc`. 

- `command` will be executed whenever markdown file is written by vim.
- use `%` to refer the path of markdown file

## Vim Deletion
- `dw` delete from cursor to begin of the next word
- `de` delete from cursor to end of the current word
- `d$` delete from cursor to end of the current line
- `dNw` delete N word from curosr

## Vim Cursor Jump
- `Nw` cursor jump N word backword(to the beginng of the word)
- `Ne` cursor jump N word backword(to the end of the word)
- `0` cursor jump to the beginning of the line
- `$` cursor jump to the end of the line
- `G` cursor jump to end of file
- `gg` cursor jump to beginnging of the file
- `CTRL+O` cursor jump to the last position

## Vim Command
- `p` put previous deleted text after the cursor
- `rx` replace the charactor from cursor with x 
- `ce` delete the word from cursor and enter INSERT mode
- `cc` delete the whole line from cursor and enter INSERT mode

## Vim Search
- `%` match ([{ from current cursor
- `s/old/new/` subst old with new. Only change the first occurence of line
- `s/old/new/g` subst old with new. Change all occurence in file

## Vim Newline
- `o` open up a newline below cursor
- `O` open up a newline above cursor
