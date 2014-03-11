#!/usr/bin/env zsh
set  -f
#
#
# sum of electronic and zero-point energies
#

function g09-sum-of-electronic-and-zero-point-energies()
{
	local data=$(awk '/Sum of electronic and zero-point Energies=/ { result = $7 } END { print result }' "${1}")

	"${GAUSSIAN_TOOLS_DOT_DIRECTORY:-$HOME/bin}/g09-data-test.zsh" $data
}

g09-sum-of-electronic-and-zero-point-energies "${1}"


