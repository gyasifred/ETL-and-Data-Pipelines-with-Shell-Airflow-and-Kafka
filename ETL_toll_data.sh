#!/bin/bash
#create a directory
sudo mkdir -p /home/project/airflow/dags/finalassignment/staging
cd /home/project/airflow/dags/finalassignment
#download data
sudo wget -nc https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Final%20Assignment/tolldata.tgz
#unzip data
tar -xvzf /home/project/airflow/dags/finalassignment/tolldata.tgz -C /home/project/airflow/dags/finalassignment &&  chmod +rw /home/project/airflow/dags/finalassignment
#extract_data_from_csv
cut -f1,2,3,4 -d"," /home/project/airflow/dags/finalassignment/vehicle-data.csv \
        > /home/project/airflow/dags/finalassignment/csv_data.csv
#extract_data_from_tsv
cut -f5,6,7 /home/project/airflow/dags/finalassignment/tollplaza-data.tsv |\
      tr "\t" "," > /home/project/airflow/dags/finalassignment/tsv_data.csv
#extract_data_from_fixed_width
awk '{print $(NF-1), $NF}' /home/project/airflow/dags/finalassignment/payment-data.txt |\
      tr ' ' ',' > /home/project/airflow/dags/finalassignment/fixed_width_data.csv
#consolidate_data
paste -d "," /home/project/airflow/dags/finalassignment/csv_data.csv \
    /home/project/airflow/dags/finalassignment/tsv_data.csv \
    /home/project/airflow/dags/finalassignment/fixed_width_data.csv \
    > /home/project/airflow/dags/finalassignment/extracted_data.csv
#transform_data
awk 'BEGIN {FS=OFS=','} {$4=toupper($4)} 1' \
                                           /home/project/airflow/dags/finalassignment/extracted_data.csv > \
        /home/project/airflow/dags/finalassignment/transformed_data.csv