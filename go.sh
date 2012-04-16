#!/usr/bin/env bash
# Add this to .bashrc

function go(){
  if [ $1='devtrac' ]; then
    path=~/code/devTrac
  fi
  cd $path
}
