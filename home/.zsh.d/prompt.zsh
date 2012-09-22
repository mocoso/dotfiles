autoload colors && colors

git_pair_for_prompt() {
  source ~/.hitch_export_authors
  if [ `git symbolic-ref HEAD 2> /dev/null` ] \
    && [ -n "${GIT_AUTHOR_EMAIL:+1}" ]; then
    echo $GIT_AUTHOR_EMAIL|awk -F "[+@]" '{ print "("$2"+"$3")" }'
  fi
}

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "%{$fg_bold[green]%}●"
zstyle ':vcs_info:*' unstagedstr "%{$fg_bold[red]%}●"
zstyle ':vcs_info:*' formats "%{$fg_bold[red]%}±%{$fg[yellow]%}%b%u%c"
zstyle ':vcs_info:*' actionformats "%{$fg_bold[red]%}±%{$fg[yellow]%}%b|%a%u%c"

precmd() {
  vcs_info
}

setopt prompt_subst
export PROMPT='%{$fg[cyan]%}%n@%m:%{$fg[white]%}%c${vcs_info_msg_0_}%{$reset_color%} $ '

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
export RPROMPT="${return_code}"

