# SCRIPTNAME: prodcodecarver.bash
# eber0206@gmail.com
# This script resolves the 2nd of 2 dependencies for the "recordcarverx.bash" script, which will auto-run as the last operation of this script.
# This script extracts National Institute of Sciences NSRLProd.txt product code records based on your column choices of strings and fields in the "gawk" code-line.

## CODE START ##########################################################################################################################

gawk 'BEGIN { FPAT = "([^\"]+)" } ( $2 ~ "Windows 7" && $12 ~ "Operating System" ) { gsub (/,/,"",$1); print $1 }' IGNORECASE=1 NSRLProd.txt | sort | uniq  > prodcodecarver.txt

# Pass in the carved codes to the NSRLFile2.txt hash-carver script
./recordcarverx.bash $(< prodcodecarver.txt)
