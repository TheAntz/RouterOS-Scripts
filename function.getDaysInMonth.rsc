##
# Function to get number of days in a specific month
# PARAMETERS:
# year - INTEGER - Year for which we need information
# month - STRING - Three letter shortcode for month (jan/feb/mar/...) or month number
#
# EXAMPLE USAGE: 
# $getDaysInMonth year=2012 month="feb";
##
:local getDaysInMonth do={
 #Convert month name to number if necessary
 :local monthNum [:tonum $month];
 :if ([:typeof $monthNum] != "num") do={
  :local months [:toarray "-,jan,feb,mar,apr,may,jun,jul,aug,sep,oct,nov,dec"];
  :set monthNum [:find $months $month];
 }
 
 #If month is February then calculate if a leap year
 :if ($monthNum = 2) do={
  :local y [:tonum $year];
  :if ($y % 4 = 0) do={
   :if ($y % 100 = 0) do={
    :if ($y % 400 = 0) do={
     :return 29;
    } else={
     :return 28;
    }
   } else={
    :return 29;
   }
  } else={
   :return 28;
  }
 }
 
 #Calculate days in month
 :return (31 - (($monthNum - 1) % 7 % 2));
}

#Example usage
:put "February 1900 had $[$getDaysInMonth year=1900 month="feb" ] days";
:put "February 2011 had $[$getDaysInMonth year=2011 month=2 ] days";
:put "February 2012 had $[$getDaysInMonth year=2012 month="feb" ] days";
:put "November 2012 had $[$getDaysInMonth year=2012 month="nov" ] days";