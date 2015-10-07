#Script to notifier administrator of router reboot and host availability

#Set administrator email address
:local adminEmail "bob@example.com";
#Define public interface name
:local iface "MyISP";
#List of hosts to check for availability
##Update to get static DHCP lease IP's plus list items?
:local hosts  { 192.168.88.2; 192.168.88.3; 192.168.88.10; 8.8.8.8; 192.168.0.6 };
#########################
# End of user variables #
#########################

#Delay script for 30 seconds to allow system to fully boot
:delay 30;

#Wait for WAN interface to come up
:local ifup false;
:local i 0;
:while ($ifup = false && i<30) do={
  :delay 1;
  :set i ($i +1);
  :set ifup [/interface get [find name=$iface] running ];
}
#If interface still not running log error and exit script
:if ($i = 30) do={
  :log warning "Router rebooted.";
  :log error "Interface '$iface' not running after 30 seconds... exiting rebootNotifier script.";
  :error "Interface '$iface' not running after 30 seconds... exiting rebootNotifier script.";
}

#Get current public IP
:local externalIP [/ip address get [find interface=$iface] address];
#Strip netmask
:set externalIP [:pick $externalIP 0 ([:find $externalIP "/" -1])];

#Add log entry for reboot event.
:log warning "Router rebooted. External IP for interface '$iface' is $externalIP  Checking host availability...";

#Check for LAN host availability
:local  replies  0;
:local hostStatus;
:foreach i in=$hosts do={
  /tool flood-ping $i size=56 count=5 do={:if ($sent = 5) do={:set replies $"received"}}; 
  :if ($replies > 0) do={
    :set hostStatus ("$hostStatus $i is Available\r\n");
    :log info "Host $i is Available";
  } else={
    :set hostStatus ("$hostStatus $i is UNREACHABLE\r\n");
    :log warning "Host $i is UNREACHABLE";
  }
};

#Send e-mail to administrator
:local sysID [/sys identity get name]
/tool e-mail send to=$adminEmail subject="Router $sysID rebooted." body="Router $sysID has rebooted.\r\nCurrent external IP address on interface '$iface' is $externalIP\r\n\r\n$hostStatus";
:log info "Administrator notification email sent to $adminEmail";

#If not present then add scheduled job on startup
:local jobPresent [/system scheduler find where name="rebootNotifier"]; 
:if ($jobPresent = "") do={
/system scheduler add name=rebootNotifier on-event="/ system script run rebootNotifier" policy=read,write,policy,test start-time=startup
}
