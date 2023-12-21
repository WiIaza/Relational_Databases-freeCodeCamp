#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=salon --tuples-only --quiet -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "\nWelcome to My Salon, how can I help you?\n"

MAIN_MENU() {
  if [ "$1" ]; then
    echo -e "\n$1"
  fi

  SERVICES=$($PSQL "SELECT * FROM services")
  if [ -z "$SERVICES" ]; then
    echo "There are no services available right now."
    exit 0
  fi

  echo "$SERVICES" | while read SERVICE_ID BAR NAME; 
  do
    echo "$SERVICE_ID) $NAME"
  done

  read SERVICE_ID_SELECTED

  SERVICE_SELECTION_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  MAKE_APPOINTMENT
}

MAKE_APPOINTMENT() {
  if [[ -z $SERVICE_SELECTION_NAME ]]
  then
  MAIN_MENU "I could not find that service. What would you like today?"

  else
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE

  CUSTOMER_NAME_AND_ID=$($PSQL "SELECT name, customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  
  read CUSTOMER_NAME BAR CUSTOMER_ID <<< "$CUSTOMER_NAME_AND_ID"

  if [[ -z $CUSTOMER_NAME ]]
    then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME

    CUSTOMER_ID=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME') RETURNING customer_id")
  fi

  echo -e "\nWhat time would you like your$SERVICE_SELECTION_NAME, $CUSTOMER_NAME?"
  read SERVICE_TIME
  
  RESULT_INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME');")
  echo -e "\nI have put you down for a$SERVICE_SELECTION_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
  fi
}

MAIN_MENU