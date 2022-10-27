@{
	RootModule 		        = 'Jira.Timesheet.Powershell.psm1' 
	ModuleVersion 		    = '1.0.7' 
	CompatiblePSEditions 	= 'Desktop', 'Core' 
	GUID 			        = '0a8b320f-8c4e-475f-873d-2b660c03905c' 
	Author 			        = 'Charlie Boon' 
	CompanyName 		    = 'CBXON Limited' 
	Copyright 		        = '(c) CBXON Limited. All rights reserved.' 
	Description 		    = 'Jira.Timesheet.Powershell'
	FunctionsToExport 	    = 'Add-TimeToJira','New-JiraTimesheet'
	CmdletsToExport 	    = @() 
	VariablesToExport 	    = @() 
	AliasesToExport 	    = @() 
	PrivateData 		    = @{
	PSData 			        = @{} 
	} 
}