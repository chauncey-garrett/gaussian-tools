#!/usr/bin/env zsh
set  -f
#
#
# spin contamination before annihilation
#

function g09-spin-contamination-before-annihilation()
{
	local data="$(awk '/S\*\*2 before annihilation/ { result = substr( $4, 1, length($4) - 1 ) } END {print result}' "${1}")"

	"${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-data-test.zsh" "$data"
}

g09-spin-contamination-before-annihilation "${1}"


