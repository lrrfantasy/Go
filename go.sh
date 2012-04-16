#!/usr/bin/env bash
# Add this to .bashrc

function go(){
  filename=~/code/go/.config
  cat $filename | while read line
  do
    key=`echo $line | cut -d ':' -f1`
    value=`echo $line | cut -d ':' -f2`
    echo $key=$value
  done

  if [ $1 = 'devtrac' ]; then
    path=~/code/devTrac
  elif [ $1 = 'homepage' ]; then
    path=~/code/homepage
  fi
  cd $path
}
