
configuration Sample_cUserRight
{
    param
    (
        [String[]]$ComputerName = 'localhost'
    )

    Import-DscResource -ModuleName cUserRightsAssignment

    node $ComputerName
    {
        cUserRight BatchLogonRight
        {
            Ensure    = 'Present'
            Constant  = 'SeBatchLogonRight'
            Principal = 'BUILTIN\Power Users'
        }

        cUserRight ServiceLogonRight
        {
            Ensure    = 'Present'
            Constant  = 'SeServiceLogonRight'
            Principal = 'BUILTIN\Power Users'
        }
    }
}

Sample_cUserRight -OutputPath "$Env:SystemDrive\Sample_cUserRight"

Start-DscConfiguration -Path "$Env:SystemDrive\Sample_cUserRight" -Force -Verbose -Wait

Get-DscConfiguration
