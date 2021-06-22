hook global BufCreate .*/capsules/uveronunix/.* %{
   map buffer user s ': | syncuveronunixcapsule<ret>' -docstring 'sync uveronunix.com'
}

hook global BufCreate .*/capsules/~uver/.* %{
   map buffer user s ': | sync~uvercapsule<ret>' -docstring 'sync tilde.chat/~uver'
}
