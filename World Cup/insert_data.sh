#!/bin/bash

if [[ $1 == "test" ]]; then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

$PSQL "TRUNCATE games, teams RESTART IDENTITY;"
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT W_GOALS O_GOALS; do
  if [[ $YEAR != "year" ]]; then
    # Get winner_id
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    
    # If not found
    if [[ -z $WINNER_ID ]]; then
      # Insert winner team
      $PSQL "INSERT INTO teams(name) VALUES('$WINNER')"
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    fi

    # Get opponent_id
    OPP_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    
    # If not found
    if [[ -z $OPP_ID ]]; then
      # Insert opponent team
      $PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')"
      OPP_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    fi

    # Insert into games
    $PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES('$YEAR', '$ROUND', $WINNER_ID, $OPP_ID, $W_GOALS, $O_GOALS)"
  fi
done
