# Tricks

## Vim Autocmd
add `autocmd BufWritePost *.md !command` into `.vimrc`. 

- `command` will be executed whenever markdown file is written by vim.
- use `%` to refer the path of markdown file
