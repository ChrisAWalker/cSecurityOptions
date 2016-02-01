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

```powershell
configuration AdvancedAudit
{
    Import-DscResource -ModuleName cSecurityOptions

    Node localhost
    {
        AdvancedAuditing AdvancedAuditSetting
        {
            Category = "Account Logon;Credential Validation"
            # "System;IPsec Driver","System;System Integrity","System;Security System Extension","System;Security State Change","System;Other System Events","Logon/Logoff;Network Policy Server","Logon/Logoff;Other Logon/Logoff Events","Logon/Logoff;Special Logon","Logon/Logoff;IPsec Extended Mode","Logon/Logoff;IPsec Quick Mode","Logon/Logoff;IPsec Main Mode","Logon/Logoff;Account Lockout","Logon/Logoff;Logoff","Logon/Logoff;Logon","Logon/Logoff;User / Device Claims","Object Access;SAM","Object Access;Kernel Object","Object Access;Registry","Object Access;Application Generated","Object Access;Handle Manipulation","Object Access;File Share","Object Access;Filtering Platform Packet Drop","Object Access;Filtering Platform Connection","Object Access;Other Object Access Events","Object Access;Detailed File Share","Object Access;Removable Storage","Object Access;Central Policy Staging","Object Access;Certification Services","Object Access;File System","Privilege Use;Other Privilege Use Events","Privilege Use;Non Sensitive Privilege Use","Privilege Use;Sensitive Privilege Use","Detailed Tracking;RPC Events","Detailed Tracking;DPAPI Activity","Detailed Tracking;Process Termination","Detailed Tracking;Process Creation","Policy Change;Audit Policy Change","Policy Change;MPSSVC Rule-Level Policy Change","Policy Change;Filtering Platform Policy Change","Policy Change;Authorization Policy Change","Policy Change;Authentication Policy Change","Policy Change;Other Policy Change Events","Account Management;Security Group Management","Account Management;Distribution Group Management","Account Management;Other Account Management Events","Account Management;Application Group Management","Account Management;Computer Account Management","Account Management;User Account Management","DS Access;Directory Service Changes","DS Access;Directory Service Replication","DS Access;Directory Service Access","DS Access;Detailed Directory Service Replication","Account Logon;Other Account Logon Events","Account Logon;Kerberos Service Ticket Operations","Account Logon;Credential Validation","Account Logon;Kerberos Authentication Service"
            AuditLevel = 'No Auditing'
            #AuditLevel = "Success"
            #AuditLevel = "Failure"
            #AuditLevel = "Success and Failure"
            # "No Auditing","Success","Failure","Success and Failure"
        }
    }
}

AdvancedAudit
Start-DscConfiguration -Path AdvancedAudit -Wait -Verbose -Force -Debug

```

```powershell
configuration SecurityAuditOptions
{
    Import-DscResource -ModuleName cSecurityOptions

    Node localhost
    {
        AdvancedAuditOptions AuditBaseDirectories
        {
            AdvancedAuditOption = 'AuditBaseDirectories'
            # "CrashOnAuditFail","FullPrivilegeAuditing","AuditBaseObjects","AuditBaseDirectories"
            Ensure = 'Disabled'
            #Ensure = 'Enabled'
            # "Enabled", "Disabled"
        }
    }
}

SecurityAuditOptions
Start-DscConfiguration -Path SecurityAuditOptions -Wait -Verbose -Force -Debug

```

##Resources - User Rights Assignments
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

##Resources - Advanced Audit Policies

For Advanced Auditing to work properly, a security option must be set correctly:

# This setting will render the Base/Basic Audit Policy Settings disabled.  The GUI/MMC will not implement the Audit policy settings defined above.
# 1 = Enable Advanced Audit Policies, 0 = Disable (only apply basic audit policies)
# https://support.microsoft.com/en-us/kb/2573113
HKLM\System\CurrentControlSet\Control\Lsa\SCENoApplyLegacyAuditPolicy = 1

This can be done via the next module that I'll be releasing, or manually from here:
Local Security Policy >> Local Policies >> Security Options >> Audit: Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings = Enabled