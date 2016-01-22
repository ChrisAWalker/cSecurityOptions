# cSecurityOptions
This PowerShell DSC Module is designed to modify Windows security options. The first module (UserRightsAssignment) is used to modify Windows rights assignments for accounts.

You can also download this module from the [PowerShell Gallery](http://www.powershellgallery.com/packages/cSecurityOptions).

## Example
'''powershell
configuration URA 
{
    Import-DscResource -ModuleName cSecurityOptions

    Node localhost
    {
        UserRightsAssignment AccessNetwork
        {
            Privilege = 'SeBackupPrivilege'
            Ensure = 'Present'
            Identity = 'Administrator', 'Users', 'Everyone', 'Backup Operators'
        }
    }
}

URA
Start-DscConfiguration -Path URA -Wait -Verbose -Force -Debug
```

##Resources
# The values must be an array of strings.  The values to the right of the privilege is the default value from Windows Server 2012R2.
SeTrustedCredManAccessPrivilege = '' # Access Credential Manager as a trusted caller
SeNetworkLogonRight = 'Everyone', 'BUILTIN\Administrators', 'BUILTIN\Users', 'BUILTIN\Backup Operators' # Access this computer from the network
SeTcbPrivilege = '' # Act as part of the operating system
SeMachineAccountPrivilege = '' # Add workstations to domain
SeIncreaseQuotaPrivilege = 'NT AUTHORITY\LOCAL SERVICE', 'NT AUTHORITY\NETWORK SERVICE', 'BUILTIN\Administrators' # Adjust memory quotas for a process
SeInteractiveLogonRight = 'BUILTIN\Administrators', 'BUILTIN\Users', 'BUILTIN\Backup Operators' # Allow log on locally
SeRemoteInteractiveLogonRight = 'BUILTIN\Administrators', 'Remote Desktop Users' # Allow log on through Remote Desktop Services
SeBackupPrivilege = ['Administrators', 'Backup Operators', 'Users', 'Everyone', 'vagrant # Back up files and directories
# SeChangeNotifyPrivilege - This is not working on Windows 2012R2 Core - It is coded to bypass this setting within the recipe
SeChangeNotifyPrivilege = 'Everyone', 'NT AUTHORITY\LOCAL SERVICE', 'NT AUTHORITY\NETWORK SERVICE', 'BUILTIN\Administrators', 'BUILTIN\Users', 'BUILTIN\Backup Operators', 'Window Manager\Window Manager Group' # Bypass traverse checking
SeSystemtimePrivilege = 'NT AUTHORITY\LOCAL SERVICE', 'BUILTIN\Administrators' # Change the system time
SeTimeZonePrivilege = 'NT AUTHORITY\LOCAL SERVICE', 'BUILTIN\Administrators' # Change the time zone
SeCreatePagefilePrivilege = 'BUILTIN\Administrators' # Create a pagefile
SeCreateTokenPrivilege = '' # Create a token object
SeCreateGlobalPrivilege = 'NT AUTHORITY\LOCAL SERVICE', 'NT AUTHORITY\NETWORK SERVICE', 'BUILTIN\Administrators', 'NT AUTHORITY\SERVICE' # Create global objects
SeCreatePermanentPrivilege = '' # Create permanent shared objects
SeCreateSymbolicLinkPrivilege = 'BUILTIN\Administrators' # Create symbolic links
SeDebugPrivilege = 'BUILTIN\Administrators' # Debug programs
SeDenyNetworkLogonRight = '' # Deny access this computer from the network
SeDenyBatchLogonRight = '' # Deny log on as a batch job
SeDenyServiceLogonRight = '' # Deny log on as a service
SeDenyInteractiveLogonRight = '' # Deny log on locally
SeDenyRemoteInteractiveLogonRight = '' # Deny log on through Remote Desktop Services
SeEnableDelegationPrivilege = '' # Enable computer and user accounts to be trusted for delegation
SeRemoteShutdownPrivilege = 'BUILTIN\Administrators' # Force shutdown from a remote system
SeAuditPrivilege = 'NT AUTHORITY\LOCAL SERVICE', 'NT AUTHORITY\NETWORK SERVICE' # Generate security audits
SeImpersonatePrivilege = 'NT AUTHORITY\LOCAL SERVICE', 'NT AUTHORITY\NETWORK SERVICE', 'BUILTIN\Administrators', 'NT AUTHORITY\SERVICE' # Impersonate a client after authentication
# SeIncreaseWorkingSetPrivilege - This is not working on Windows 2012R2 Core - It is coded to bypass this setting within the recipe
SeIncreaseWorkingSetPrivilege = 'BUILTIN\Users', 'Window Manager\Window Manager Group' # Increase a process working set
SeIncreaseBasePriorityPrivilege = 'BUILTIN\Administrators' # Increase scheduling priority
SeLoadDriverPrivilege = 'BUILTIN\Administrators' # Load and unload device drivers
SeLockMemoryPrivilege = '' # Lock pages in memory
SeBatchLogonRight = 'BUILTIN\Administrators', 'BUILTIN\Backup Operators', 'Performance Log Users' # Log on as a batch job
SeServiceLogonRight = 'NT SERVICE\ALL SERVICES' # Log on as a service
SeSecurityPrivilege = 'BUILTIN\Administrators' # Manage auditing and security log
SeRelabelPrivilege = '' # Modify an object label
SeSystemEnvironmentPrivilege = 'BUILTIN\Administrators' # Modify firmware environment values
SeManageVolumePrivilege = 'BUILTIN\Administrators' # Perform volume maintenance tasks
SeProfileSingleProcessPrivilege = 'BUILTIN\Administrators' # Profile single process
SeSystemProfilePrivilege = 'BUILTIN\Administrators', 'NT SERVICE\WdiServiceHost' # Profile system performance
SeUndockPrivilege = 'BUILTIN\Administrators' # Remove computer from docking station
SeAssignPrimaryTokenPrivilege = 'NT AUTHORITY\LOCAL SERVICE', 'NT AUTHORITY\NETWORK SERVICE' # Replace a process level token
SeRestorePrivilege = 'BUILTIN\Administrators', 'BUILTIN\Backup Operators' # Restore files and directories
SeShutdownPrivilege = 'BUILTIN\Administrators', 'BUILTIN\Backup Operators' # Shut down the system
SeSyncAgentPrivilege = '' # Synchronize directory service data
SeTakeOwnershipPrivilege = 'BUILTIN\Administrators' # Take ownership of files or other objects
