##
# Function which returns the date and time in the ISO8601 standard format
# PARAMETERS:
# date - STRING - Date in RouterOS format (nov/06/2015)
# time - STRING - Time in format 'HH:MM:SS'
# noSeparator - BOOLEAN - If true then no separators are used
# 
# RETURNS:
# STRING - Date and time in ISO8601 format 
#          '-' and ':' separators are not included if noSeparator parameter is set to true
#          If date/time parameters are not set then the current date/time is used
#
:local getISO8601DateTime do={
 :local months [:toarray "-,jan,feb,mar,apr,may,jun,jul,aug,sep,oct,nov,dec"];
 :local aDate;
 :if ([:len $date] = 11) do={ :set aDate $date; } else={ :set aDate [/system clock get date]; }
 :local aTime;
 :if ([:len $time] >= 7) do={ :set aTime $time; } else={ :set aTime [/system clock get time]; }
 :local noSeparatorChar false;
 :if ($noSeparator = "true" || $noSeparator = "True") do={ :set noSeparatorChar true; }

 :local year [:pick $aDate 7 11];
 :local month [:pick $aDate 0 3];
 :set month [:find $months $month];
 :if ($month < 10) do={ :set month "0$month"; }
 :local day [:pick $aDate 4 6];
 :local hour [:pick $aTime 0 2];
 :local minute [:pick $aTime 3 5];
 :local second [:pick $aTime 6 8];

 :local separator "-";
 :local dateTime;
 :if ($noSeparatorChar) do={ :set $separator ""; }
 :set dateTime "$year$separator$month$separator$day";
 :set dateTime ($dateTime."T");
 :if (!$noSeparatorChar) do={ :set $separator ":"; }
 :set dateTime ($dateTime."$hour$separator$minute$separator$second");
 :return $dateTime;
}

#Example usage:
:put [$getISO8601DateTime noSeparator=True ];
