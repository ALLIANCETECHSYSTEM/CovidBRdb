#!/bin/bash

############## 
# REQUIREMENTS
# csvkit - sudo pip install csvkit

############## 
# Setup your workspace
#DB_PATH=databases/sqlite/dpc-covid19-ita_db.sqlite3 ### Passed as ENV
CSV_DIR=/tmp/dpccovid19itacsvs
mkdir -p $CSV_DIR

################ 
# Download the files into $CSV_DIR
curl https://coronadatascraper.com/timeseries.csv \
      -o $CSV_DIR/dpc-covid19-ita-timeseries.csv

#####################
# Insert the data

## Insert the andamento_nazionale data
csvsql $CSV_DIR/dpc-covid19-ita-timeseries.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables covid_br
    
#####################
# EXIT
exit 0