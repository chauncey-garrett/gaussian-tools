#!/usr/bin/env zsh
set  -f
#
#
# sum of alpha and beta electrons
#

function g09-mean-of-alpha-and-beta-electrons()
{
	local data=$(awk '/alpha electrons/ { result_alpha = $1; result_beta = $4 } END { result = (result_alpha + result_beta) / 2; print result }' "${1}")

	"${GAUSSIAN_TOOLS_DOT_DIRECTORY:-$HOME/bin}/g09-data-test.zsh" $data
}

g09-mean-of-alpha-and-beta-electrons "${1}"


