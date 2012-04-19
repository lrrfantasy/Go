#!/usr/bin/env bash
# Add this to .bashrc

function go(){
  filename=~/code/go/.config
  while read line
  do
    key=`echo $line | cut -d ':' -f1`
    value=`echo $line | cut -d ':' -f2`
    if [ $1 = $key ]; then
      path=$value
    fi
  done < $filename

  cd $path
}
