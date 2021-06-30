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

      # enable-auto-pairs

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

      ## Mappings

      # External windows/tools
      map global normal <c-n>    ': new<ret>'                                                   -docstring 'New client'
      # map global normal <c-t>    'something'
      map global normal <a-ret>  ': connect-terminal elvish<ret>'                               -docstring 'New terminal'
      map global normal +        ': connect-popup elvish<ret>'                                  -docstring 'New popup'
      map global normal <a-+>    ': connect-overlay elvish<ret>'                                -docstring 'Overlay program'
      map global normal <c-o>    ': $ pcmanfm %sh{echo "${@:-$(dirname "$kak_buffile")}"}<ret>' -docstring 'Open pcmanfm'

      # Selections & Movement
      map global normal <a-down> ': move-lines-down<ret>'                                       -docstring 'move line down'
      map global normal <a-up>   ': move-lines-up<ret>'                                         -docstring 'move line up'

      # View
      map global view   p        '<esc>: show-palette<ret>'                                      -docstring 'show palette'

      # General
      map global normal <F5>     ': source-kakrc; echo reloaded kakrc<ret>'                      -docstring 'reload kakrc'

   } catch %{
      echo -debug 'failed to initialize kakoune.cr'
   }
}
