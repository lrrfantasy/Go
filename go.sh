#!/usr/bin/env bash
# Add this to .bashrc

function go(){
  if [ $# = 0 ]; then
    list
  elif [ $1 = "add" ]; then
    if [ $# -lt 2 ]; then
      echo "Incorrect argument: use 'go add {alias} {path}"
    else
      add $2 $3
    fi
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

function list(){
  echo "Go list"
  while read line
  do
    key=`echo $line | cut -d ':' -f1`
    value=`echo $line | cut -d ':' -f2`
    echo " $key: $value"
  done < $filename
}

function add(){
  echo "$1:$2" >> $filename
}
