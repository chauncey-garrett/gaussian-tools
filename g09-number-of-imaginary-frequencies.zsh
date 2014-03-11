#!/usr/bin/env zsh
set  -f
#
#
# number of imaginary frequencies
#

function g09-number-of-imaginary-frequencies()
{
	local data=$(awk '/imaginary frequencies \(negative Signs\)/ { result = $2 } END {print result}' "${1}")

	"${GAUSSIAN_TOOLS_DOT_DIRECTORY:-$HOME/bin}/g09-data-test.zsh" $data
}

g09-number-of-imaginary-frequencies "${1}"


