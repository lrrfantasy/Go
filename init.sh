#!/usr/bin/env bash

echo "Initializing go environment"
echo "source $PWD/go.sh" >> ~/.bashrc

echo "Reloading Bash"
exec bash

echo "Creating configuration file"
touch .config

echo "Installation succeeded."
