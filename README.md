# cSecurityOptions
This PowerShell DSC Module is designed to modify Windows security options. The first module (UserRightsAssignment) is used to modify Windows rights assignments for accounts.

You can also download this module from the [PowerShell Gallery](http://www.powershellgallery.com/packages/cSecurityOptions).

## Helper Information
This code largely focuses on handling local users and groups.  There are many ways that Windows references these identities and I've tried to handle all the variances.  When handling
Active Directory accounts, the scripts assume that you will be using the 'Domain\Group' or 'Domain\User' format.  This script assumes that the domain is correct and the domain identity is correct.
This is a future enhancement to validate that the identity exists.

## Feedback loop
This code is being leveraged in a large enterprise.  This is being actively maintained as of January 2016.  I welcome feedback and pull requests to make this better.

##Contributing
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable) - this is currently (1/21/2016) light
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## Example

```powershell
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
```
The values must be an array of strings.  The values to the right of the privilege is the default value from Windows Server 2012R2.
SeTrustedCredManAccessPrivilege = '' # Access Credential Manager as a trusted caller
SeNetworkLogonRight = 'Everyone', 'Administrators', 'Users', 'Backup Operators' # Access this computer from the network
SeTcbPrivilege = '' # Act as part of the operating system
SeMachineAccountPrivilege = '' # Add workstations to domain
SeIncreaseQuotaPrivilege = 'LOCAL SERVICE', 'NETWORK SERVICE', 'Administrators' # Adjust memory quotas for a process
SeInteractiveLogonRight = 'Administrators', 'Users', 'Backup Operators' # Allow log on locally
SeRemoteInteractiveLogonRight = 'Administrators', 'Remote Desktop Users' # Allow log on through Remote Desktop Services
SeBackupPrivilege = ['Administrators', 'Backup Operators' # Back up files and directories
# SeChangeNotifyPrivilege - This is not working on Windows 2012R2 Core - It is coded to bypass this setting within the resource.
SeChangeNotifyPrivilege = 'Everyone', 'LOCAL SERVICE', 'NETWORK SERVICE', 'Administrators', 'Users', 'Backup Operators', 'Window Manager Group' # Bypass traverse checking
SeSystemtimePrivilege = 'LOCAL SERVICE', 'Administrators' # Change the system time
SeTimeZonePrivilege = 'LOCAL SERVICE', 'Administrators' # Change the time zone
SeCreatePagefilePrivilege = 'Administrators' # Create a pagefile
SeCreateTokenPrivilege = '' # Create a token object
SeCreateGlobalPrivilege = 'LOCAL SERVICE', 'NETWORK SERVICE', 'Administrators', 'SERVICE' # Create global objects
SeCreatePermanentPrivilege = '' # Create permanent shared objects
SeCreateSymbolicLinkPrivilege = 'Administrators' # Create symbolic links
SeDebugPrivilege = 'Administrators' # Debug programs
SeDenyNetworkLogonRight = '' # Deny access this computer from the network
SeDenyBatchLogonRight = '' # Deny log on as a batch job
SeDenyServiceLogonRight = '' # Deny log on as a service
SeDenyInteractiveLogonRight = '' # Deny log on locally
SeDenyRemoteInteractiveLogonRight = '' # Deny log on through Remote Desktop Services
SeEnableDelegationPrivilege = '' # Enable computer and user accounts to be trusted for delegation
SeRemoteShutdownPrivilege = 'Administrators' # Force shutdown from a remote system
SeAuditPrivilege = 'LOCAL SERVICE', 'NETWORK SERVICE' # Generate security audits
SeImpersonatePrivilege = 'LOCAL SERVICE', 'NETWORK SERVICE', 'Administrators', 'SERVICE' # Impersonate a client after authentication
# SeIncreaseWorkingSetPrivilege - This is not working on Windows 2012R2 Core - It is coded to bypass this setting within the resource.
SeIncreaseWorkingSetPrivilege = 'Users', 'Window Manager Group' # Increase a process working set
SeIncreaseBasePriorityPrivilege = 'Administrators' # Increase scheduling priority
SeLoadDriverPrivilege = 'Administrators' # Load and unload device drivers
SeLockMemoryPrivilege = '' # Lock pages in memory
SeBatchLogonRight = 'Administrators', 'Backup Operators', 'Performance Log Users' # Log on as a batch job
SeServiceLogonRight = 'ALL SERVICES' # Log on as a service
SeSecurityPrivilege = 'Administrators' # Manage auditing and security log
SeRelabelPrivilege = '' # Modify an object label
SeSystemEnvironmentPrivilege = 'Administrators' # Modify firmware environment values
SeManageVolumePrivilege = 'Administrators' # Perform volume maintenance tasks
SeProfileSingleProcessPrivilege = 'Administrators' # Profile single process
SeSystemProfilePrivilege = 'Administrators', 'WdiServiceHost' # Profile system performance
SeUndockPrivilege = 'Administrators' # Remove computer from docking station
SeAssignPrimaryTokenPrivilege = 'LOCAL SERVICE', 'NETWORK SERVICE' # Replace a process level token
SeRestorePrivilege = 'Administrators', 'Backup Operators' # Restore files and directories
SeShutdownPrivilege = 'Administrators', 'Backup Operators' # Shut down the system
SeSyncAgentPrivilege = '' # Synchronize directory service data
SeTakeOwnershipPrivilege = 'Administrators' # Take ownership of files or other objects
```