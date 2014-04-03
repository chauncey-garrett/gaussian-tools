#!/usr/bin/env zsh
set  -f
#
#
# MM sanity check
# sum of all charges
#

function g09-mm-sanity-check__sum-of-all-charges()
{
	local data=$(grep -m 1 -A 2 "MM sanity checks:" "${1}" | grep All | awk '{print $5}')

	"${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-data-test.zsh" $data
}

g09-mm-sanity-check__sum-of-all-charges "${1}"


