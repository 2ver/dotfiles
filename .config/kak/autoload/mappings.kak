# Keymappings
# ───────────

# Colemak bindings
map global normal n     h     # Select left
map global normal N     H     # Extend left
map global normal <a-n> <a-h> # Select to beginning of line
map global normal <a-N> <a-H> # Extend to beginning of line
map global normal e     j     # Select down
map global normal E     J     # Extend down
map global normal <a-e> <a-j> # Join lines
map global normal <a-E> <a-J> # Join lines and select spaces
map global normal i     k     # Select up
map global normal I     K     # Extend up
map global normal <a-i> <a-k> # Keep selections matching regex
map global normal <a-I> <a-K> # Keep selections not matching regex
map global normal o     l     # Select right
map global normal O     L     # Extend right
map global normal <a-o> <a-l> # Select to end of line
map global normal <a-O> <a-L> # Extend to end of line

# Remap displaced keys
map global normal h     i     # Insert mode
map global normal <a-h> <a-i> # Keep matching
map global normal H     I     # Insert at beginning of line
map global normal j     e     # End of word
map global normal J     E     # Keep selecting to end of word
map global normal k     n     # Search next
map global normal <a-k> <a-n> # Search previous
map global normal K     N     # Select to next search
map global normal l     o     # New line below
map global normal L     O     # New line above

# Colemak navigation in goto mode
map global goto n h # Move cursor to beginning of line
map global goto e j # Move cursor to end of file
map global goto i k # Move cursor to beginning of file
map global goto o l # Move cursor to end of line

# Switch macros to ^
map global normal ^     q # Replay macro
map global normal <a-^> Q # Start/end macro recording

# Move back by word to q
map global normal q     b     # Select by word backward
map global normal Q     B     # Extend by word backward
map global normal <a-q> <a-b> # Select by WORD backward
map global normal <a-Q> <a-B> # Extend by WORD backward

# Buffer switching mode
map global buffers k 	 ': buffer-next<ret>'     -docstring 'next'     # Switch to next buffer
map global buffers <a-k> ': buffer-previous<ret>' -docstring 'prev' # Switch to previous buffer
map global buffers x 	 ': buffer-only<ret>'     -docstring 'only'     # Delete other buffers
map global buffers n 	 ': buffer-first<ret>'    -docstring 'first'   # Switch to first buffer
map global buffers o 	 ': buffer-last<ret>'     -docstring 'last'     # Switch to last buffer
map global buffers i 	 ': buffer-by-index '     -docstring 'index'    # Switch to buffer by index

# Exit normal mode with ii
hook global InsertChar i %{ try %{
  exec -draft hH <a-k>ii<ret> d
  exec -with-hooks <esc>
}}

# Leader key
map global normal <space> ,       # Set space to leader key
map global normal ,       <space> # Remove all selections but main
map global normal <a-,>   <space> # Remove main selection

# Global clipboard mappings
map global user y '<a-|> xsel -i -b<ret>'                                                   -docstring 'yank the selection into the clipboard' 
map global user p '<a-!> xsel<ret>'                                                         -docstring 'paste the clipboard'
map global user r '|xclip -i -selection clipboard<ret>; xclip -o -selection clipboard<ret>' -docstring 'replace from clipboard'

# Shortcuts to exit
map global user w ': w<ret>'  -docstring 'write'          # Save
map global user q ': q<ret>'  -docstring 'quit'           # Quit
map global user z ': wq<ret>' -docstring 'write and quit' # Save and quit

# Comment line
map global normal '#' ': comment-line<ret>'      -docstring 'Comment line'  # Comment selected line(s)
map global normal '<a-#>' ': comment-block<ret>' -docstring 'Comment block' # Comment selected block

# Source selection
map global user . ': <c-r>.<ret>' -docstring 'source selection' 

# Toggle scrolloff value
map global normal <backspace> ': eval %sh{ if [ "$kak_opt_scrolloff" = 0,0 ]; then offset=99,99; else offset=0,0; fi; echo set-option buffer scrolloff $offset }<ret>'

# Autocomplete to buffer directory in :e
map global prompt -docstring 'Expand to the buffer directory' <a-.> '%sh(dirname "$kak_buffile")<a-!>'

# LSP user mode
map global user l ': enter-user-mode lsp<ret>' -docstring 'LSP mode'

# Select everything matching selection
map global normal -docstring 'Select all occurrences of the current selection set' <a-percent> '*%s<ret>'

# TODO: Smart case search

# map global prompt -docstring 'Case insensitive search' <a-i> '<home>(?i)<end>'

# map global user '/' %{
# 	:try %{
#    	exec -save-regs '' <lt>a-k>[A-Z]<lt>ret>*
#  	} catch %{
#     	exec -save-regs '' */(?i)<lt>c-r>/<lt>ret>
#  	}<ret>
# }

# 'x' extends down and 'X' extends selection up
# def -params 1 extend-line-down %{
#   exec "<a-:>%arg{1}X"
# }
# def -params 1 extend-line-up %{
#   exec "<a-:><a-;>%arg{1}K<a-;>"
#     try %{
#       exec -draft ';<a-K>\n<ret>'
#       exec X
#     }
#     exec '<a-;><a-X>'
# }
# map global normal x ': extend-line-down %val{count}<ret>' -docstring 'Extend selection down' # Down
# map global normal X ': extend-line-up %val{count}<ret>'   -docstring 'Extend selection up'   # Up

# TODO: Open corresponding pdf to LaTeX file
map global user v -docstring 'open pdf file corresponding to current LaTeX project' '| zathura "$kak_pwd"/*\.pdf'
