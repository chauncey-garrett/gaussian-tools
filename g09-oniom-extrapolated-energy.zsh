#!/usr/bin/env zsh
set  -f
#
#
# ONIOM extrapolated energy
#

function g09-oniom-extrapolated-energy()
{
	local data="$(grep "ONIOM: extrapolated energy =" "${1}" | tail -n 1 | awk '{print $5}')"

	"${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-data-test.zsh" "$data"
}

g09-oniom-extrapolated-energy "${1}"


