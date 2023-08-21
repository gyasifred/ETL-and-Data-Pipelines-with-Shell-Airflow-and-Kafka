#!/bin/bash

# Cut the fields 1 and 4 delimited by "#" from the input file
cut -f1,4 -d"#" /home/project/airflow/dags/web-server-access-log.txt > /home/project/airflow/dags/extracted.txt

# Transform the contents of extracted.txt to uppercase and save to capitalized.txt
tr "[a-z]" "[A-Z]" < /home/project/airflow/dags/extracted.txt > /home/project/airflow/dags/capitalized.txt

# Create a compressed archive named log.tar.gz containing capitalized.txt
tar -czvf log.tar.gz capitalized.txt

# Clean up the temporary transformed file
rm capitalized.txt

echo "Transformation and compression complete."
