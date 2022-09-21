Function Add-TimeToJira {
<#

.SYNOPSIS
Creates Timesheet CSV file to be used with RestAPI for Logging Time in Jira

.DESCRIPTION

    $Path = 'C:\temp\temp.csv'
    $numberODays = 10

#>
param(
    [Parameter()][ValidateNotNull()][System.Management.Automation.PSCredential][System.Management.Automation.Credential()]$Credential = [System.Management.Automation.PSCredential]::Empty,
    [Parameter()][ValidateNotNull()][string]$Path = 'C:\temp\temp.csv'
     )

$username = $Credential.userName.ToString()
$authInfo = [System.Text.Encoding]::UTF8.GetBytes((“{0}:{1}” -f $username,([Runtime.InteropServices.Marshal]::PtrToStringBSTR([Runtime.InteropServices.Marshal]::SecureStringToBSTR($Credential.Password)))))
$authInfo = [System.Convert]::ToBase64String($authInfo)

$csv = Import-Csv -path $Path

Foreach($row in $csv){
    $Body = @{
        comment          = $row.comment
        started          = $row.Started
        timeSpentSeconds = $row.timeSpentSeconds
    }

    $Body = $Body | ConvertTo-Json
    $uri  = 'https://jira.vscreen.org/rest/api/2/issue/' + $row.issue + '/worklog'

    Invoke-RestMethod -Uri $uri -Headers @{Authorization = "Basic $authInfo"} -Method Post -Body $Body -ContentType application/json

    }
}
Export-ModuleMember -Function Add-TimeToJira