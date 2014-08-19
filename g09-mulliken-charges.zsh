#!/usr/bin/env zsh
set  -f
#
# Gaussian09 Mulliken charge for specific atom
#

function g09-mulliken-charges()
{
	if [[ -z "${2}" ]]
	then # all Mulliken charges are requested

		data=$(
			awk '/Mulliken charges and spin densities:/,/Sum of Mulliken charges/ { print }' "${1}" |\
				head -n -1 |\
				tac |\
				sed -n '1,/               1          2/p' |\
				head -n -1 |\
				tac |\
				awk '{print $2, $3}' |\
				column -t
		)

	else # Mulliken charges of a specific atom are requested

		data=$(
			awk '/Mulliken charges and spin densities:/,/Sum of Mulliken charges/ { print }' "${1}" |\
				head -n -1 |\
				tac |\
				sed -n '1,/               1          2/p' |\
				head -n -1 |\
				tac |\
				awk -v atom="${2}" '$0 ~ atom {print $3}'
		)

	fi

	"${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-data-test.zsh" "$data"
}

# g09-mulliken-charges file [atom]
g09-mulliken-charges "${1}" "${2}"


