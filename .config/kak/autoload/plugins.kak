# Plugin manager
# ──────────────

# source "%val{config}/plugins/plug.kak/rc/plug.kak"
# Download plugin manager if not installed
evaluate-commands %sh{
   plugins="$kak_config/plugins"
   mkdir -p "$plugins"
   [ ! -e "$plugins/plug.kak" ] && \
      git clone -q https://github.com/andreyorst/plug.kak.git "$plugins/plug.kak"
   printf "%s\n" "source '$plugins/plug.kak/rc/plug.kak'"
}

# Install plug.kak so it does not remove itself with 'plug-clean'
plug "andreyorst/plug.kak" noload

# Plugins
# ───────
 
# Auto close {}, (), etc.
plug "alexherbo2/auto-pairs.kak" demand auto-pairs %{
   hook global WinCreate .* %{ auto-pairs-enable }
}


# Better buffer management
plug "delapouite/kakoune-buffers" %{
map global normal b ': enter-buffers-mode<ret>' -docstring 'buffers'                       # Open buffer keybind menu
   map global normal B ': enter-user-mode -lock buffers<ret>' -docstring 'buffers (lock)' # Open buffer keybind menu with rapid mode enabled

}

# Highlight 'Z' marks
plug "Screwtapello/kakoune-mark-show" domain "gitlab.com" config %{
   mark-show-enable
   map global user Z ': set-register ^<ret>' -docstring 'clear saved marks'
}

# Open file at last edit
plug "Screwtapello/kakoune-state-save" domain "gitlab.com" config %{
   hook global KakBegin .* %{
      state-save-reg-load colon
      state-save-reg-load pipe
      state-save-reg-load slash
   }

   hook global KakEnd .* %{
      state-save-reg-save colon
      state-save-reg-save pipe
      state-save-reg-save slash
   }
}

# Use spaces instead of tabs for more consistency
plug "andreyorst/smarttab.kak" defer smarttab %{
   set-option global softtabstop %opt{indentwidth}
} config %{
   hook global WinSetOption filetype=(c|cpp|css|haskell|html|ini|kak|lisp|markdown|rust|sh|toml|txt|yaml|xml) expandtab
   hook global WinSetOption filetype=(makefile) noexpandtab
}
