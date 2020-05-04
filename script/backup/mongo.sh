#!/bin/sh
output_dir="/data/mongo"
output_dir="$output_dir/`date +%y%m%d_%H%M`"

mongodump -o $output_dir > /dev/null

