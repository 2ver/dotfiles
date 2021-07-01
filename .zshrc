# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/uver/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="spaceship"

unsetopt PROMPT_SP

SPACESHIP_PROMPT_ORDER=(
	user
	dir
	git
   rust
	line_sep
	vi_mode
	char
)

SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_PROMPT_PREFIXES_SHOW=true
SPACESHIP_PROMPT_SUFFIXES_SHOW=true
SPACESHIP_PROMPT_DEFAULT_PREFIX='via '
SPACESHIP_CHAR_SYMBOL='❯ '
SPACESHIP_CHAR_COLOR_SUCCESS=4
SPACESHIP_CHAR_COLOR_FAILURE=1
SPACESHIP_USER_SHOW=false
SPACESHIP_HOST_SHOW=false
SPACESHIP_DIR_COLOR=5
SPACESHIP_GIT_PREFIX='on '
#SPACESHIP_GIT_STATUS_PREFIX=' ❰'
SPACESHIP_GIT_STATUS_PREFIX=' ❬'
#SPACESHIP_GIT_STATUS_SUFFIX='❱'
SPACESHIP_GIT_STATUS_SUFFIX='❭'
SPACESHIP_GIT_STATUS_COLOR=9
SPACESHIP_RUST_COLOR=10
SPACESHIP_VI_MODE_SHOW=false

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder


# Kitty zsh integration
autoload -Uz compinit
compinit
kitty + complete setup zsh | source /dev/stdin

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	vi-mode
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source /home/uver/.aliasrc
source $ZSH/oh-my-zsh.sh

# User configuration

# Change cursor shape in vi-mode
#_fix_cursor() {
#	echo -ne '\e[4 q'
#}
#precmd_functions+=(_fix_cursor)

bindkey -v
export KEYTIMEOUT=20

# Colemak bindings
bindkey -M viins 'ii' vi-cmd-mode

bindkey -a n backward-char
bindkey -a e down-history
bindkey -a E vi-join
bindkey -a i up-history
bindkey -a o forward-char

bindkey -a h vi-insert
bindkey -a H vi-insert-bol
bindkey -a j vi-backward-word
bindkey -a J vi-backward-blank-word
bindkey -a k vi-repeat-search
bindkey -a K vi-rev-repeat-search
bindkey -a l vi-open-line-below
bindkey -a L vi-open-line-above
bindkey -a q vi-backward-word
bindkey -a Q vi-backward-blank-word

bindkey -M menuselect 'n' vi-backward-char
bindkey -M menuselect 'e' vi-down-line-or-history
bindkey -M menuselect 'i' vi-up-line-or-history
bindkey -M menuselect 'o' vi-forward-char

function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] ||
		 [[ $1 = 'block' ]]; then
		echo -ne '\e[2 q'
	elif [[ ${KEYMAP} == main ]] ||
			 [[ ${KEYMAP} == viins ]] ||
			 [[ ${KEYMAP} = '' ]] ||
			 [[ $1 = 'beam' ]]; then
		echo -ne '\e[4 q'
	fi
}
zle -N zle-keymap-select
zle-line-init() {
	zle -K viins
	echo -ne "\e[4 q"
}
zle -N zle-line-init
echo -ne '\e[4 q'
preexe() { echo -ne '\e[4 q' ;}

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# export MANPATH="/usr/local/man:$MANPATH"

# Manpager
# Use bat as manpager
#export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Use vim as manpager
#export MANPAGER='/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'

# Use kak as manpager
PAGER=kak-pager
MANPAGER=kak-man-pager

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Functions
colors()
{
   for COLOR in {1..255}; do echo -en "\e[38;5;${COLOR}m${COLOR} "; done; echo;
}

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias config='/usr/bin/git --git-dir=/home/uver/.cfg/ --work-tree=/home/uver'

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_STYLES[alias]='fg=8,bold'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=8,bold'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=8,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=8,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=8,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=8,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=4,bold'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=8,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=5'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=7'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=5'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=5'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=1'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=11'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=2'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=2'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=2'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=2'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=2'
ZSH_HIGHLIGHT_STYLES[comment]='fg=8'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=10'
ZSH_HIGHLIGHT_STYLES[default]='fg=7'

typeset -A ZSH_HIGHLIGHT_PATTERNS
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=9')

# Created by `pipx` on 2021-05-16 10:53:33
export PATH="$PATH:/home/uver/.local/bin"
