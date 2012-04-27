#!/usr/bin/env bash

echo "Initializing go environment"
echo "source $PWD/go.sh" >> ~/.bashrc

echo "Creating configuration file"
echo "" > .config

echo "Reloading Bash"
echo "Installation succeeded."

exec bash
