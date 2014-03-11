#!/usr/bin/env zsh
set  -f
#
#
# stoichiometry
#

function g09-stoichiometry()
{
	local data=$(awk '/Stoichiometry( *[^ ]* *){1}/ { result = $2 } END { print result }' "${1}")

	"${GAUSSIAN_TOOLS_DOT_DIRECTORY:-$HOME/bin}/g09-data-test.zsh" $data
}

g09-stoichiometry "${1}"


