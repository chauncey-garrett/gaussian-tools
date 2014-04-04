#!/usr/bin/env zsh
set  -f
#
#
# This script will gather all Gaussian output files and test whether or not they terminated correctly (by testing if "Normal" is present at the end of the file. The script will notify you of both normally terminated jobs and those that aren't. Additionally, it will both archive and organize your input and output files as follows:
#
# | Archive  | .gjf, .chk and .out            | $HOME/research/archive/$date/foo
# | Organize | .gjf, .chk and .out            | $HOME/research/finished_jobs/foo
# | Trash    | .e, .o, and others | $HOME/.Trash
#
# NOTE: All files are organized based upon the file's basename! (i.e., foo.gjf, foo.out, foo.chk, foo.e.12345 and foo.o.12345 will all be parsed as one job; if, however, I had bar.chk instead, then bar.chk would be ignored by the script--unless there is a file name bar.out)
#

#
# Define defaults
#

# directories
directory_finished_jobs="$HOME/research/finished_jobs"
directory_archive="$HOME/research/archive"
trash="$HOME/.Trash"

# ensure correct sed (GNU sed)
if (( $+commands[gsed] ))
then
	alias sed="gsed"
fi

#
# Debugging
#

function die()
{
	echo
	date
	echo
    echo "[ERROR]    : ${@}"
    exit 1
}

function status()
{
	echo
	date
	echo
	echo "[Status]   : ${@}"
}

function success()
{
 	echo
	date
	echo
	echo "[Success]  : ${@}"
    exit 0
}

#
# Test if we have finished Gaussian jobs
#

[ "$(ls **/*out)" ] \
	|| die "There are no output files in the current directory tree"

#
# Make directories if they don't exist
#

# finished jobs
[[ ! -d "$directory_finished_jobs" ]] && mkdir -p $directory_finished_jobs

# trash in case the script fails -> clean out periodically
[[ ! -d "$trash" ]] && mkdir -p $trash

#
# Determine what finished jobs exist; make a list if they do
#

function make_list()
{
	echo
	echo "Jobs requiring attention:"
	echo "-------------------------"

	for file in "$@"
 	do
        [[ -f "$file" ]]

		# test if the job finished properly
        test=$(tail $file | sed -n '/Normal/x; ${x;p;}')

        if [[ -n $test ]]
		then # job finished properly
            echo $file >> /tmp/move_list.tmp
            sed -i 's/.out/./g' /tmp/move_list.tmp
        else # job did not finished properly
			basename $file .out
		fi
    done
}
make_list **/*.out

#
# Move jobs and clean up log files
#

if [[ -f "/tmp/move_list.tmp" ]]
then
	# organize data and remove junk
	less /tmp/move_list.tmp | awk '{print "cp "$0"out '$directory_finished_jobs'"}' | zsh
	less /tmp/move_list.tmp | awk '{print "cp "$0"gjf '$directory_finished_jobs'"}' | zsh
	less /tmp/move_list.tmp | awk '{print "unarchive "$0"gz '$directory_finished_jobs'"}' | zsh
	less /tmp/move_list.tmp | awk '{print "cp "$0"chk '$directory_finished_jobs'"}' | zsh
	less /tmp/move_list.tmp | awk '{print "mv "$0"* '$trash'"}' | zsh

	# move data to archive for safekeeping
	date_time_stamp=$(date "+%Y-%m-%d at %H%M.%S hrs")
	mkdir -p "$directory_archive/$date_time_stamp"
	cp "$directory_finished_jobs"/* "$directory_archive/$date_time_stamp"
fi

# clean up
rm -f /tmp/move_list.tmp

#
# List completed jobs
#

if [ "$(ls -A $directory_finished_jobs)" ]
then
	echo
	echo "Finished Jobs:"
	echo "--------------"

	for file in $(ls $directory_finished_jobs/*.out)
	do
		basename $file .out
	done

	echo
fi

success "Script completed."



