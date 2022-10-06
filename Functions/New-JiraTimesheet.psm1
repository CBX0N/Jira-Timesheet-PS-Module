function TimeEntryStandard {
    param(
     [Parameter()] [string] $Issue            = 'Fill IN',
     [Parameter()] [string] $Comment          = 'Fill IN',
     [Parameter()] [string] $TimeStarted      = "T08:00:00",
     [Parameter()] [string] $timeSpentSeconds = "7200"
     )

    $val = [pscustomobject]@{
        Started          = "2022-" + (get-date).AddDays(-$i).ToString("MM-dd") + $TimeStarted + ".000+0000"
        timeSpentSeconds = $timeSpentSeconds
        comment          = $Comment
        issue            = $Issue
    }

    $csv.Add($val) | Out-Null 
    
}

Function New-JiraTimesheet {
<#

.SYNOPSIS
Creates Timesheet CSV file to be used with RestAPI for Logging Time in Jira

.DESCRIPTION

    $Path = C:\temp\temp.csv
    $Days = 10

#>
param(
     [Parameter()]                 [int]    $Days = 1,
     [Parameter()]                 [string] $Path = 'C:\temp\temp.csv',
     [Parameter(Mandatory=$false)] [Switch] $HourBehind,
     [Parameter(Mandatory=$false)] [Switch] $Today
     )

[System.Collections.ArrayList]$csv = @()

$i = 1

While($i -le $Days){ 
    $i = $i

    if($Today -eq $true){ $i = 0 }

    if((get-date).AddDays(-$i).ToString("ddd") -notlike "sat" -and (get-date).AddDays(-$i).ToString("ddd") -notlike "sun"-and (get-date).AddDays(-$i).ToString("ddd") -notlike "fri"){   
        
        if($HourBehind -eq $true){ TimeEntryStandard -Issue "Fill IN" -Comment "Fill IN" -TimeStarted "T07:00:00" -timeSpentSeconds "7200" } 
        else { TimeEntryStandard -Issue "Fill IN" -Comment "Fill IN" -TimeStarted "T08:00:00" -timeSpentSeconds "7200" }
        
        if($HourBehind -eq $true){ TimeEntryStandard -Issue "AZDO01-1" -Comment "" -TimeStarted "T09:00:00" -timeSpentSeconds "3600" } 
        else{ TimeEntryStandard -Issue "AZDO01-1" -Comment "" -TimeStarted "T10:00:00" -timeSpentSeconds "3600" }

        if($HourBehind -eq $true){ TimeEntryStandard -Issue "Fill IN" -Comment "Fill IN" -TimeStarted "T10:00:00" -timeSpentSeconds "3600" } 
        else { TimeEntryStandard -Issue "Fill IN" -Comment "Fill IN" -TimeStarted "T11:00:00" -timeSpentSeconds "3600" }

        if($HourBehind -eq $true){ TimeEntryStandard -Issue "Fill IN" -Comment "Fill IN" -TimeStarted "T11:30:00" -timeSpentSeconds "12600" } 
        else{ TimeEntryStandard -Issue "Fill IN" -Comment "Fill IN" -TimeStarted "T12:30:00" -timeSpentSeconds "12600" }
    }
    
    elseif((get-date).AddDays(-$i).ToString("ddd") -like "Fri"){
        
        if($HourBehind -eq $true){ TimeEntryStandard -Issue "Fill IN" -Comment "Fill IN" -TimeStarted "T07:00:00" -timeSpentSeconds "10800" } 
        else { TimeEntryStandard -Issue "Fill IN" -Comment "Fill IN" -TimeStarted "T08:00:00" -timeSpentSeconds "10800" }

        if($HourBehind -eq $true){ TimeEntryStandard -Issue "AZDO01-1" -Comment "" -TimeStarted "T10:30:00" -timeSpentSeconds "5400" } 
        else{ TimeEntryStandard -Issue "AZDO01-1" -Comment "" -TimeStarted "T11:30:00" -timeSpentSeconds "5400" }
        
        if($HourBehind -eq $true){ TimeEntryStandard -Issue "Fill IN" -Comment "Fill IN" -TimeStarted "T12:00:00" -timeSpentSeconds "10800" } 
        else{ TimeEntryStandard -Issue "Fill IN" -Comment "Fill IN" -TimeStarted "T13:00:00" -timeSpentSeconds "10800" }
    }
    else {
        $Days = $Days + 1
    }

    $i = $i +1

    if($Today -eq $true){ break }

}

$csv | export-csv -path $Path -Delimiter ',' -NoTypeInformation

} 

Export-ModuleMember -Function New-JiraTimesheet