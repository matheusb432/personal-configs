# Vim Commands

- Legend:

  - `CH`: character
  - `TXT`: text
  - `N`: number
  - `C`: control key
  - `_`: motion
  - `>E`: press enter key

- `x` - Delete CH under cursor
- `d_` - Delete
- `dd` - Delete line
- `u` - Undo
- `U` - Undo all changes on line
- `y` - Yank (copy) text
- `C+r` - Redo
- `p` - Paste after cursor, works with previous deletions
- `rCH` - Replace character under cursor with CH
- `R` - Enter replace mode
- `c_N` - Change until motion N times and insert
- `C+o` - Return to previous location
- `C+i` - Return to next location
- `C+u` - Move up one half page
- `C+d` - move down half a page

- `/TXT>E` - Search for TXT

  - `n` - Next match
  - `N` - Previous match
  - `:set ic` - Ignore case
  - `:set noic` - Don't ignore case
  - `:set hls` - Highlight search
  - `:set nohls` - Don't highlight search
  - `:let @/ = ""` - Clear search

- `?TXT>E` - Search backwards for TXT
- `%` - Move to matching `(, [, {`, etc.

- `:s`

  - `:s/old/new` - Replace first `old` with `new` in a line
  - `:s/old/new/g` - Replace all `old` with `new` in a line
  - `:%s/old/new/g` - Replace all `old` with `new` in a file
  - `:%s/old/new/gc` - Replace all `old` with `new` in a file with confirmation

- `o|O` - Open line below|above cursor

# Vim Motions

- `h|j|k|l` - Move cursor left, down, up, right
- `w|b` - Move cursor forward, backward by word
- `e|E` - Move cursor to end of word | with punctuation
- `0` - Move to beginning of line
- `^` - Move to first non-blank character of line
- `$` - Move to end of line
- `g_` - Move to last non-blank character of line
- `gg` - Move to beginning of file
- `ggN` - Move to line N
- `G` - Move to end of file

# Vim Insert Mode Commands

- `i` - Insert before cursor
- `I` - Insert at beginning of line
- `a` - Insert after cursor
- `A` - Insert at end of line

# Vim Visual Mode Commands

- `v` - Start visual mode

# Vim Window Commands

- `:q` - Quit window
- `:q!` - Quit without saving
- `:qa` - Quit all windows
- `:w` - Write (save)
- `:wa` - Save all windows
- `:wq` - Write and quit (save and quit)
- `:!` - Run shell command
  - `:C+d` - trigger auto-complete
- `:set inv_` - Invert setting (e.g. `:set invhls`)
- `C+w` - Window mode
- `C+wC+w` - Switch windows
- `<leader><leader>w` - Easy motion window mode
- `ciw` - Change inner word

- `:mks proj.vim` - Save current session to `proj.vim`
- `nvim -S proj.vim` - Open `proj.vim` session
- `:mks!` - Overwrite current session file

- `:cd` - Change directory
- `:cd %:p:h` - Change directory to current file directory
