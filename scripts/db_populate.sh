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
curl 'https://brasilcontracovid19.com.br/files/covid_br_csv/arquivo_geral.csv' \
      -o $CSV_DIR/covidbr-regions.csv
curl 'https://brasil.io/dataset/covid19/caso/?place_type=state&format=csv' \
      -o $CSV_DIR/covidbr-states.csv
curl 'https://brasil.io/dataset/covid19/caso/?place_type=city&format=csv' \
      -o $CSV_DIR/covidbr-city.csv   
curl 'https://docs.google.com/spreadsheets/d/13sXwuJ4ifBF7AYlKbVVs5QReYfrDSAFgtz1i0_CSkGU/export?format=csv&id=13sXwuJ4ifBF7AYlKbVVs5QReYfrDSAFgtz1i0_CSkGU&gid=325952354' \
      -o $CSV_DIR/covidbr-geral.csv
curl 'https://docs.google.com/spreadsheets/d/13sXwuJ4ifBF7AYlKbVVs5QReYfrDSAFgtz1i0_CSkGU/export?format=csv&id=13sXwuJ4ifBF7AYlKbVVs5QReYfrDSAFgtz1i0_CSkGU&gid=1799760599' \
      -o $CSV_DIR/covidbr-acumulado.csv      
curl 'https://docs.google.com/spreadsheets/d/13sXwuJ4ifBF7AYlKbVVs5QReYfrDSAFgtz1i0_CSkGU/export?format=csv&id=13sXwuJ4ifBF7AYlKbVVs5QReYfrDSAFgtz1i0_CSkGU&gid=139606279' \
      -o $CSV_DIR/covidbr-regions-perc.csv    
curl 'https://docs.google.com/spreadsheets/d/13sXwuJ4ifBF7AYlKbVVs5QReYfrDSAFgtz1i0_CSkGU/export?format=csv&id=13sXwuJ4ifBF7AYlKbVVs5QReYfrDSAFgtz1i0_CSkGU&gid=910295117' \
      -o $CSV_DIR/covidbr-weeks.csv
curl 'https://docs.google.com/spreadsheets/d/13sXwuJ4ifBF7AYlKbVVs5QReYfrDSAFgtz1i0_CSkGU/export?format=csv&id=13sXwuJ4ifBF7AYlKbVVs5QReYfrDSAFgtz1i0_CSkGU&gid=0' \
      -o $CSV_DIR/covidbr-days.csv
curl 'https://docs.google.com/spreadsheets/d/13sXwuJ4ifBF7AYlKbVVs5QReYfrDSAFgtz1i0_CSkGU/export?format=csv&id=13sXwuJ4ifBF7AYlKbVVs5QReYfrDSAFgtz1i0_CSkGU&gid=416136897' \
      -o $CSV_DIR/covidbr-maps.csv   

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
csvsql $CSV_DIR/covidbr-geral.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables covid_geral
csvsql $CSV_DIR/covidbr-acumulado.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables covid_acumulado
csvsql $CSV_DIR/covidbr-regions-perc.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables covid_regions_perc
csvsql $CSV_DIR/covidbr-weeks.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables covid_weeks
csvsql $CSV_DIR/covidbr-days.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables covid_days
csvsql $CSV_DIR/covidbr-maps.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables covid_maps

#####################
# EXIT
exit 0
