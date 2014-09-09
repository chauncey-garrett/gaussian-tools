#!/usr/bin/env zsh
set  -f
#
# This script is designed to pull commonly utilized data out of a standard Gaussian '09 output file. Though the script is well tested and thought out, use discretion, especially if each file is not fully contained within a single row in the associated CSV file.
# NOTE:  The data.csv file will be written over each time the script is run!
#

atom="O"
output_directory_prefix=$HOME/Desktop

# make a .csv worksheet
function stat()
{
	echo "FILENAME,MULLIKEN CHARGE"

	# gather data
	for file in "${@}"
	do
		[ -f "$file" ] && mulliken_charges=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-mulliken-charges.zsh "$file" "$atom")

		echo "$file,$mulliken_charges"
	done
}

#
# Make the data.csv data file
# NOTE! Will write over any previous data.csv file!
#

dos2unix -q *out
stat *out | tee data.csv
open data.csv

# mv *out $output_directory_prefix
# mv *gjf $output_directory_prefix
