<#!
.SYNOPSIS
	Sign out disconnected RDP sessions
.DESCRIPTION
	When users RDP and disconect with out signing out will disconect the session. 
.NOTES
	File Name: Disconection.ps1
	Author: Mathew Ealy
	Requires Powershell 2.0
	As written run on start up
.LINK
	https://github.com/MEaly58
#>
# Get all RDP sessions on localhost
$sessions = query user /server:"localhost";
 
# Loop through each session/line returned
foreach ($line in $sessions) { 
 
    $line = -split $line;
 
    # Get current session state (column 4)
    $state = $line[3];
 
    # If the session state is Disconnected 
    if ($state -eq "Disc") { 
 
        # Get Session ID (column 3) and current idle time (column 5)
        $sessionid = $line[2]; 
        $idletime = $line[4];
 
        # Check if idle for more than 1 day (has a '+') and log off 
        if ($idletime -like "*+*) 
		{
            logoff $sessionid /server:"localhost" /v
 
        # Check if idle for more than 1 hour (has a ':') and log off 
        } elseif ($idletime -like "*:*") 
		{
            logoff $sessionid /server:"localhost" /v
 
        } 
    }
}
