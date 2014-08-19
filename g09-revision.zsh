#!/usr/bin/env zsh
set  -f
#
#
# revision used for calculation
#

function g09-revision()
{
	local data="$(grep -A 1 "Cite this work as:" "${1}" | tail -n 1 | cut -c2- | rev | cut -c2- | rev )"

	"${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-data-test.zsh" "$data"
}

g09-revision "${1}"


