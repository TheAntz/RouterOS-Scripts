##
# Function to send an email to multiple recipients
# PARAMETERS:
# to - STRING - Comma separated list of recipient email addresses
# subject - STRING - Email subject
# body - STRING - Email body
#
# EXAMPLE USAGE: 
# $sendEmail to="bob@example.com,ned@winterfell.net" subject="Winter is coming" body="It will be dark and cold.";
##
:local sendEmail do={
 :local recipients [:toarray $to];
 :foreach r in=[:toarray $recipients] do={
   :put ("Sending email to " . [:tostr $r])
   /tool e-mail send to=[:tostr $r] subject=$subject body=$body;
 }
}
