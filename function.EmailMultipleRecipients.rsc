##
# Function to send an email to multiple recipients
# PARAMETERS:
# to - STRING - Comma separated list of recipient email addresses
# subject - STRING - Email subject
# body - STRING - Email body
# showRecipients - BOOLEAN - If TRUE the list of recipients will appear in the email body
#
# EXAMPLE USAGE: 
# $sendEmail to="bob@example.com,ned@winterfell.net" subject="Winter is coming" body="It will be dark and cold." showRecipients=true;
##
:local sendEmail do={
 :local recipients [:toarray $to];
 :local showToRecipients false;
 :if ($showRecipients = true || $showRecipients = "true" || $showRecipients = "True") do={ :set showToRecipients true; } else={ :set showToRecipients false; }
 :foreach r in=[:toarray $recipients] do={
   :put ("Sending email to " . [:tostr $r])
   :if ($showToRecipients = true) do={
     /tool e-mail send to=[:tostr $r] subject=$subject body=("To: " . [:tostr $recipients] . "\n\n" . $body);
   } else={
     /tool e-mail send to=[:tostr $r] subject=$subject body=$body;
   }
 }
}
