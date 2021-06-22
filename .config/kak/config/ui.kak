# UI configuration
# ────────────────
set-option global startup_info_version 20200901464                            # Hide change notes on startup
set-option global tabstop 3                                                   # Width of a tab
set-option global indentwidth 3                                               # Indent with 3 spaces
set-option global scrolloff 99,99                                             # Center cursor
set-option global ui_options ncurses_assistant=off ncurses_status_on_top=true # Disable clippy
set-option global autoreload yes                                              # Live reload
set-option global writemethod replace                                         # Live reload method
set-option global modelinefmt '{{mode_info}} {magenta}%val{bufname}{default} {green}%val{client}{default}/{yellow}%val{session}{default} {{context_info}}'

# Blank scratch buffer
hook -group delete-scratch-message global BufCreate '\Q*scratch*' %{
   execute-keys '%d'
}

# Color TODO, NOTE, etc. separately
hook global WinSetOption comment_line=(.*) %{
    add-highlighter -override window/todo regex "\Q%val{hook_param_capture_1}\E\h*(TODO:|FIXME:|NOTE:|XXX:)[^\n]*" 1:rgb:21c0d5+Fb
}

# Make search results bold
hook global RegisterModified '/' %{ add-highlighter -override global/search regex "%reg{/}" 0:+b }

# Global highlighters
#add-highlighter global/ wrap -word -indent -marker ↳
#add-highlighter global/ regex \h+$ 0:Error	# Highlight trailing whitespace

# Line numbers
hook global WinCreate (?!/tmp/[.]nnn)[^*]+ %{
   add-highlighter window/relative-line-numbers number-lines -relative -separator '  '
}

# Highlight matching brackets
hook global WinCreate .* %{
	add-highlighter window/ show-matching
}

# Theme
# ─────
colorscheme lena

# Change selection colors in insert mode
hook global ModeChange .*:.*:insert %{
   set-face window PrimarySelection black,rgb:bfbfbf+F
   set-face window SecondarySelection black,rgb:bfbfbf+u
   set-face window PrimaryCursor black,rgb:E4E4DF+b
   set-face window SecondaryCursor black,rgb:E4E4DF+u
   set-face window PrimaryCursorEol black,rgb:E4E4DF+b
   set-face window SecondaryCursorEol black,rgb:E4E4DF+u
}

# Revert cursor colors after reentering normal mode
hook global ModeChange .*:insert:.* %{
   unset-face window PrimarySelection
   unset-face window SecondarySelection
   unset-face window PrimaryCursor
   unset-face window SecondaryCursor
   unset-face window PrimaryCursorEol
   unset-face window SecondaryCursorEol
}
