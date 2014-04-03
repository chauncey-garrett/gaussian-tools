#!/usr/bin/env zsh
set  -f
#
# This script will generate supporting information for a computational chemistry paper.
#

#
# Metadata
#

local title_paper="Impact of d-Orbital Occupation on Metal-Carbon Bond Functionalization"
local authors="E. Chauncey Garrett III, Travis M. Figg, and Thomas R. Cundari\*"
local address="Center for Catalytic Hydrocarbon Functionalization, Department of Chemistry, and Center for Advanced Scientific Computing and Modeling (CASCaM), University of North Texas, 1155 Union Circle, #305070, Denton, Texas 76203-5017, United States"

local supporting_information_base_directory="$HOME/Desktop/si"
mkdir -p "$supporting_information_base_directory"

local supporting_information="$supporting_information_base_directory/supporting-information.md"

# print information
echo "

<font size="6px"> Supporting Information For </font>

# $title_paper

**$authors**

$address

---

## Table of Contents
<!--TOC-->

" >> $supporting_information

#
# Bring in the molecules, one by one per page...
#

for file in "$@"
do
	[ -f "$file" ] || die "Invalid file type ($file). Exiting because SI can't be corrupted..."

	# get information
	file_basename=$(basename "$file" .out)
	local image="$file_basename.jpg"
	local stoichiometry=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-stoichiometry.zsh "$file")
	local basis_functions=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-number-of-basis-functions.zsh "$file")
	local thermal_energies=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-sum-of-electronic-and-thermal-energies.zsh "$file")
	local zero_point_energies=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-sum-of-electronic-and-zero-point-energies.zsh "$file")
	local enthalpies=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-sum-of-electronic-and-thermal-enthalpies.zsh "$file")
	local free_energies=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-sum-of-electronic-and-thermal-free-energies.zsh "$file")
	local number_imaginary_frequencies=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-number-of-imaginary-frequencies.zsh "$file")
	local alpha_beta_electrons=$(${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-mean-of-alpha-and-beta-electrons.zsh "$file")

	function get_cartesians() {
		${GAUSSIAN_TOOLS_DIRECTORY:-$HOME/bin}/g09-cartesians.py "$file"
		cat "$file".xyz
	}
	cartesians=$(get_cartesians "$file")

	# print information
	# NOTE: There is a special "punctuation space" right before the header for $file_basename that is necessary in case there need be a super/sub-script at the beginning of the line
echo "

---

##  $file_basename

<table>

<tr>
<td style=\"text-align:center;\">

<figure>
<img src=\""$image"\" alt="" />
</figure>

| Data Type | Result |
| :----------- | -----------: |
| Stoichiometry | $stoichiometry |
| Number of Basis Functions | $basis_functions |
| Sum of electronic and thermal Energies | $thermal_energies |
| Sum of electronic and zero-point Energies | $zero_point_energies |
| Sum of electronic and thermal Enthalpies | $enthalpies |
| Sum of electronic and thermal Free Energies | $free_energies |
| Number of Imaginary Frequencies | $number_imaginary_frequencies |
| Mean of α and β Electrons | $alpha_beta_electrons |

</td>
<td width="45%">

**Molecular Geometry in Cartesian Coordinates**

\`\`\`xyz
$cartesians
\`\`\`

</td>
</tr>
</table>

"

done >> $supporting_information

#
# Gaussian 09 reference
#

# print information
echo "

---

## Full Gaussian 09 reference:

Gaussian 09, Revision B.1, Frisch, M. J.; Trucks, G. W.; Schlegel, H. B.; Scuseria, G. E.; Robb, M. A.; Cheeseman, J. R.; Scalmani, G.; Barone, V.; Mennucci, B.; Petersson, G. A.; Nakatsuji, H.; Caricato, M.; Li, X.; Hratchian, H. P.; Izmaylov, A. F.; Bloino, J.; Zheng, G.; Sonnenberg, J. L.; Hada, M.; Ehara, M.; Toyota, K.; Fukuda, R.; Hasegawa, J.; Ishida, M.; Nakajima, T.; Honda, Y.; Kitao, O.; Nakai, H.; Vreven, T.; Montgomery, Jr., J. A.; Peralta, J. E.; Ogliaro, F.; Bearpark, M.; Heyd, J. J.; Brothers, E.; Kudin, K. N.; Staroverov, V. N.; Kobayashi, R.; Normand, J.; Raghavachari, K.; Rendell, A.; Burant, J. C.; Iyengar, S. S.; Tomasi, J.; Cossi, M.; Rega, N.; Millam, N. J.; Klene, M.; Knox, J. E.; Cross, J. B.; Bakken, V.; Adamo, C.; Jaramillo, J.; Gomperts, R.; Stratmann, R. E.; Yazyev, O.; Austin, A. J.; Cammi, R.; Pomelli, C.; Ochterski, J. W.; Martin, R. L.; Morokuma, K.; Zakrzewski, V. G.; Voth, G. A.; Salvador, P.; Dannenberg, J. J.; Dapprich, S.; Daniels, A. D.; Farkas, Ö.; Foresman, J. B.; Ortiz, J. V.; Cioslowski, J.; Fox, D. J. Gaussian, Inc., Wallingford CT, **2009**.

" >> $supporting_information


