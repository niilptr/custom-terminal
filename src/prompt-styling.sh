#!/bin/bash

# ======================= PROMPT STYLING ========================

# Configuration flags
export PRINT_PATH_TO_GIT_ROOT=false # true/false: print in the prompt the path to the git root if in a git repository directory

# Print configuration flags
print_zshrc_flags() {
  echo "PRINT_PATH_TO_GIT_ROOT=$PRINT_PATH_TO_GIT_ROOT    : print in the prompt the path to the git root if in a git repository directory"
}

# style and colors for zsh terminal
#  require grealpath that can be installed with `brew install coreutils`
#  
setopt PROMPT_SUBST    # thanks to https://zwbetz.com/how-to-change-your-zsh-shell-prompt/
assemble_prompt() {
  local user_at_machine="%B%F{green}%n@%m%f%b"
  local path_color="%B%F{cyan}"
  local path_color_git="%B%F{black}"
  local path_color_end="%f%b"
  local bold_dollar="%B$%b"
  local repo_color="%B%F{green}"
  local repo_color_end="%f%b"
  local git_branch=$(git branch 2> /dev/null) 
  if [ -n "$git_branch" ]; then
    local branch_name=$(echo $git_branch | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    local git_root_path=$(git rev-parse --show-toplevel)
    local repo_name=$(basename $git_root_path)
    local rel_path=$(grealpath --relative-to=$git_root_path $(pwd))
    if [ "$rel_path" = "." ]; then
      local rel_path=""
    fi
    local git_local_path="$repo_name/$rel_path"
    local git_root_path_compressed=$(echo "${git_root_path/$HOME/~}")
    local r="$path_color$git_local_path )$path_color_end"
    if [ "$PRINT_PATH_TO_GIT_ROOT" = "true" ]; then
      # with path to git root
      local p="$path_color_git$git_root_path_compressed$path_color_end $path_color($path_color_end"
    elif [ "$PRINT_PATH_TO_GIT_ROOT" = "false" ]; then 
      # without path to git root
      local p="$path_color($path_color_end"
    else
      # prompt warning
      local p="??? check .zshrc"
    fi
    echo "$user_at_machine $p $repo_color\u2325 $branch_name$repo_color_end $r $bold_dollar "    
  else
    echo "$user_at_machine $path_color%~$path_color_end $bold_dollar "
  fi
}
export PROMPT='$(assemble_prompt)'