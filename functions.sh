#!/bin/bash

# ======================= SHELL FUNCTIONS =======================

# register ~/.bash_functions if file exists
if [ -f $HOME/.bash_functions ]; then
    . $HOME/.bash_functions
fi

# ---------------------------------------------------------------

RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
NC='\033[0m' # No Color

# git graph all: git log with graph (all branches)
function gga() {
  N=${1:-10}
  echo ">> git log --oneline --graph --all -n $N"
  git log --oneline --graph --all -n $N
}

# git graph: git log with graph
function gg() {
  N=${1:-10}
  echo ">> git log --oneline --graph -n $N"
  git log --oneline --graph -n $N
}

# git checkout
function gc() {
  BRANCH=${1:-main}
  echo ">> git checkout $BRANCH"
  git checkout $BRANCH
  if [ "$?" -ne "0" ] && [[ "$BRANCH" == "main" ]]; then
    echo -e "${ORANGE}'main' branch not found: trying 'master':${NC}"
    echo ">> git checkout master"
    git checkout master 
  fi
}

# git add and commit
function gaac() {
  COMMIT_MSG=${1}
  if [ -z "$COMMIT_MSG" ]; then
    echo -e "${RED}error: commit message cannot be empty${NC}"
  elif [ "$#" -gt "1" ]; then
    echo -e "${RED}error: provide only one commit message, like \"new commit message\"${NC}"
  else
    echo ">> git add . && git commit -m \"$COMMIT_MSG\""
    git add . && git commit -m "$COMMIT_MSG"
  fi
}

# git commit minus message
function gcmm() {
  COMMIT_MSG=${1}
  if [ -z "$COMMIT_MSG" ]; then
    echo -e "${RED}error: commit message cannot be empty${NC}"
  elif [ "$#" -gt "1" ]; then
    echo -e "${RED}error: provide only one commit message, like \"new commit message\"${NC}"
  else
    echo ">> git commit -m \"$COMMIT_MSG\""
    git commit -m "$COMMIT_MSG"
  fi
}

# cd an list files
function cdl() {
  DIR_NAME=${1:-$HOME}
  echo ">> cd $DIR_NAME && ls -al"
  if [ -z "$DIR_NAME" ]; then
    echo -e "${RED}error: directory name cannot be empty${NC}"
  else
    cd "$DIR_NAME" && ls -al
  fi
}

# cd to git root
function cdgr() {
  GITROOT=$(git rev-parse --show-toplevel)
  echo ">> cd $GITROOT"
  cd $GITROOT
}

