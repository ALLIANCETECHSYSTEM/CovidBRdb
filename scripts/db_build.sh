#!/bin/bash

############## 
# REQUIREMENTS
# sqlite3 - sudo apt-get install sqlite3

############## 
# Setup your workspace
#DB_PATH=databases/sqlite/covid19BRdb.sqlite3 ### Passed as ENV

#################
# Build the database Covid_BR

# First remove the existing database file, if any
rm -f $DB_PATH


## Create the covid_regions table
echo "CREATE TABLE covid_regions (
  IBGE INTEGER, 
  UF VARCHAR, 
  Regiao VARCHAR,
  Qtd_Mun INTEGER,
  Sintaxe VARCHAR
);" | sqlite3 $DB_PATH

#####################
# EXIT
exit 0
