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

# Elvish integration
plug "elvish.kak" domain "git.tchncs.de"

# Better buffer management
plug "delapouite/kakoune-buffers" %{
   map global normal b      ': enter-buffers-mode<ret>'            -docstring 'buffers'        # Open buffer keybind menu
   map global normal B      ': enter-user-mode -lock buffers<ret>' -docstring 'buffers (lock)' # Open buffer keybind menu with rapid mode enabled
   map global buffers k     ': buffer-next<ret>'                   -docstring 'next'           # Switch to next buffer
   map global buffers <a-k> ': buffer-previous<ret>'               -docstring 'prev'           # Switch to previous buffer
   map global buffers x     ': buffer-only<ret>'                   -docstring 'only'           # Delete other buffers
   map global buffers n     ': buffer-first<ret>'                  -docstring 'first'          # Switch to first buffer
   map global buffers o     ': buffer-last<ret>'                   -docstring 'last'           # Switch to last buffer
   map global buffers i     ': buffer-by-index '                   -docstring 'index'          # Switch to buffer by index
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

# Scrollbar (shows offscreen selections)
plug "sawdust-and-diamonds/scrollbar.kak" do %{
   make kak-calc-scrollbar
} config %{
   hook global WinCreate [^*]+ %{ scrollbar-enable }
   set-face global Scrollbar rgb:394354,default
   set-face global ScrollbarSel rgb:53e2ae,rgb:394354
   set-face global ScrollbarHL rgb:a1efd3,default
   set-option global scrollbar_char "█"
   set-option global scrollbar_sel_char "•"
}

# Use spaces instead of tabs for more consistency
plug "andreyorst/smarttab.kak" defer smarttab %{
   set-option global softtabstop %opt{indentwidth}
} config %{
   hook global WinSetOption filetype=(c|cpp|css|elvish|haskell|html|ini|kak|lisp|markdown|python|rust|sh|toml|txt|yaml|xml) expandtab
   hook global WinSetOption filetype=(makefile) noexpandtab
}

# Syntax highlighting for sxhkdrc
plug "jwhett/sxhkdrc-kak"
