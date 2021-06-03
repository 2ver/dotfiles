# Behaviour based on filetype
# ────────────────────────────
def filetype-hook -params 2 %{ hook global WinSetOption "filetype=(%arg{1})" %arg{2} }

filetype-hook man %{
   remove-highlighter window/number-lines
}

# Specify filetypes for files
# ───────────────────────────
hook global BufCreate .*kitty[.]conf|.*newsboat/.* %{
   set-option buffer filetype toml
}

hook global BufCreate .*dunstrc|.*mopidy.conf %{
   set-option buffer filetype yaml
}

hook global BufCreate .*\.gmi %{
   set-option buffer filetype markdown

   declare-user-mode sync
   map buffer user s ': enter-user-mode sync<ret>' -docstring 'sync capsules'
   map buffer sync u ': | syncuveronunixcapsule<ret>' -docstring 'uveronunix.com'
   map buffer sync ~ ': | sync~uvercapsule<ret>' -docstring 'tilde.chat/~uver'

   # source "%val{config}/privatecapsule.kak"
}

hook global BufCreate .*sxhkdrc|.*\.elv %{
   set-option buffer filetype sh
}

# On save
# ───────
hook global BufWritePost .*\.tex %{
   nop %sh{
      pdflatex "$kak_buffile"
   }
}
