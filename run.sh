#!/bin/bash
while read p; do
   Rscript spei1.R $p
done <location.txt
cd output
cat *_avg.csv > total_avg.csv
