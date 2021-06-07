# Filetype behaviour
# ──────────────────
def filetype-hook -params 2 %{ hook global WinSetOption "filetype=(%arg{1})" %arg{2} }

filetype-hook man %{
   remove-highlighter window/number-lines
}

# Specify filetypes
# ─────────────────
hook global BufCreate .*kitty.conf|.*kitty/colors.conf|.*newsboat/.*|.*mimeapps.list|.*mopidy.conf %{
   set-option buffer filetype toml
}

hook global BufCreate .*dunstrc %{
   set-option buffer filetype yaml
}

hook global BufCreate .*\.gmi %{
   set-option buffer filetype markdown

   declare-user-mode sync
   map buffer user s ': enter-user-mode sync<ret>'    -docstring 'sync capsules'
   map buffer sync u ': | syncuveronunixcapsule<ret>' -docstring 'uveronunix.com'
   map buffer sync ~ ': | sync~uvercapsule<ret>'      -docstring 'tilde.chat/~uver'
}

hook global BufCreate .*sxhkdrc|.*profile|.*aliasrc %{
   set-option buffer filetype sh
}

hook global BufCreate .*fonts.conf %{
   set-option buffer filetype xml
}

# On save
# ───────
hook global BufWritePost .*\.tex %{
   nop %sh{
      pdflatex "$kak_buffile"
   }
}
