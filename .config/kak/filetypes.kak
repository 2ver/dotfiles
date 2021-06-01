# Behaviour based on filetype
# ────────────────────────────
def filetype-hook -params 2 %{ hook global WinSetOption "filetype=(%arg{1})" %arg{2} }

filetype-hook man %{
   remove-highlighter window/number-lines
}

# Specify filetypes for files
# ───────────────────────────
hook global BufCreate .*kitty[.]conf %{
   set-option buffer filetype ini
}

hook global BufCreate .*dunstrc %{
   set-option buffer filetype yaml
}

hook global BufCreate .*mopidy.conf %{
   set-option buffer filetype ini
   # set-option buffer filetype toml
}

hook global BufCreate .*\.gmi %{
   set-option buffer filetype markdown
}

hook global BufCreate .*\.elv %{
   set-option buffer filetype sh
}

hook global BufCreate .*sxhkdrc %{
   set-option buffer filetype sh
}

# On save
# ───────
hook global BufWritePost .*\.tex %{
   nop %sh{
      pdflatex "$kak_buffile"
   }
}
