#!/usr/bin/env zsh
set  -f
#
#
# MM sanity check
# sum of atoms' charges
#

function g09-mm-sanity-check__sum-of-atom-charges()
{
	local data="$(grep -m 1 -A 2 "MM sanity checks:" "${1}" | grep atoms | awk '{print $6}')"

	"${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-data-test.zsh" "$data"
}

g09-mm-sanity-check__sum-of-atom-charges "${1}"


