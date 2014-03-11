#!/usr/bin/env zsh
set  -f
#
#
# number of basis functions
#

function g09-number-of-basis-functions()
{
	local data=$(awk '/symmetry adapted basis functions/ { result = $3 } END {print result}' "${1}")

	"${GAUSSIAN_TOOLS_DOT_DIRECTORY:-$HOME/bin}/g09-data-test.zsh" $data
}

g09-number-of-basis-functions "${1}"


