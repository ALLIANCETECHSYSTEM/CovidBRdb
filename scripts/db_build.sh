#!/bin/bash

############## 
# REQUIREMENTS
# sqlite3 - sudo apt-get install sqlite3

############## 
# Setup your workspace
#DB_PATH=databases/sqlite/covid19BRdb.sqlite3 ### Passed as ENV

#################
# Build the database

# First remove the existing database file, if any
rm -f $DB_PATH


## Create the covid_regions table
echo "CREATE TABLE covid_regions (
  data DATE, 
  regiao VARCHAR, 
  estado VARCHAR,
  casosNovos INTEGER,
  casosAcumulados INTEGER,
  obitosNovos INTEGER,
  obitosAcumulados INTEGER
);" | sqlite3 $DB_PATH

## Create the covid_states table
echo "CREATE TABLE covid_states (
  date DATE, 
  state VARCHAR,
  city VARCHAR,
  place_type VARCHAR,
  confirmed INTEGER,
  deaths INTEGER,
  is_last VARCHAR,
  estimated_population_2019 INTEGER,
  city_ibge_code INTEGER,
  confirmed_per_100k_inhabitants INTEGER,
  death_rate FLOAT
);" | sqlite3 $DB_PATH

## Create the covid_city table
echo "CREATE TABLE covid_city (
  date DATE, 
  state VARCHAR,
  city VARCHAR,
  place_type VARCHAR,
  confirmed INTEGER,
  deaths INTEGER,
  is_last VARCHAR,
  estimated_population_2019 INTEGER,
  city_ibge_code INTEGER,
  confirmed_per_100k_inhabitants INTEGER,
  death_rate FLOAT
);" | sqlite3 $DB_PATH

#####################
# EXIT
exit 0