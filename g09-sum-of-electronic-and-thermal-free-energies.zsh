#!/usr/bin/env zsh
set  -f
#
#
# sum of electronic and thermal free energies
#

function g09-sum-of-electronic-and-thermal-free-energies()
{
	local data=$(awk '/Sum of electronic and thermal Free Energies=/ { result = $8 } END { print result }' "${1}")

	"${GAUSSIAN_TOOLS_DOT_DIRECTORY:-$HOME/bin}/g09-data-test.zsh" $data
}

g09-sum-of-electronic-and-thermal-free-energies "${1}"


