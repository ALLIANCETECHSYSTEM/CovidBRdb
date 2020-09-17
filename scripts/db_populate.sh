#!/bin/bash

############## 
# REQUIREMENTS
# csvkit - sudo pip install csvkit

############## 
# Setup database file
#DB_PATH=databases/sqlite/covid19BRdb.sqlite3 ### Passed as ENV
CSV_DIR=/tmp/covid19br
mkdir -p $CSV_DIR

################ 
# Download the files into $CSV_DIR
curl 'http://brasilcontracovid19.com.br/files/covid19_region.csv' \
      -o $CSV_DIR/covidbr-regions.csv
curl 'https://brasil.io/dataset/covid19/caso/?place_type=state&format=csv' \
      -o $CSV_DIR/covidbr-states.csv
#curl 'https://data.brasil.io/dataset/covid19/caso.csv.gz' \
#      -o $CSV_DIR/covidbr-city.csv  
curl 'https://docs.google.com/spreadsheets/d/1O1OT--NOKPfy6l4tR6J5VX3TFg2Ah_RD7S9CsgfbikQ/export?format=csv&id=1O1OT--NOKPfy6l4tR6J5VX3TFg2Ah_RD7S9CsgfbikQ&gid=1287373792' \
      -o $CSV_DIR/covidbr-weeks.csv
curl 'https://docs.google.com/spreadsheets/d/1O1OT--NOKPfy6l4tR6J5VX3TFg2Ah_RD7S9CsgfbikQ/export?format=csv&id=1O1OT--NOKPfy6l4tR6J5VX3TFg2Ah_RD7S9CsgfbikQ&gid=685710944' \
      -o $CSV_DIR/covidbr-days.csv 

#####################
# Insert the data

## Insert the andamento_nazionale data
csvsql $CSV_DIR/covidbr-regions.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables covid_regions    
csvsql $CSV_DIR/covidbr-states.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables covid_states
#csvsql $CSV_DIR/covidbr-city.csv  \
#    --db sqlite:///$DB_PATH --insert --no-create \
#    --tables covid_city
csvsql $CSV_DIR/covidbr-weeks.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables covid_weeks
csvsql $CSV_DIR/covidbr-days.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables covid_days

#####################
# EXIT
exit 0
