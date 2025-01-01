#!/bin/bash

# Function to print a delimiter line
function printDelimiter {
  echo "==========================================="
}

# Function to print text in purple with bold formatting
function printPurple {
  echo -e "\e[1m\e[35m${1}\e[0m"
}

# Function to display the logo
function printLogo {
  bash <(curl -s "https://raw.githubusercontent.com/abzalliance/logo/master/logo.sh")
}

