#!/usr/bin/env zsh
set  -f
#
# This script is designed to pull commonly utilized data out of a standard Gaussian '09 output file. Though the script is well tested and thought out, use discretion, especially if each file is not fully contained within a single row in the associated CSV file.
# NOTE:  The data.csv file will be written over each time the script is run!
#

output_directory_prefix=$HOME/Desktop

function stat()
{
	filename=$(print "${1}")
	local check_point_file_name=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-check-point-file-name.zsh "${1}")
	local title_card=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-title-card.zsh "${1}")
	local stoichiometry=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-stoichiometry.zsh "${1}")
	local converged_point_group=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-converged-point-group.zsh "${1}")
	local number_imaginary_frequencies=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-number-of-imaginary-frequencies.zsh "${1}")
	local lowest_imaginary_frequency=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-lowest-imaginary-frequency.zsh "${1}")
	local electronic_energy_after_SDF_is_done=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-electronic-energy-after-sdf-is-done.zsh "${1}")
	local zero_point_energies=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-sum-of-electronic-and-zero-point-energies.zsh "${1}")
	local energies=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-sum-of-electronic-and-thermal-energies.zsh "${1}")
	local enthalpies=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-sum-of-electronic-and-thermal-enthalpies.zsh "${1}")
	local free_energies=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-sum-of-electronic-and-thermal-free-energies.zsh "${1}")
	local basis_functions=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-number-of-basis-functions.zsh "${1}")
	local alpha_beta_electrons=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-mean-of-alpha-and-beta-electrons.zsh "${1}")
	local spin_contamination_before_annihilation=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-spin-contamination-before-annihilation.zsh "${1}")
	local spin_contamination_after_annihilation=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-spin-contamination-after-annihilation.zsh "${1}")
	local oniom_extrapolated_energy=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-oniom-extrapolated-energy.zsh "${1}")
	local mm_sanity_check__sum_of_all_charges=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-mm-sanity-check--sum-of-all-charges.zsh "${1}")
	local mm_sanity_check__sum_of_atom_charges=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-mm-sanity-check--sum-of-atom-charges.zsh "${1}")

	echo "$filename, $check_point_file_name, $title_card, $stoichiometry, $converged_point_group, $number_imaginary_frequencies, $lowest_imaginary_frequency, $electronic_energy_after_SDF_is_done, $zero_point_energies, $energies, $enthalpies, $free_energies, $basis_functions, $alpha_beta_electrons, $spin_contamination_before_annihilation, $spin_contamination_after_annihilation, $oniom_extrapolated_energy, $mm_sanity_check__sum_of_all_charges, $mm_sanity_check__sum_of_atom_charges"
}

# make a .csv worksheet
function data()
{
    echo "FILENAME, CHECK POINT FILE NAME, TITLE CARD, STOICHIOMETRY, CONVERGED POINT GROUP, NUMBER OF IMAGINARY FREQUENCIES, LOWEST IMAGINARY FREQUENCY, ELECTRONIC ENERGY AFTER SDF IS DONE, SUM OF ELECTRONIC AND ZERO-POINT ENERGIES, SUM OF ELECTRONIC AND THERMAL ENERGIES, SUM OF ELECTRONIC AND THERMAL ETHALPIES, SUM OF ELECTRONIC AND THERMAL FREE ENERGIES, NUMBER OF BASIS FUNCTIONS, MEAN OF ALPHA AND BETA ELECTRONS, SPIN CONTAMINATION BEFORE ANNIHILATION, SPIN CONTAMINATION AFTER ANNIHILATION, ONIOM EXTRAPOLATED ENERGY, (MM SANITY CHECK) SUM OF ALL CHARGES, (MM SANITY CHECK) SUM OF ATOMS' CHARGES"
	for file in "$@"; do
        [ -f "$file" ] && stat "$file"
	done
}

#
# Warning messages
#

# imaginary frequency exists
function warning_imaginary_frequencies()
{
    test=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-number-of-imaginary-frequencies.zsh "${1}")
	if [[ ! $test == "-----" ]] then
		echo "The following file contains an imaginary frequency:  $file"
	fi
}

# MM sanity check
function warning_mm_sanity_check()
{
    local all=$(grep -m 1 -A 2 "MM sanity checks:" "${1}" | grep All | awk '{print $5}')
    local atoms=$(grep -m 1 -A 2 "MM sanity checks:" "${1}" | grep atoms | awk '{print $6}')
    local test=$(echo "$all $atoms" | tr -d '\r' | awk '$1 !=$2')
    if [[ -n $test ]]; then
        echo "The following file did not pass the MM Sanity Check:  $file"
    fi
}

# check for pertinent errors
function warning()
{
    for file in "$@"; do
        [ -f "$file" ] && warning_imaginary_frequencies $file && warning_mm_sanity_check $file
    done
}

warning *out

#
# Make the data.csv data file
# NOTE! Will write over any previous data.csv file!
#

dos2unix -q *out
data *out > data.csv
open data.csv
mv *out $output_directory_prefix
mv *gjf $output_directory_prefix

