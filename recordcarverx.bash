# SCRIPTNAME: recordcarverx.bash
# This script has two prerequisites; it expects pre-processed records produced by the scripts "NSRL2MD5.bash" and "prodcodecarver.bash"

# Following satisfaction of pre-requisites:
#	Execution Option1: ./recordcarverx.bash $(< prodcodecarver.txt)
#	Execution Option2: ./recordcarverx.bash 123 456 789 ...
# This script will GAWK pattern match "n" number of input codes versus National Institute of Sciences NSRL RDS format hash record fields.
# This script will output matched records as a custom hash file and its companion "idx" file.
#---------------------------------------------------------------------
date1=$(date +"%s")
date

# Note: If you change "n" number of codes to check per pass per record, 
# you need to change the number hard coded gawk "${1:-0}"... statements that follow as well.
# No doubt there is a better way to handle the gawk, but it is what it is.
n=6

# "short-hand form" of the "test" command; if file named "custom*.*" pre-exists, delete it if true
[ -f customtemp0.txt ] && rm custom*.*

# While positional parameters count in $# not equal to 0, process "n" at a time,
# shift "n" records out of $@ for each loop, rinse and repeat until $# reports empty.
while (($#)); do
	date2=$(date +"%s")
	elapsed_seconds=$(($date2-$date1))
	echo
	echo "$(($elapsed_seconds / 60)) minutes and $(($elapsed_seconds % 60)) seconds elapsed."
	echo "$# codes remaining to process"
	echo "$@"
	if [ "$#" -gt $n ]
		then

# 		The construction "${1:-0}" means "if global variable $1 is not a number or empty, set it to the number 0.
#		Why? Comparison to nothing or null is illegal and all the variables must be set to something or the code breaks.
#		Since we cannot ensure "n" may have a value, we must check each instance and handle for the possibility it is null.
#
		gawk	-F/ '$(NF-1)=='"${1:-0}"'||$(NF-1)=='"${2:-0}"'||$(NF-1)=='"${3:-0}"'|| \
			 $(NF-1)=='"${4:-0}"'||$(NF-1)=='"${5:-0}"'||$(NF-1)=='"${6:-0}"' { print $1,$2 }' NSRLFile2.txt >> customtemp0.txt

#		"Shift" builtin bash command operates on the $@ environment variable values, $# keeps count of how many remain.
		shift $n

#	This section handles any remainder of parameters less than "n" to finish up search and zero-out $#
	else
		gawk -F/ '$(NF-1)=='"${1:-0}"'||$(NF-1)=='"${2:-0}"'||$(NF-1)=='"${3:-0}"'||\
			 $(NF-1)=='"${4:-0}"'||$(NF-1)=='"${5:-0}"'||$(NF-1)=='"${6:-0}"' { print $1,$2 }' NSRLFile2.txt >> customtemp0.txt
		shift "$#"
	fi
done

# Simply display no more values to process
echo "$# codes in process"
echo $@

# Remove copies of hashes and product names with sort and uniq
gawk '{print $0}' IGNORECASE=1 customtemp0.txt | sort | uniq > customhash.txt

# Build the Hash index
hfind -i md5sum customhash.txt
echo "Your new custom hash index file is:"
ls -al customhash.txt-md5.idx
echo
echo "Your new hash file is:"
ls -al customhash.txt
echo

date2=$(date +"%s")
elapsed_seconds=$(($date2-$date1))
echo "$(($elapsed_seconds / 60)) minutes and $(($elapsed_seconds % 60)) seconds elapsed."

