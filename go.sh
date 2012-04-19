#!/usr/bin/env bash
# Add this to .bashrc

function go(){
  if [ $# = 0 ]; then
    echo Error
  else
    to $1
  fi
}

function to(){
  filename=~/code/go/.config
  path=0
  while read line
  do
    key=`echo $line | cut -d ':' -f1`
    value=`echo $line | cut -d ':' -f2`
    if [ $1 = $key ]; then
      path=$value
    fi
  done < $filename
  if [ $path = 0 ]; then
    echo "No quick go found: $1"
  else
    cd $path
  fi
}
