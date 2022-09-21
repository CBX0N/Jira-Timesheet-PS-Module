try {
    $script:ModuleRoot = $PSScriptRoot

    # Import all public functions...
    foreach ($function in (Get-ChildItem "${ModuleRoot}\Functions\*.psm1" -Recurse)) {
        Write-Verbose "VScreen.Tenants.Pipeline.PowerShell: Importing $($function.FullName)"
        Import-Module -Name $function.FullName -DisableNameChecking -WarningAction SilentlyContinue -Force -ErrorAction Stop | Out-Null
    }
}
catch{
    Write-Error $_.Exception.Message -ErrorAction Stop
}
