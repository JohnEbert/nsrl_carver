# SCRIPTNAME: NSRL2MD5.bash
# eber0206@gmail.com
# This "one-time" script does several important optimization actions against the NSRLFile.txt file:
#	The philosophy is to simplify downstream record carving scripts and parsing time by reducing the complication and number of bytes to sift through.
#	It converts NSRLFile.txt confusion to a clean "/" forward-slash delimited NSRLFile2.txt version, preserving the original.
#	It "data-reduces" out all but the MD5, Filename, Filesize, and Product Code fields.
#	It is a simple script change to select for SHA1, etc, but will require a full one-time rebuild of a new NSRLFile2.txt version (5-6 hours processing on Dual-Core.)
#	It produces a derivative file that enables writing cleaner, more efficent downstream carving scripts for an over 50% time/performance productivity improvement.
#	This script solves the 1st of two dependencies (prepares an optimized dataset) for the recordcarverx.bash records carver script.

# This one-time "prep-operation" will take about 3-4 hours on a dual-core, and about 66% less time on an 8-core computer.
# You will need about 9-10 Gigabyte of drive space for the output file.

#************************************************************************************************************************
date1=$(date +"%s")
date

# Strip out delimiter quotes and commas, replace or fix-up with forward-slashes, and keep only fields for MD5, Filename, Filesize, and ProductCode.
gawk 'BEGIN  { FPAT = "([^\"]+)" } { gsub(/,/,"/",$2); gsub(/,/,"/",$4); gsub(/,/,"/",$6); gsub(/,/,"/",$8); gsub(/,/,"/",$10); print $3$4$7$8 }' NSRLFile.txt > tmp && mv tmp NSRLFile2.txt

date2=$(date +"%s")
elapsed_seconds=$(($date2-$date1))
echo "$(($elapsed_seconds / 60)) minutes and $(($elapsed_seconds % 60)) seconds elapsed."

echo " After this, you will want to use the script ./prodcodecarver.bash"
