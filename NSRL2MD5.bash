# SCRIPTNAME: NSRL2MD5.bash
# eber0206@gmail.com
# This script solves the 1st of two dependencies (prepares an optimized dataset) for the recordcarverx.bash records carver script.
# This "one-time" script does several important optimization actions against the NSRLFile.txt file:
#	The philosophy is to simplify downstream record carving scripts and parsing time by reducing the complication and number of bytes to sift through.
#	It converts NSRLFile.txt comma-delimited confusion to a clean space-delimted NSRLFile2.txt version, preserving the original.
#	It "data-reduces" out all but the MD5, Filename, and Product Code fields.
#	It is a simple script change to select for SHA1, etc, but will require a full one-time rebuild of a new derivative (5-6 hours processing on Dual-Core.)
#	It produces a derivative file that enables writing cleaner, more efficent downstream carving scripts for an over 50% time/performance productivity improvement.
# This one-time prep-operation will take about 5-6 hours on a dual-core, and about 66% less time on an 8-core computer.
# You will need about 9-10 Gigabyte of drive space for the output file.

date1=$(date +"%s")
date
gawk 'BEGIN  { FPAT = "([^,]+)|(\"[^\"]+\")" } { gsub($6,"\""$6"\"",$6); print $2,$4,$6}' NSRLFile.txt > NSRLFile2.txt
echo "sed-ing"
sed -i 's/"//g' NSRLFile2.txt
date2=$(date +"%s")
elapsed_seconds=$(($date2-$date1))
echo "$(($elapsed_seconds / 60)) minutes and $(($elapsed_seconds % 60)) seconds elapsed."

# After this, you next ./prodcodecarver.bash
