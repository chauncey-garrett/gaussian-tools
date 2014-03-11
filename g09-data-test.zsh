#!/usr/bin/env zsh
set  -f
#
#
# Gaussian09 data test
#

function g09-data-test()
{
	if [[ ${1} == ""  ]]
	then
		echo "-----"
	else
		echo "${1}"
	fi
}

g09-data-test "${1}"


