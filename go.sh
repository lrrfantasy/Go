#!/usr/bin/env bash
# Add this to .bashrc

function go(){
  filename=~/.config

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
      echo "Incorrect argument: use 'go add {alias} {path}'"
    else
      echo "$2:$3" >> $filename
      sed -i '' -e "s%~%$HOME%g" "$filename"
    fi
  elif [ $1 = "rm" ]; then
    # Remove Go
    if [ $# -lt 2 ]; then
      echo "Incorrect argument: use 'go rm {alias}'"
    else
      echo "Remove $2..."
      result=`grep ^$2: $filename`
      if [ $? -eq 1 ]; then
        echo "No Go found: $2"
      else
        sed -i '' -e "/^$2:/d" "$filename"
      fi
    fi
  elif [ $1 = "edit" ]; then
    # Edit Go
    if [ $# -lt 2 ]; then
      echo "Incorrect argument: use 'go edit {alias} {new_path}'"
    else
      result=`grep ^$2: $filename`
      if [ $? -eq 1 ]; then
        echo "No Go found: $2"
      else
        sed -i '' -e "s%^$2:.*%$2:$3%g" "$filename"
        sed -i '' -e "s%~%$HOME%g" "$filename"
        echo "$2: $3"
      fi
    fi
  elif [ $1 = "?" ]; then
    # Search Go
    if [ $# -lt 2 ]; then
      echo "Incorrect argument: use 'go ? {alias}'"
    else
      result=`grep "^$2:" $filename`
      if [ $? -eq 1 ]; then
        echo "No Go found: $2"
      else
        grep "^$2:" $filename
      fi
    fi
  elif [ $1 = "help" ]; then
    echo "Go help"
    echo " go [list]: Display Go list"
    echo " go add {alias} {path}: Add a new Go connected to path"
    echo " go rm {alias}: Remove an existing Go"
    echo " go edit {alias} {new_path}: Edit an existing Go"
    echo " go ? {alias}: Search a Go"
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
      echo "Go to $PWD"
    fi
  fi
}
