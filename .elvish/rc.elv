use re   # Regular expression functions
use path # Path manipulation functions
use str  # String manipulation
use math # Math operation

# Executable paths
paths = [
   $E:GOPATH/bin
	/usr/local/bin
	/usr/local/sbin
	/usr/sbin
	/sbin
	/usr/bin
	/bin
]

# Check paths' existence
# https://zzamboni.org/post/my-elvish-configuration-with-commentary/
each [p]{
  if (not (path:is-dir (or (_ = ?(path:eval-symlinks $p)) $p))) {
    echo (styled "Warning: directory "$p" in $paths no longer exists." red)
  }
} $paths

# Packages
use epm

epm:install &silent-if-installed			^
github.com/zzamboni/elvish-modules		^
github.com/zzamboni/elvish-completions ^
github.com/iwoloschin/elvish-packages 	^
github.com/muesli/elvish-libs

# General settings
edit:insert:binding[Alt-i] = $edit:-instant:start~
edit:max-height = 20

# Completions
use github.com/zzamboni/elvish-completions/builtins
use github.com/zzamboni/elvish-completions/cd
use github.com/zzamboni/elvish-completions/git
use github.com/zzamboni/elvish-completions/ssh

use github.com/zzamboni/elvish-modules/bang-bang # Enable !! & !$
use github.com/muesli/elvish-libs/git # Git utilities

# Notify if new commits
use github.com/iwoloschin/elvish-packages/update
update:curl-timeout = 3
update:check-commit &verbose

# Environment variables
E:LC_ALL = "en_US.UTF-8"

# Aliases
fn ls [@a]{ e:ls --color $@a  }
fn grep [@a]{ e:grep --color $@a }
fn diff [@a]{ e:diff --color $@a }
fn ka [@a]{ e:killall $@a }
fn g [@a]{ e:git $@a }
fn pac [@a]{ e:doas pacman $@a }
fn icat [@a]{ e:kitty +kitten icat $@a }
fn config [@a]{ e:/usr/bin/git --git-dir=/home/uver/.cfg/ --work-tree=/home/uver $@a }

# Prompt
edit:prompt = { tilde-abbr $pwd; styled ' ❱ ' blue }
edit:prompt-stale-transform = [x]{ styled $x "bright-black" }
# edit:prompt-stale-transform = $all~
edit:-prompt-eagerness = 10
edit:rprompt = { } # Disable right-side prompt

# Smart case in completion
edit:completion:matcher[''] = [p]{ edit:match-prefix &smart-case $p }
