# nsrl_carver
Three BASH scripts (easily modified) to carve custom hashsets out of the NSRL RDS_Unified hashset. The example default is configured to carve all record codes and product file names for (~Windows 7 AND ~Operating System) type into sub-hashset and companion idx filef named customhash.txt and customhash.txt-md5.idx useful in tools like Autopsy.

Before adding the customhashsets and index files to a tool like Autopsy, you can easily internally rename the customhash.txt name inside the first records of the file using a text editor to match any renaming of the files externally if you choose to. This will probably be usefoo in the event you make many differnt derivative extractions out of the NSRL!

You will of course have to download the NIST NSRL RDS_Unified .iso, extract it, and then place these 3 scripts into the RDS_Unified folder that holds the NSRLFile.txt hash base.

Run ./NSRL2MD5.bash first to produce a data reduced and optimized three column NSRLFile2.txt file

Run ./prodcorecarver.bash to the default sub-hashset for Windows 7 AND Operating system type records. You can edit the prodcodecarver values and add or drop any of the record columns of interest in the gawk script to select for any other strings in the NSRLProd.txt file you would prefer to carve for. Windows7 is just there as an example. Try carving for "Hotdog" as an example alternative, or maybe VMware.

./prodcodecarver will automatically submit its output code list prodcodecarver.txt to ./recordcarverx.bash

It will take about (1 minute per code or less) to extract all files and Md5 hashes from the NSRLFile2.txt on a dual-core. The script will evaluate for 6 codes per pass per record all the way through the entire NSRL and loop back until all codes being searched for are finished. Less codes, less time carving...
