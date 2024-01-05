#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t -c"

SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))
NUMBER_OF_GUESSES=0

GET_USER(){

echo 'Enter your username:'
read USERNAME

USER_INFORMATION=$($PSQL "SELECT games_played, best_game FROM users WHERE username = '$USERNAME';")

if [[ -z $USER_INFORMATION ]]

  then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  INSERT_NEW_USER=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME');")
  GUESS_GAME

  else
  read GAMES_PLAYED BAR BEST_GAME <<< "$USER_INFORMATION"
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  GUESS_GAME

fi

}

GUESS_GAME(){

((NUMBER_OF_GUESSES++))

if [[ $1 ]]

  then echo "$1"
  else echo "Guess the secret number between 1 and 1000:"

fi

read GUESS

if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then GUESS_GAME "That is not an integer, guess again:"

elif [[ $GUESS -gt $SECRET_NUMBER ]]
  then GUESS_GAME "It's lower than that, guess again:"

elif [[ $GUESS -lt $SECRET_NUMBER ]]
  then GUESS_GAME "It's higher than that, guess again:"

elif [[ $GUESS -eq $SECRET_NUMBER ]]
  then
  echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"

  if [[ -z $USER_INFORMATION ]]
    then UPDATE=$($PSQL "UPDATE users SET best_game=$NUMBER_OF_GUESSES WHERE username='$USERNAME';")

  elif [[ $NUMBER_OF_GUESSES -lt $BEST_GAME ]]
    then UPDATE=$($PSQL "UPDATE users SET best_game=$NUMBER_OF_GUESSES WHERE username='$USERNAME';")

  fi

  UPDATE=$($PSQL "UPDATE users SET games_played = games_played + 1 WHERE username='$USERNAME';")
  exit 0

fi

}

GET_USER