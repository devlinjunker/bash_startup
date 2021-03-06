#! /bin/zsh
# This file is to do setup on new computer after repo is downloaded
#  Should install typical programs and ensure basic configs are similar for zsh terminals

EXPECTED_DIR_NAME=zsh

# Expected Configuration for My User
# TODO: From Config File?
EXPECTED_GIT_NAME="Devlin"
EXPECTED_GIT_EMAIL=devlin.junker@gmail.com

# Find Current Directory
CUR_DIR=$(dirname "${BASH_SOURCE[0]}")
PWD=$(pwd)
if [[ "$CUR_DIR" != *"$PWD"* ]] && [[ "$CUR_DIR" != /* ]]; then # prepend PWD if it is not in DIR and DIR not absolute
    CUR_DIR="$PWD/$(echo "$CUR_DIR" | sed s/^\\.\\/?// )" # to make sure this is becomes an absolute path
fi

osx() {
  # TODO: Check if xcode tools installed
  # 1. run git status
  # 2. check if exits properly (git status 1>/dev/null; then check $? == 0 for success)
  # 3. if not, display message to install xcode + xcode tools then abort

  # TODO: Install Macports
  
  # TODO: Install Node & NVM

  # TODO: call _install_pip.zsh

  # TODO: install vscode?
    # also install vscode command line exec
    # https://code.visualstudio.com/docs/setup/mac#_alternative-manual-instructions

  echo "TODO: install osx stuff"
}

## Install oh-my-zsh for custom terminal & prompt (if not already installed)
which omz 1> /dev/null
if [[ "$?" == "0" ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

## TODO: create symbolic link to themes inside ~/.oh-my-zsh/themes


## Check Git Config
GIT_NAME=`git config --global user.name`
if [[ "$GIT_NAME" != "$EXPECTED_GIT_NAME" ]]; then
  echo "
Git config not set with correct name

use 'git config --global --edit'
"
  return -1
fi

GIT_EMAIL=`git config --global user.email`
if [[ "$GIT_EMAIL" != "$EXPECTED_GIT_EMAIL" ]]; then
  echo "
Git config not set with correct email

use 'git config --global --edit'
"
  return -1
fi

## Check that we are in the correct directory before running setup steps
if [[ "$CUR_DIR" =~ .*"$EXPECTED_DIR_NAME"$ ]] && [[ -e ../scripts ]]; then

  ## 1. Initialize vim configuration file
  
  "$CUR_DIR"../bash/lib/bvimrc

  echo ""

  ## 2. TODO: Create symlinks to zsh files and use $CUR_DIR to define location of profile files
  echo "TODO: Setup zsh env files"
  
  ## 3. Run OS specific steps
  if [[ "$OSTYPE" == "darwin"* ]]; then 
    ## Run method defined above
    osx
  fi

else
  echo "Please run init script from '$EXPECTED_DIR_NAME' directory 
  "

fi
