#!/usr/bin/env zsh
set  -f
#
#
# Gaussian09 title card
#

function g09-title-card()
{
	local data="$(grep 'Symbolic Z-matrix' -B 2 "${1}" | head -n 1 | cut -c 2-)"

	"${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-data-test.zsh" "$data"
}

g09-title-card "${1}"


