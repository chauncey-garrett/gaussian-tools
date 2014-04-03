#!/usr/bin/env zsh
set  -f
#
# spin contamination after annihilation
#

function g09-spin-contamination-after-annihilation()
{
	local data=$(awk '/S\*\*2 before annihilation/ { result = substr( $6, 1, length($6) - 1 ) } END {print result}' "${1}")

	"${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-data-test.zsh" $data
}

g09-spin-contamination-after-annihilation "${1}"


