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

use epm

# Color ls
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
# edit:rprompt = 

# Smart case in completion
edit:completion:matcher[''] = [p]{ edit:match-prefix &smart-case $p }
