##
# Function to sum a string of CSV integer values
# PARAMETERS:
# csvData - STRING - Comma separated list of integer values
# RETURNS:
# INTEGER - Sum of values in CSV string
#
:local csvIntSum do={
 :local data [:toarray $csvData];
 :local total 0;
 :foreach r in=$data do={
  :set total ($total + [:tonum $r]);
 }
 :return $total;
}

#Example usage:
:put [$csvIntSum csvData="11,2,7,1,21"];
