#!/usr/bin/env bash
# Add this to .bashrc

function go(){
  filename=~/code/go/.config

  if [[ $# = 0 || $1 = "list" ]]; then
    # Show Go list
    echo "Go list"
    while read line
    do
      key=`echo $line | cut -d ':' -f1`
      value=`echo $line | cut -d ':' -f2`
      echo " $key: $value"
    done < $filename
  elif [ $1 = "add" ]; then
    # Add new Go
    if [ $# -lt 3 ]; then
      echo "Incorrect argument: use 'go add {alias} {path}"
    else
      echo "$2:$3" >> $filename
    fi
  else
    # Go to
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
      echo "No Go found: $1"
    else
      cd $path
    fi
  fi
}
