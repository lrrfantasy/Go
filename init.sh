#!/usr/bin/env bash

echo "Initializing go environment"
echo "export GO_HOME=`pwd`" >> ~/.bashrc
echo "source \$GO_HOME/go.sh" >> ~/.bashrc

echo "Creating configuration file"
touch .config

echo "Reloading Bash"
echo "Installation succeeded."

exec bash
