#!/usr/bin/env zsh
set  -f
#
# Gaussian09 check point file name
#

function g09-check-point-file-name()
{
	local data=$(awk '/%chk=/ { result = substr( $0, 7 ) } END {print result}' "${1}")

	"${GAUSSIAN_TOOLS_DOT_DIRECTORY:-$HOME/bin}/g09-data-test.zsh" $data
}

g09-check-point-file-name "${1}"


