# nsrl_carver
Three BASH scripts (easily modified) to carve custom hashsets out of the NSRL RDS_Unified hashset. The example default is configured to carve all record codes and product file names for (~Windows 7 AND ~Operating System) type into sub-hashset and companion idx files named customhash.txt and customhash.txt-md5.idx (made with Sleuthkit 'hfind') useful in tools like Autopsy. Each script has internal comments that may add useful understanding of NSRL issues and script methods. Some of the script is elegant, some of it is lazy. The elegant sharp knives parts work great, I don't care much about the lazy "glue" parts.

My philosophy is that adding selected hashsets of interest as either known good, or "of interest" (I hate the term 'known bad') is a far more flexible and time efficient act of analysis than dumping the entire NSRL into the known anything box of an analysis engine. Since I could not find a tool preparing derivatives of the NSRL for carving and searching analysis as I wanted, I made this one. This is a helpful tool for selective software audits or license audits for example, not only evidence finding. Another example: Maybe I want to search only for the software "Hotdog" (an old web builder from the 90s) or maybe only "VMware" then just extract all the codes and hashes and file names from the NSRL and put the resultant customhash into your analysis and fire it off.

Before adding the custom hashsets and index files into a tool like Autopsy, you can easily internally rename the customhash.txt name inside the first records of the file using a text editor to match any renaming of the files externally if you choose to. This will probably be use-foo "foo" in the event you make many different derivative extractions out of the NSRL for simulataneous usage in the same casefile.

You will of course have to download the NIST NSRL RDS_Unified .iso, extract it, and then place these 3 scripts into the RDS_Unified folder that holds the NSRLFile.txt hash base.

Script1, ./NSRL2MD5.bash, run first to produce a data reduced and optimized three column derivative "NSRLFile2.txt" file. NSRLFile2.txt is a comma cleansed and 3 column optimized version of the NSRL that enables efficient downstream script processing gains in scripts 2 and 3. This script 1 phase however, done only once per new release of NSRL, will however cost you a one-time 5-6 hours upfront mass records extraction time investment on a dual-core, and about 66% less of that on an 8 core. But only once you need to do this per new NSRL Unified release! It saves hours per search and processing on subsequent custom hashset crunching times, so it's a great productivity improvement method if you decide to make a lot of different children hashsets from the parent.

Script 2, ./prodcorecarver.bash will carve the default example sub-hashset for Windows 7 AND Operating system type records. You can edit the prodcodecarver column string values, or add or drop any of the record columns of interest in the gawk script to select for any other strings in the NSRLProd.txt file you would prefer to carve for. Windows7 is just there as an example. Try carving for "Hotdog" as an example alternative, or maybe VMware.

Script 3, ./recordcarverx.bash will automatically recieve the code list prodcodecarver.txt from ./prodcodecarver.bash. You can alternatively just enter the codes on the command line if you know therm. See the script comments for how to do that.

It will take about (1 minute per code or less) to extract all filenames and Md5 hashes from the NSRLFile2.txt on a dual-core to your new custom child hashset. The script will evaluate for 6 codes per pass per record all the way through the entire NSRL and loop back until all codes being searched for are finished. Less codes, less time carving. There are some per-loop screen display status messages to indicate life is still present as processing progresses. Be patient, 20Gb is a lot of data to search over multiple passes.
