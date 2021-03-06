function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [parameter(Mandatory = $true)]
        [ValidateSet("CrashOnAuditFail","FullPrivilegeAuditing","AuditBaseObjects","AuditBaseDirectories")]
        [System.String]
        $AdvancedAuditOption
    )
    $ErrorActionPreference = 'Stop'

    #Write-Verbose "Use this cmdlet to deliver information about command processing."
    #Write-Debug "Use this cmdlet to write debug information while troubleshooting."
    $ps = new-object System.Diagnostics.Process
    $ps.StartInfo.Filename = "auditpol.exe"
    $ps.StartInfo.Arguments = " /get /option:$AdvancedAuditOption /r"
    $ps.StartInfo.RedirectStandardOutput = $True
    $ps.StartInfo.UseShellExecute = $false
    $ps.start()
    $ps.WaitForExit('10')
    [string] $Out = $ps.StandardOutput.ReadToEnd();
    
    $curr_audit_option_setting = $Out.split("`r`n")[3]
    if ($debug_script){write-host "Setting: " $curr_audit_option_setting}
    $curr_value = $curr_audit_option_setting.split(",")[4]

    $returnValue = @{
                    AdvancedAuditOption = $AdvancedAuditOption
                    Ensure = $curr_value
                    }

    $returnValue
}

# This will run ONLY if Test-TargetResource is $false
function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory = $true)]
        [ValidateSet("CrashOnAuditFail","FullPrivilegeAuditing","AuditBaseObjects","AuditBaseDirectories")]
        [System.String]
        $AdvancedAuditOption,

        [ValidateSet("Enabled","Disabled")]
        [System.String]
        $Ensure
    )

    #Write-Verbose "Use this cmdlet to deliver information about command processing."

    #Write-Debug "Use this cmdlet to write debug information while troubleshooting."

    #Include this line if the resource requires a system reboot.
    #$global:DSCMachineStatus = 1

    # We need to feed "Enabled" or "Disabled" into the compare; however, we need "Enable" or "Disable" for setting the option
    $lsa_advaudit_action = $Ensure.Substring(0,$Ensure.length - 1)

    $ps = new-object System.Diagnostics.Process
    $ps.StartInfo.Filename = "auditpol.exe"
    $ps.StartInfo.Arguments = " /set /option:$AdvancedAuditOption /value:$lsa_advaudit_action"
    $ps.StartInfo.RedirectStandardOutput = $True
    $ps.StartInfo.UseShellExecute = $false
    $ps.start()
    $ps.WaitForExit('10')
}


function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [parameter(Mandatory = $true)]
        [ValidateSet("CrashOnAuditFail","FullPrivilegeAuditing","AuditBaseObjects","AuditBaseDirectories")]
        [System.String]
        $AdvancedAuditOption,

        [ValidateSet("Enabled","Disabled")]
        [System.String]
        $Ensure
    )
    $ErrorActionPreference = 'Stop'
    #Write-Verbose "Use this cmdlet to deliver information about command processing."
    #Write-Debug "Use this cmdlet to write debug information while troubleshooting."

    $CurrentSetting = Get-TargetResource -AdvancedAuditOption $AdvancedAuditOption

    # Need to test if case sensitivity matters here
    If ($Ensure -eq $CurrentSetting.Ensure)
    {
        return $true
    } else {
        return $false
    }
}

Export-ModuleMember -Function *-TargetResource
