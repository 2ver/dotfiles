# Commands
# ────────
define-command clean-whitespace %{ execute-keys -draft '<percent>s^<space><plus>$<ret>d' }

define-command filetype %{
   execute-keys ':echo %opt{filetype}<ret>'
}
