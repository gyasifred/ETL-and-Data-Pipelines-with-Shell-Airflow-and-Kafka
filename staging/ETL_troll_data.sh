#!/bin/bash
#unzip data
tar -xzf /home/kgyasi/project/airflow/dags/finalassignment/tolldata.tgz -C /home/kgyasi/project/airflow/dags/finalassignment
#extract_data_from_csv
cut -f1,2,3,4 -d"," /home/kgyasi/project/airflow/dags/finalassignment/vehicle-data.csv \
        > /home/kgyasi/project/airflow/dags/finalassignment/csv_data.csv
#extract_data_from_tsv
cut -f5,6,7 /home/kgyasi/project/airflow/dags/finalassignment/tollplaza-data.tsv |\
      tr "\t" "," > /home/kgyasi/project/airflow/dags/finalassignment/tsv_data.csv
#extract_data_from_fixed_width
awk '{print $(NF-1), $NF}' /home/kgyasi/project/airflow/dags/finalassignment/payment-data.txt |\
      tr ' ' ',' > /home/kgyasi/project/airflow/dags/finalassignment/fixed_width_data.csv
#consolidate_data
paste -d "," /home/kgyasi/project/airflow/dags/finalassignment/csv_data.csv \
    /home/kgyasi/project/airflow/dags/finalassignment/tsv_data.csv\
    /home/kgyasi/project/airflow/dags/finalassignment/fixed_width_data.csv \
    > /home/kgyasi/project/airflow/dags/finalassignment/extracted_data.csv
#transform_data
awk 'BEGIN {FS=OFS=","} { $4 = toupper($4); print }' /home/kgyasi/project/airflow/dags/finalassignment/extracted_data.csv > \
 /home/kgyasi/project/airflow/dags/finalassignment/transformed_data.csv
