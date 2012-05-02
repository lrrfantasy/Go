#!/usr/bin/env bash

echo "Initializing go environment"
echo "source $PWD/go.sh" >> ~/.bashrc

echo "Creating configuration file"
echo "" > .config
sed -i '' -e "s%filename=~%filename=$PWD%g" ./go.sh

echo "Reloading Bash"
echo "Installation succeeded."

exec bash
