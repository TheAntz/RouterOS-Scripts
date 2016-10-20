This repo serves to keep all of the scripts and scripting functions which I've written for MikroTik's [RouterOS](http://www.mikrotik.com/software). They are released under the [UNLICENSE](http://unlicense.org), you are welcome to use and modify them as you please.

-----

## Scripts
#### RebootNotifier.rsc
Script to notify administrator(s), via email, of a router reboot. The current external IP address of a specified interface and selected host availability will also be reported.  

-----

## Functions
#### function.csvIntSum.rsc
Returns the sum of a comma separated list of integers.

#### function.EmailMultipleRecipients.rsc
Modelled after `/tool e-mail` but able to send mail to multiple recipients.

#### function.getDaysInMonth.rsc
Return the number of days in a given month in a specific year.

#### function.getISO8601DateTime.rsc
Returns supplied date and time (or current date and time) in [ISO8601](https://en.wikipedia.org/wiki/ISO_8601) format.
