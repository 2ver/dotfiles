# https://github.com/alexherbo2/configuration/blob/2d5bdd7264232819df01c92b4810d5aa0d4f9d5e/config/kak/autoload/chmod.kak#L5-L9
define-command chmod -params .. -docstring 'Change access permissions of the current file' %{
   nop %sh{
      chmod "$@" "$kak_buffile"
   }
}
