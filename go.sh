#!/usr/bin/env bash
# Add these lines to .bashrc
# export GO_HOME=
# source $GO_HOME/go.sh

source ${GO_HOME}/.go-completion.bash

realpath(){
  local parent_dir=$(dirname "$1")
  cd "$parent_dir"
  local abs_path="$(pwd)"/"$(basename $1)"
  cd - > /dev/null
  echo $abs_path
}

function go(){
  filename=${GO_HOME}/.config

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
    case $2 in
      go|list|add|rm|?|grep|edit|help)
        echo "$2 is a keyword. Please use another Go name"
        ;;
      *)
        if [ $# -lt 3 ]; then
          echo "Incorrect argument: use 'go add {alias} {path}'"
          return 1
        else
	  path=$(realpath $3)
          echo "$2:$path" >> $filename
          echo "Added new Go $2: $path"
        fi
        ;;
    esac

  elif [ $1 = "rm" ]; then
    # Remove Go
    if [ $# -lt 2 ]; then
      echo "Incorrect argument: use 'go rm {alias}'"
      return 1
    else
      echo "Remove $2..."
      result=`grep ^$2: $filename`
      if [ $? -eq 1 ]; then
        echo "No Go found: $2"
	return 1
      else
        sed -i '' -e "/^$2:/d" "$filename"
      fi
    fi

  elif [ $1 = "edit" ]; then
    # Edit Go
    if [ $# -lt 2 ]; then
      echo "Incorrect argument: use 'go edit {alias} {new_path}'"
      return 1
    else
      grep -q ^$2: $filename
      if [ $? -eq 1 ]; then
        echo "No Go found: $2"
	return 1
      else
	path=$(realpath $3)
        sed -i '' -e "s%^$2:.*%$2:$path%g" "$filename"
        echo "$2: $path"
      fi
    fi

  elif [ $1 = "mv" ]; then
    # Rename Go
    if [ $# -lt 2]; then
      echo "Incorrect argument: use 'go mv {old_alias} {new_alias}'"
      return 1
    else
      grep -q ^$2: $filename
      if [ $? -eq 1 ]; then
        echo "No Go found: $2"
	return 1
      else
        sed -i '' -e "s%^$2:\(.*\)%$3:\1%g" "$filename"
      fi
    fi

  elif [[ $1 = "?" || $1 = "grep" ]]; then
    # Search Go
    if [ $# -lt 2 ]; then
      echo "Incorrect argument: use 'go ?|grep {alias}'"
      return 1
    else
      grep -q "^$2:" $filename
      if [ $? -eq 1 ]; then
        echo "No Go found: $2"
	return 1
      else
        grep "^$2:" $filename
      fi
    fi

  elif [ $1 = "help" ]; then
    if [ $# -eq 1 ]; then
      echo "Go help"
      echo " go [list]: Display Go list"
      echo " go add {alias} {path}: Add a new Go connected to path"
      echo " go rm {alias}: Remove an existing Go"
      echo " go edit {alias} {new_path}: Edit an existing Go"
      echo " go mv {old_alias} {new_alais}: Rename a Go"
      echo " go ?|grep {alias}: Search a Go"
      echo " Use go help [argument] for more detail help"
    elif [ $# -eq 2 ]; then
      case $2 in
        "list")
          echo " go [list]: Display Go list"
          ;;
        "add")
          echo " go add {alias} {path}: Add a new Go connected to path"
          echo " Example: go add home /Users/alice/homepage"
          ;;
        "rm")
          echo " go rm {alias}: Remove an exsiting Go"
          echo " Example: go rm home"
          ;;
        "edit")
          echo " go edit {alias} {new_path}: Edit an existing Go"
          echo " Example: go edit home /Users/alice/home"
          ;;
	"mv")
	  echo " go mv {old_alias} {new_alias}: Rename a Go"
	  echo " Example: go edit home homepage"
	  ;;
        "?"|"grep")
          echo " go ?|grep {alias}"
          echo " Example: go ?|grep home"
          ;;
        *)
          echo " No command found: $2"
	  return 1
          ;;
      esac
    fi

  else
    # Go to
    while read line
    do
      key=`echo $line | cut -d ':' -f1`
      value=`echo $line | cut -d ':' -f2`
      if [ $1 = $key ]; then
        path=$value
      fi
    done < $filename

    if [ -z $path ]; then
      echo "No Go found: $1"
      return 1
    else
      cd $path
      echo "Go to $PWD"
    fi
  fi

unset path
}
