#!/usr/bin/env bash
# Add this to .bashrc

function go(){
  if [ $1 = 'devtrac' ]; then
    path=~/code/devTrac
  elif [ $1 = 'homepage' ]; then
    path=~/code/homepage
  fi
  cd $path
}
