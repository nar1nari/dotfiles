FIRST_COMMAND_DONE=false

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}%{$bg[green]%}%{$fg_bold[black]%}  "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}%{$fg[green]%}%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="  "
ZSH_THEME_GIT_PROMPT_CLEAN=" "

precmd() {
  local pos row

  exec 9<> /dev/tty
  echo -ne '\e[6n' >&9
  IFS=R read -rsd R -u 9 pos
  exec 9>&-

  row=$(echo "$pos" | cut -d'[' -f2 | cut -d';' -f1)

  if [[ "$FIRST_COMMAND_DONE" = true && "$row" -ne 1 ]]; then
    echo ""
  fi

  FIRST_COMMAND_DONE=true
}

ZSH_THEME_VIRTUALENV_PREFIX=""
ZSH_THEME_VIRTUALENV_SUFFIX=""

PROMPT=""

# OS logo
PROMPT+='%{$fg[green]%} %{$reset_color%}'
PROMPT+='%{$fg_bold[black]%}%{$bg[green]%}  $(virtualenv_prompt_info)%{$reset_color%}'
PROMPT+='%{$fg[green]%}%{$bg[black]%}%{$reset_color%}'

# user
PROMPT+='%{$fg[white]%}%{$bg[black]%}  %n%{$reset_color%}'
PROMPT+='%{$fg[black]%}%{$bg[green]%}%{$reset_color%}'

# pwd
PROMPT+='%{$fg_bold[black]%}%{$bg[green]%}%   %1~%{$reset_color%}'

# exit status
PROMPT+='%(?.%{$fg[green]%}.%{$fg[green]%}%{$bg[black]%})%{$reset_color%}'
PROMPT+='%(?.%{$fg[green]%}.%{$fg_bold[red]%}%{$bg[black]%} ✘ %{$reset_color%}%{$fg[black]%})%{$reset_color%}'

PROMPT+=' '

RPROMPT='$(git_prompt_info)'
