#!/usr/bin/env zsh
set  -f
#
#
# Gaussian09 converged point group
#

function g09-converged-point-group()
{
	local data=$(awk '/Full point group/ { result = $4 } END {print result}' "${1}")

	"${GAUSSIAN_TOOLS_DOT_DIRECTORY:-$HOME/bin}/g09-data-test.zsh" $data
}

g09-converged-point-group "${1}"


