Function Install-JiraTimesheetModule {

    if(((test-path Jira.Timesheet.Powershell.psd1) -eq $False ) -and ((Test-Path ..\Jira.Timesheet.Powershell.psd1) -eq $False ) ){
        Write-Error -Message "Cannot find Module Manifest." -Category ObjectNotFound
    }

    if((Test-Path ..\Jira.Timesheet.Powershell.psd1) -eq $True) {
        Set-location ..\
    }

    $ModuleVersion = Get-Content -Path "*.psd1" | Select-String -SimpleMatch "ModuleVersion"
    $ModuleVersion = (($ModuleVersion -split '=' | Select-Object -last 1) -replace " ","") -replace "'",''
    $ModuleName    = Get-Content -Path "*.psd1" | Select-String -SimpleMatch "RootModule"
    $ModuleName    = ((($ModuleName -split '=' | Select-Object -last 1) -replace " ","") -replace "'",'') -replace ".psm1",''
    $PSModulePath  = $env:PSModulePath -split ";" | Select-Object -First 1

    Write-Output "Module Parameters:::: ModuleName: $ModuleName ModuleVersion: $ModuleVersion" 
    Write-Output "Creating Directory:::: $PSModulePath\$ModuleName\$ModuleVersion"
    New-Item -Path $PSModulePath\$ModuleName -Name $ModuleVersion -ItemType Directory | Out-Null 

    Get-ChildItem -Recurse | ForEach-Object {
        Write-Output "Copying:::: $_ to Module Folder"
        }

    Copy-Item -path '*' -Destination $PSModulePath\$ModuleName\$ModuleVersion -Recurse | Out-Null

}
Export-ModuleMember -Function Install-JiraTimesheetModule