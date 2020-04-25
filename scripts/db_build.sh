#!/bin/bash

############## 
# REQUIREMENTS
# sqlite3 - sudo apt-get install sqlite3

############## 
# Setup your workspace
#DB_PATH=databases/sqlite/dpc-covid19-ita_db.sqlite3 ### Passed as ENV

#################
# Build the database

# First remove the existing database file, if any
rm -f $DB_PATH

## Create the andamento_nazionale table
echo "CREATE TABLE covid_br (
  name TEXT(255),
  level TEXT(255),
  city TEXT(255),
  county TEXT(255),
  state TEXT(255),
  country TEXT(255),
  population REAL,
  lat REAL,
  long REAL,
  url TEXT(255),
  aggregate TEXT(255),
  tz TEXT(255),
  cases REAL,
  deaths REAL,
  recovered REAL,
  active REAL,
  tested REAL,
  hospitalized REAL,
  discharged REAL,
  growthFactor REAL,
  date TEXT(255)
);" | sqlite3 $DB_PATH

#####################
# EXIT
exit 0