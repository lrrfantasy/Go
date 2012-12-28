#Go

##Install

Run `./init.sh` in the directory where you put Go.

##Usage

###Help
`go help`: display help for Go.
`go help {command}`: display help for command.

###List
`go` or `go list`: display Go list.

###Add
`go add {alias} {path}`: add new Go. Example: `go add home /Users/alice/homepage`.

###Remove
`go rm {alias}`: remove a Go. Example: `go rm home`.

###Edit
`go edit {alias} {path}`: edit a Go. Example: `go edit home /Users/alice/home`.

###Rename
`go mv {old_alias} {new_alias}`: rename a Go. Example: `go mv home homepage`.

###Search
`go grep {alias}`: search for a Go. Example: `go ? home` or `go grep home`.
