#!/bin/bash
#unzip data
tar -xzf ./tolldata.tgz 
cut -f1-4 -d"," ./vehicle-data.csv > ./csv_data.csv
#extract_data_from_tsv
cut -f5-7 ./tollplaza-data.tsv | tr "\t" "," > ./tsv_data.csv
#extract_data_from_fixed_width
awk '{print $(NF-1), $NF}' ./payment-data.txt | tr ' ' ',' > ./fixed_width_data.csv
#consolidate_data
paste -d "," ./csv_data.csv ./tsv_data.csv ./fixed_width_data.csv > ./extracted_data.csv
#transform_data
awk 'BEGIN {FS=OFS=","} { $4 = toupper($4); print }' ./extracted_data.csv > ./transformed_data.csv
