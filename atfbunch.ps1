<#
	.DESCRIPTION
	The script helps to run ATF scripts by bunches taken from the file:
	- put the script into 'tests\atf' directory.
	- create a text file with tests
	- run the script with necessary input parameters
	
	.PARAMETER Tests
	Specifies file file with a set of tests to run in the followinc format, one test per line
	<Test Suit> -c <Test Case>
	
	.PARAMETER Xml 
	Specifies ATF XML configuration file for Plesk server. It should be generated prior the script launch
	
	.PARAMETER Log
	Specifies a file that will contain an output from the tests run
		
	.EXAMPLE
	PS>.\atfbunch.ps1 -tests bvt.tests -xml plesk.xml -log bvtrun.log
#>

param ([string]$Tests,[string]$Xml,[string]$Log)

foreach ($line in Get-Content .\$tests) { 
	Write-Host $line
	$command = "docker\run" + " atf run -f $xml -s $line" 
	Invoke-Expression $command | Out-File ./$log -Append
}
