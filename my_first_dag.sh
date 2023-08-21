#!/bin/bash
echo "extract_transform_and_load"
cut -d":" -f1,3,6 /etc/passwd > extracted-data.txt

tr ":" "," < extracted-data.txt > transformed-data.csv