#!/bin/bash

############## 
# REQUIREMENTS
# csvkit - sudo pip install csvkit

############## 
# Setup your workspace
#DB_PATH=databases/sqlite/covid19BRdb.sqlite3 ### Passed as ENV
CSV_DIR=/tmp/covid19br
mkdir -p $CSV_DIR

################ 
# Download the files into $CSV_DIR
curl https://raw.githubusercontent.com/praf62/covid_19_brazil/master/Covid_19_BrazilianStates.csv \
      -o $CSV_DIR/covidbr-regions.csv
curl 'https://brasil.io/dataset/covid19/caso/?place_type=state&format=csv' \
      -o $CSV_DIR/covidbr-states.csv
curl 'https://brasil.io/dataset/covid19/caso/?place_type=city&format=csv' \
      -o $CSV_DIR/covidbr-city.csv      

#####################
# Insert the data

## Insert the andamento_nazionale data
csvsql $CSV_DIR/covidbr-regions.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables covid_regions    
csvsql $CSV_DIR/covidbr-states.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables covid_states
csvsql $CSV_DIR/covidbr-city.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables covid_city

#####################
# EXIT
exit 0
