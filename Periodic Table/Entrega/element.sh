#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only --quiet -c"

element=$1

MAIN() {
  # VERIFICO SI HAY ARGUMENTO
  if [[ -z $element ]]; then
    QUIT "Please provide an element as an argument."
  else
    # VERIFICO SI EL ARGUMENTO ES UN NÚMERO (NÚMERO ATÓMICO)
    if [[ $element =~ ^[0-9]+$ ]]; then
      ATOMIC_NUMBER=$element
      SYMBOL_AND_NAME=$($PSQL "SELECT symbol, name FROM elements WHERE atomic_number = $ATOMIC_NUMBER;")

      # VERIFICO SI EL NÚMERO ES VÁLIDO
      if [[ -z $SYMBOL_AND_NAME ]]; then
        QUIT "I could not find that element in the database."
      fi

      read SYMBOL BAR NAME <<< "$SYMBOL_AND_NAME"
    else
      # VERIFICO SI EL ARGUMENTO ES EL SIMBOLO
      if [ "${#element}" -le 2 ]; then
        SYMBOL=$element
        ATOMIC_NUMBER_AND_NAME=$($PSQL "SELECT atomic_number, name FROM elements WHERE symbol = '$SYMBOL';")

        # VERIFICO SI EL SIMBOLO ES VÁLIDO
        if [[ -z $ATOMIC_NUMBER_AND_NAME ]]; then
          QUIT "I could not find that element in the database."
        fi

        read ATOMIC_NUMBER BAR NAME <<< "$ATOMIC_NUMBER_AND_NAME"
      else
        # BUSCO CON EL NOMBRE COMPLETO
        NAME=$element
        ATOMIC_NUMBER_AND_SYMBOL=$($PSQL "SELECT atomic_number, symbol FROM elements WHERE name = '$NAME';")

        # VERIFICO SI EL NOMBRE ES VÁLIDO
        if [[ -z $ATOMIC_NUMBER_AND_SYMBOL ]]; then
          QUIT "I could not find that element in the database."
        fi

        read ATOMIC_NUMBER BAR SYMBOL <<< "$ATOMIC_NUMBER_AND_SYMBOL"
      fi
    fi

    ELEMENT_PROPERTIES=$($PSQL "SELECT melting_point_celsius, boiling_point_celsius, type_id, atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER;")
    read MELTING_POINT BAR BOILING_POINT BAR TYPE_ID BAR ATOMIC_MASS <<< "$ELEMENT_PROPERTIES"
    
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID;")

    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a$TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."

  fi
}

QUIT() {
  if [[ $1 ]]; then
    echo -e "$1"
  fi
  exit 0
}

MAIN
