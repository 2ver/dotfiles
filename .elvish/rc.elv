use re   # Regular expression functions
use path # Path manipulation functions
use str  # String manipulation
use math # Math operation

# Executable paths
paths = [
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

epm:install &silent-if-installed       ^
github.com/zzamboni/elvish-modules     ^
github.com/zzamboni/elvish-completions ^
github.com/zzamboni/elvish-themes      ^
github.com/iwoloschin/elvish-packages  ^
github.com/muesli/elvish-libs

# General settings
edit:max-height = 20

# Key bindings
use readline-binding

edit:insert:binding[Alt-i] = $edit:-instant:start~
# edit:insert:binding[Ctrl-l] = { clear > /dev/tty; edit:redraw &full=$true }
# edit:insert:binding[Ctrl-l] = { clear > /dev/tty; edit:clear }

edit:navigation:binding[n] = { edit:navigation:left }
edit:navigation:binding[e] = { edit:navigation:down}
edit:navigation:binding[i] = { edit:navigation:up }
edit:navigation:binding[o] = { edit:navigation:right }
edit:navigation:binding[Ctrl-d] = { edit:navigation:page-down }
edit:navigation:binding[Ctrl-u] = { edit:navigation:page-up}

# Completions
use github.com/zzamboni/elvish-completions/builtins
use github.com/zzamboni/elvish-completions/cd
use github.com/zzamboni/elvish-completions/git
use github.com/zzamboni/elvish-completions/ssh
edit:completion:matcher[''] = [p]{ edit:match-prefix &smart-case $p } # Smart case in completion

use github.com/zzamboni/elvish-modules/bang-bang # Enable !! & !$
use github.com/muesli/elvish-libs/git            # Git utilities

# Notify if new commits
# use github.com/iwoloschin/elvish-packages/update
# update:curl-timeout = 3
# update:check-commit &verbose

## Environment variables
E:LC_ALL = "en_US.UTF-8"
E:PAGER = "kak-pager"
E:MANPAGER = "kak-man-pager"
E:EDITOR = "kcr edit"
E:VISUAL = "kcr edit"
E:SXHKD_SHELL = "elvish"
# E:KAKOUNE_CONFIG_DIR = "src/kak-example"

# E:XDG_CONFIG_HOME = $E:HOME"/cfg"
# E:XDG_CACHE_HOME = $E:HOME"/tmp"
# E:XDG_DATA_HOME = $E:HOME"/.local/share"

E:LESSHISTFILE = "-"
# E:GNUPGHOME = $E:XDG_DATA_HOME"/gnupg/"
# E:HISTFILE = $E:XDG_DATA_HOME"/bash/history"
# E:ncmpcpp_directory = $E:XDG_CACHE_HOME"/ncmpcpp/" # Move error.log

# nnn
E:NNN_BMS = "h:~;d:~/usr/doc;D:~/usr/dwn;v:~/usr/vid;p:~/usr/pic;w:~/usr/pic/Wallpapers/;c:~/cfg"
E:NNN_PLUG = "t:_|kitty*;m:_|mpv $nnn*;g:_|gimp $nnn*;d:dragdrop;p:getplugs;3:mp3conv;n:nuke;r:_|doasedit $nnn*"
E:NNN_COLORS = "5"
var BLK = c1 ; var CHR = e2 ; var DIR = 04 ; var EXE = 02 ; var REG = 07 ; var HARDLINK = 0e ; var SYMLINK = 0c ; var MISSING = f7 ; var ORPHAN = 01 ; var FIFO = ab ; var SOCK = 09 ; var OTHER = c4
E:NNN_FCOLORS = $BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER


## Aliases
# fn sudo [@a]{ e:doas $@a }
fn ls     [@a]{ e:ls --color $@a }
fn grep   [@a]{ e:grep --color $@a }
fn diff   [@a]{ e:diff --color $@a }
fn ka     [@a]{ e:killall $@a }
# fn g      [@a]{ e:git $@a }
fn pac    [@a]{ e:doas pacman $@a }
fn icat   [@a]{ e:kitty +kitten icat $@a }
fn config [@a]{ e:/usr/bin/git --git-dir=/home/uver/.cfg/ --work-tree=/home/uver $@a }
fn n      [@a]{ e:nnn -nR $@a }
# fn ncmpcpp [@a]{ e:ncmpcpp ncmpcpp_directory=$E:XDG_CONFIG_HOME/ncmpcpp/data/ $@a }

# pijul
fn pj     [@a]{ e:pijul $@a }
fn pa     [@a]{ e:pijul add $@a }
fn pR     [@a]{ e:pijul record $@a }
fn pp     [@a]{ e:pijul push $@a }

# kakoune.cr
fn k   [@a]{ e:kcr edit $@a }
fn ks  [@a]{ e:kcr shell --session $@a }
fn kl  [@a]{ e:kcr list $@a }
fn a   [@a]{ e:kcr attach $@a }
fn kcd [@a]{ e:cd (kcr get --raw --shell pwd) $@a }
fn cdk [@a]{ e:kcr send cd $E:PWD $@a }

fn K   [@a]{ e:kcr-fzf-shell $@a }
fn KK  [@a]{ e:K --working-directory . $@a }

## Abbreviations
edit:abbr['~c'] 	= $E:XDG_CONFIG_HOME"/"
edit:abbr['~C'] 	= "~/src/capsules/"
edit:abbr['~d'] 	= "~/usr/doc/"
edit:abbr['~D'] 	= "~/usr/dwn/"
edit:abbr['~k'] 	= $E:XDG_CONFIG_HOME"/kak/"
edit:abbr['~mll'] = "~/usr/muz/music/all/lossless/"
edit:abbr['~mly'] = "~/usr/muz/music/all/lossy"
edit:abbr['~ma']	= "~/usr/muz/music/all/"
edit:abbr['~mp']  = "~/usr/muz/music/playlists/"
edit:abbr['~md']	= "~/usr/muz/music/downloads/"
edit:abbr['~mu']	= "~/usr/muz/music/unorganized/"
edit:abbr['~M']	= "~/usr/muz/music/"
edit:abbr['~p'] 	= "~/usr/pic/"
edit:abbr['~v'] 	= "~/usr/vid/"
edit:abbr['~w'] 	= "~/src/websites/"

# Prompt
edit:-prompt-eagerness = 10
edit:prompt-stale-transform = [x]{ styled $x "bright-black" }
# edit:prompt-stale-transform = $all~

# Chain
use github.com/zzamboni/elvish-themes/chain
chain:init

# Styling
chain:glyph[chain] = " "
chain:glyph[arrow] = "❱"
chain:glyph[git-branch] = ""

chain:bold-prompt = $true
chain:prompt-segment-delimiters = [ "" "" ]

# Colors
chain:segment-style[dir] = magenta
chain:segment-style[arrow] = blue
chain:segment-style[git-branch] = green
chain:segment-style[git-staged] = yellow
chain:segment-style[git-untracked] = red
chain:segment-style[git-deleted] = red
chain:segment-style[git-ahead] = yellow
chain:segment-style[git-behind] = yellow

# Default prompt
# edit:prompt = { tilde-abbr $pwd; styled ' ❱ ' blue }
# edit:rprompt = { } # Disable right-side prompt
