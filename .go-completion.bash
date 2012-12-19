_go_complete(){
  local cur prev go_list opts
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  go_list="$(for name in `cat ${GO_HOME}/.config | cut -d ":" -f1`; do echo $name; done)"
  opts="list add rm edit mv ? grep help"

  case $prev in
    go)
      COMPREPLY=( $(compgen -W "${go_list} ${opts}" -- ${cur}) )
      return 0
      ;;
    rm|edit|mv|grep|?)
      COMPREPLY=( $(compgen -W "${go_list}" -- ${cur}) )
      return 0
      ;;
    help)
      COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
      return 0
      ;;
    *)
      COMPREPLY=( $(compgen -f ${cur}) )
      return 0
      ;;
  esac
}

complete -F _go_complete go
