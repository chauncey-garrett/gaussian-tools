#!/usr/bin/env zsh
set  -f
#
#
# lowest imaginary frequency
#

function g09-lowest-imaginary-frequency()
{
	local data=$(awk '/negative Signs/,/Frequencies/ { if (/Frequencies/) { result = $3 } } END {print result}' "${1}")

	"${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-data-test.zsh" $data
}

g09-lowest-imaginary-frequency "${1}"


