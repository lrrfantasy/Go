#!/usr/bin/env bash
# Add this to .bashrc

function go(){
  filename=~/code/go/.config
  cat $filename | while read line
  do
    tmpIFS=$IFS
    IFS=":"
    array=($line)
    echo ${array[0]} ${array[1]}
    IFS=$tmpIFS
  done

  if [ $1 = 'devtrac' ]; then
    path=~/code/devTrac
  elif [ $1 = 'homepage' ]; then
    path=~/code/homepage
  fi
  cd $path
}
