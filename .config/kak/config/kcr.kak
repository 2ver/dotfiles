# Install kcr
# plug "alexherbo2/kakoune.cr" demand kakoune.cr do %{
plug "alexherbo2/kakoune.cr" do %{
   make install
} config %{
   # Check if binary exists
   try %{
      evaluate-commands %sh{
         if command -v kcr >/dev/null; then
            echo 'nop'
         else
            echo 'echo -debug "kcr binary missing"'
            echo 'fail'
         fi
      }

      evaluate-commands %sh{
         kcr init kakoune
      }

      # https://github.com/Parasrah/kitty.kak/blob/master/rc/kitty.kak#L5-L12
      define-command kitty-popup -params 1.. -shell-completion -docstring '
      kitty-terminal <program> [<arguments>]: create a new terminal as a kitty window
      The program passed as argument will be executed in the new terminal' \
      %{
         nop %sh{
            # kitty @ --to=$kak_client_env_KITTY_LISTEN_ON new-window --no-response --window-type $kak_opt_kitty_window_type --cwd "$PWD" "$@"
            kitty @ --to=$kak_client_env_KITTY_LISTEN_ON new-window --no-response --cwd "$PWD" "$@"
         }
      }


      # https://github.com/Parasrah/kitty.kak/blob/master/rc/kitty.kak#L14-L21
      define-command kitty-overlay -params 1.. -shell-completion -docstring '
      kitty-overlay <program> [<arguments>]: create a new terminal as a kitty overlay
      The program passed as argument will be executed in the new terminal' \
      %{
         nop %sh{
            kitty @ --to=$kak_client_env_KITTY_LISTEN_ON launch --type overlay --cwd "$PWD" "$@"
         }
      }
      alias global connect-overlay kitty-overlay

      # Set terminal to kitty
      hook global ModuleLoaded x11 %{
         alias global terminal x11-terminal
         alias global popup kitty-popup
      }

      # Commands
      define-command nnn-persistent -params 0..1 -file-completion -docstring 'Open file with nnn' %{
         connect-popup nnn %sh{echo "${@:-$(dirname "$kak_buffile")}"}
      }

      # Mappings
      map -docstring 'New client' global normal <c-e> ': new<ret>'
      map -docstring 'New terminal' global normal <c-n> ': connect-terminal elvish<ret>'
      # map -docstring 'New popup' global normal + ': connect-popup<ret>'
      map -docstring 'New popup' global normal + ': connect-popup elvish<ret>'
      # map -docstring 'New popup' global normal + ': kitty-popup<ret>'
      map -docstring 'Overlay program' global normal <c-t> ': connect-overlay elvish<ret>'
      map -docstring 'Open pcmanfm' global normal <c-o> ': $ pcmanfm %sh{echo "${@:-$(dirname "$kak_buffile")}"}<ret>'

   } catch %{
      echo -debug 'failed to initialize kakoune.cr'
   }
}
