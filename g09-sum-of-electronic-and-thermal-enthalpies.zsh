#!/usr/bin/env zsh
set  -f
#
#
# sum of electronic and thermal enthalpies
#

function g09-sum-of-electronic-and-thermal-enthalpies()
{
	local data=$(awk '/Sum of electronic and thermal Enthalpies=/ { result = $7 } END { print result }' "${1}")

	"${GAUSSIAN_TOOLS_DOT_DIRECTORY:-$HOME/bin}/g09-data-test.zsh" $data
}

g09-sum-of-electronic-and-thermal-enthalpies "${1}"


