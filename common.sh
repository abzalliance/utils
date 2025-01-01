#!/bin/bash

# Функція для виведення роздільної лінії
function printDelimiter {
  echo "==========================================="
}

# Функція для виведення тексту фіолетовим кольором з жирним шрифтом
function printPurple {
  echo -e "\e[1m\e[35m${1}\e[0m"
}

# Функція для відображення логотипу
function printLogo {
  bash <(curl -s "https://raw.githubusercontent.com/abzalliance/logo/master/logo.sh")
}

