local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
local user_host="%B%(!.%{$fg[red]%}.%{$fg[green]%})%n@${fg[red]%}%m%{$reset_color%} "
local user_symbol='%(!.#.$)'
local current_dir="%B%{$fg[blue]%}%~ %{$reset_color%}"

local vcs_branch='$(git_prompt_info)$(hg_prompt_info)'
local venv_prompt='$(virtualenv_prompt_info)'
local kube_prompt='$(kube_ps1)'

function conda_prompt_info(){
  if [[ -n ${CONDA_DEFAULT_ENV} && "$CONDA_DEFAULT_ENV" != "base" ]]; then
    echo "${ZSH_THEME_VIRTUALENV_PREFIX=[}${CONDA_DEFAULT_ENV:t:gs/%/%%}${ZSH_THEME_VIRTUALENV_SUFFIX=]}"
  fi
}

local conda_prompt='$(conda_prompt_info)'

source ~/.dotfiles/features.sh

ZSH_THEME_RVM_PROMPT_OPTIONS="i v g"

if [ "$DISABLE_USER_INFO_IN_PROMPT" = true ]; then
  user_host="%B%{$fg[green]%}%m%{$reset_color%} "
fi

local top_prompt="╭─${user_host}${current_dir}${vcs_branch}${venv_prompt}${conda_prompt}"
if [ "$FEATURE_ENABLE_KUBERNETES" = true ]; then
  source "/home/linuxbrew/.linuxbrew/opt/kube-ps1/share/kube-ps1.sh"

  top_prompt="${top_prompt}${kube_prompt}"
fi

local bottom_prompt="╰─%B${user_symbol}%b "

PROMPT="${top_prompt}
${bottom_prompt}"

RPROMPT="%B${return_code}%b"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}●%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[yellow]%}"

ZSH_THEME_HG_PROMPT_PREFIX="$ZSH_THEME_GIT_PROMPT_PREFIX"
ZSH_THEME_HG_PROMPT_SUFFIX="$ZSH_THEME_GIT_PROMPT_SUFFIX"
ZSH_THEME_HG_PROMPT_DIRTY="$ZSH_THEME_GIT_PROMPT_DIRTY"
ZSH_THEME_HG_PROMPT_CLEAN="$ZSH_THEME_GIT_PROMPT_CLEAN"

ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$fg[green]%}‹"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="› %{$reset_color%}"
ZSH_THEME_VIRTUALENV_PREFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX"
ZSH_THEME_VIRTUALENV_SUFFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX"

KUBE_PS1_PREFIX="%{$fg[magenta]%}‹"
KUBE_PS1_SUFFIX="%{$fg[magenta]%}› %{$reset_color%}"
