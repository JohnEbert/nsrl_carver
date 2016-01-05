# SCRIPTNAME: prodcodecarver.bash
# eber0206@gmail.com
# This script resolves the 2nd of 2 dependencies for the "recordcarverx.bash" script, which is then run as the last operation of this script.
# This script extracts National Institute of Sciences NSRLProd.txt product code records based on your column choices of strings and fields to use.
# This example selects NSRLProd.txt records of column 2 "ProductName" and column 7 "ApplicationType" and writes the column 1 "ProductCode" to "prodcodecarver.txt"
# This easily modified code demonstrates selecting product codes only for strings of approximately Windows 7 AND approximately Operating System type records.

# The gawk "FPAT" and assigned extended regular expression solves the issue of discerning proper fields in each record. 
# Google for the Gawk User's Guide for more information on FPAT.

# So, why oh why do we today need to use FPAT instead of default space-delimitation, or simple comma-delimitation to parse the NSRL RDS?
# Well, way back in 2000...ask NIST, but the NSRL RDS data design became infested with "embedded-comma data fields" that encumber parsing solutions.
# The issue exists in NSRLProd.txt, NSRLFile.txt, (and...?)

# Overcoming the processing time and productivity losses imposed just on shoveling through the record strucure overburden of this "blended" design
# became the inspiration for the triad of "NSRL2MD5, Prodcarver, and Recordcarverx" awk-centric bash project scripts.
# Dividing the issue into 3 pieces proved key to enabling "downstream" user productivity gains and flexibility.
# To NIST I say re-design of the record strucure to not mix field delimiters in with data would drive wider audience adoption in the long term & ease tool development.
#
# Quoting Jesse Kornblum, "The National Software Reference Library: The Best Reference Which Nobody Uses." And I know why.

# The comment below of record 14801 is a perfect poster-child example of this "embedded-comma" NSRL design illustrating why when using bash that awk scripts are
# using an FPAT and RegEx custom field seperator methods are essential to reliably identify the proper 7 fields in NSRLProd.txt from a mashup of 24 commas in the record.

# 14801,"Dell Optiplex Resource CD for Reinstalling Device Drivers and using Diagnostics, Utilities and System Requirements","June 2001","190","257","Chinese-Simplified,Chinese-Traditional,Dutch,English,French,German,Italian,Japanese,Korean,Norwegian,Polish,Portuguese,Portuguese Brazil,Russian","Diagnostic,Documentation,Drivers,system utility"

## CODE START ##########################################################################################################################

gawk 'BEGIN { FPAT = "([^,]+)|(\"[^\"]+\")" } ($2 ~ "Windows 7" && $7 ~ "Operating System") {print $1}' IGNORECASE=1 NSRLProd.txt | sort | uniq > prodcodecarver.txt

# Pass in the carved codes to the NSRLFile2.txt hash-carver script
./recordcarverx.bash $(< prodcodecarver.txt)
