Function New-JiraTimesheet {
<#

.SYNOPSIS
Creates Timesheet CSV file to be used with RestAPI for Logging Time in Jira

.DESCRIPTION

    $Path = C:\temp\temp.csv
    $Days = 10

#>
param(
     [Parameter()][int]$Days = 1,
     [Parameter()][string]$Path = 'C:\temp\temp.csv',
     [Parameter(Mandatory=$false)][Switch]$StandardMeetings,
     [Parameter(Mandatory=$false)][Switch]$Today
     )


[System.Collections.ArrayList]$csv = @()

$i = 1

While($i -le $Days){ 
    $i = $i

    if($Today -eq $true){ $i = 0 }

    if((get-date).AddDays(-$i).ToString("ddd") -notlike "sat" -and (get-date).AddDays(-$i).ToString("ddd") -notlike "sun"-and (get-date).AddDays(-$i).ToString("ddd") -notlike "fri"){
        $val = [pscustomobject]@{
            Day              = (get-date).AddDays(-$i).ToString("MM-ddd")
            Date             = (get-date).AddDays(-$i).ToString("MM-dd")
            Started          = "2022-" + (get-date).AddDays(-$i).ToString("MM-dd") + "T08:00:00.000+0000"
            timeSpentSeconds = "7200"
            comment          = "Fill IN"
            issue            = "Fill IN"
        }

        $csv.Add($val) | Out-Null 

        if($StandardMeetings -eq $true){
            $val = [pscustomobject]@{
                Day              = (get-date).AddDays(-$i).ToString("MM-ddd")
                Date             = (get-date).AddDays(-$i).ToString("MM-dd")
                Started          = "2022-" + (get-date).AddDays(-$i).ToString("MM-dd") + "T10:00:00.000+0000"
                timeSpentSeconds = "3600"
                comment          = ""
                issue            = "AZDO01-1"
            }

            $csv.Add($val) | Out-Null 

        }

        $val = [pscustomobject]@{
            Day              = (get-date).AddDays(-$i).ToString("MM-ddd")
            Date             = (get-date).AddDays(-$i).ToString("MM-dd")
            Started          = "2022-" + (get-date).AddDays(-$i).ToString("MM-dd") + "T13:00:00.000+0000"
            timeSpentSeconds = "10800"
            comment          = "Fill IN"
            issue            = "Fill IN"
        }

        $csv.Add($val) | Out-Null 
    }

    elseif((get-date).AddDays(-$i).ToString("ddd") -like "Fri"){
        $val = [pscustomobject]@{
            Day              = (get-date).AddDays(-$i).ToString("MM-ddd")
            Date             = (get-date).AddDays(-$i).ToString("MM-dd")
            Started          = "2022-" + (get-date).AddDays(-$i).ToString("MM-dd") + "T08:00:00.000+0000"
            timeSpentSeconds = "10800"
            comment          = "Fill IN"
            issue            = "Fill IN"
        }

        $csv.Add($val) | Out-Null 

        if($StandardMeetings -eq $true){
            $val = [pscustomobject]@{
                Day              = (get-date).AddDays(-$i).ToString("MM-ddd")
                Date             = (get-date).AddDays(-$i).ToString("MM-dd")
                Started          = "2022-" + (get-date).AddDays(-$i).ToString("MM-dd") + "T11:00:00.000+0000"
                timeSpentSeconds = "3600"
                comment          = ""
                issue            = "AZDO01-1"
            }

            $csv.Add($val) | Out-Null 

        }

        $val = [pscustomobject]@{
            Day              = (get-date).AddDays(-$i).ToString("MM-ddd")
            Date             = (get-date).AddDays(-$i).ToString("MM-dd")
            Started          = "2022-" + (get-date).AddDays(-$i).ToString("MM-dd") + "T13:00:00.000+0000"
            timeSpentSeconds = "10800"
            comment          = "Fill IN"
            issue            = "Fill IN"
        }

        $csv.Add($val) | Out-Null 
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