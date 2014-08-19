#!/usr/bin/env zsh
set  -f
#
#
# route-section
#

function g09-route-section()
{
	local data="$(grep " #" "${1}" | head -n 1)"

	"${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-data-test.zsh" "$data"
}

g09-route-section "${1}"


