<#	
	.NOTES
	===========================================================================
	 Created on:   	02/09/2022 12:11 PM
	 Created by:   	David Gilmore
	 Filename:     	DeleteOldestSandbox.ps1
	===========================================================================
	.DESCRIPTION
	A PowerShell script for automatically deleting the oldest sandbox when you reach the maximum sandbox limit.
        $appname = "test" - Enter your Veracode Application Name
	$sandboxlimit = 15 - Enter the maximum number of sandboxes for the application profile.
	Veracode Java wrapper download location - https://repo1.maven.org/maven2/com/veracode/vosp/api/wrappers/vosp-api-wrappers-java/
#>
$appname = "test"
$sandboxlimit = 15
echo "Pulling the Application ID List"
java -jar VeracodeJavaAPI.jar -vid $env:vid -vkey $env:vkey -action getapplist | tee appidlist.txt
$veracodeappid = Get-Content .\appidlist.txt | Select-String -Pattern $appname | ForEach-Object{ $_.Line.Split('"')[1]; }
echo "Pulling the Sandbox ID List"
java -jar VeracodeJavaAPI.jar -vid $env:vid -vkey $env:vkey -action getsandboxlist -appid $veracodeappid | tee sandboxlist.txt
$veracodesandboxid = Get-Content .\sandboxlist.txt | Select-String -Pattern "sandbox_id" | ForEach-Object{ $_.Line.Split('"')[9]; }
$oldestsandboxid = Get-Content .\sandboxlist.txt | Select-String -Pattern "sandbox_id" | ForEach-Object{ $_.Line.Split('"')[9]; } | select -First 1
$sandboxidcount = $veracodesandboxid.Count
echo $sandboxidcount
If ($sandboxidcount -eq $sandboxlimit)
{
	
	echo "The sandbox limit has been reached, deleting the oldest sandbox ID $oldestsandboxid"
	java -jar VeracodeJavaAPI.jar -vid $env:vid -vkey $env:vkey -action deletesandbox -sandboxid $oldestsandboxid
}
else
{
	echo "Not at the maximum sandbox limit, moving to the next step"
}
