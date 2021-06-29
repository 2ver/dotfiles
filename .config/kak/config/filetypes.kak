# Filetype behaviour
# ──────────────────
def filetype-hook -params 2 %{ hook global WinSetOption "filetype=(%arg{1})" %arg{2} }

# filetype-hook man %{
#    remove-highlighter window/number-lines
# }

# filetype-hook haskell %{
#    set-option buffer comment_block_begin '{-'
#    set-option buffer comment_block_end '-}'
# }

# Specify filetypes
# ─────────────────
hook global BufCreate .*kitty.conf|.*kitty/colors.conf|.*newsboat/.*|.*mimeapps.list|.*mopidy.conf|.*[.]ncmpcpp/.* %{
   set-option buffer filetype toml
}

hook global BufCreate .*dunstrc %{
   set-option buffer filetype yaml
}

hook global BufCreate .*[.]gmi %{
   set-option buffer filetype markdown
}

hook global BufCreate .*profile|.*aliasrc|.*bspwmrc %{
   set-option buffer filetype sh
}

hook global BufCreate .*fonts.conf %{
   set-option buffer filetype xml
}

hook global BufCreate .*Xresources %{
   set-option buffer comment_line '!'
}

# hook global BufCreate .*Xresources %{
#    set-option buffer comment_line '!'
# }

# On save
# ───────
hook global BufWritePost .*\.tex %{
   nop %sh{
      pdflatex "$kak_buffile"
   }
}
