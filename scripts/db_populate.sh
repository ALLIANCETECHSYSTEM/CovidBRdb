#!/bin/bash

############## 
# REQUIREMENTS
# csvkit - sudo pip install csvkit

############## 
# Setup databese file
#DB_PATH=databases/sqlite/covid19BRdb.sqlite3 ### Passed as ENV
CSV_DIR=/tmp/covid19br
mkdir -p $CSV_DIR

################ 
# Download the files into $CSV_DIR
curl 'https://brasilcontracovid19.com.br/files/covid19_region_2.csv' \
      -o $CSV_DIR/covidbr-regions.csv
#####################
# Insert the data

## Insert the andamento_nazionale data
csvsql $CSV_DIR/covidbr-regions.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables covid_regions
#####################
# EXIT
exit 0
