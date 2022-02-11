# VeracodeDeleteOldestSandbox
This is a simple PowerShell script ideally used in an AzureDevOps or Jenkins Pipeline for auto-deleting the oldest sandbox when the Application Profile limit has been reached.


Download the DeleteOldestSandbox.ps1 file.
Edit the DeleteOldestSandbox.ps1 file with the following requirements:
1. Give the exact name of the profile application name for $appname. Example $appname = "Test"
2. Input the maximum number of sandboxes in your application profile. Example $sandboxlimit = 15
3. The PowerShell script requires access to the Veracode Java API jar file. The script uses the name "VeracodeJavaAPI.jar" filename.
This file can be found at https://repo1.maven.org/maven2/com/veracode/vosp/api/wrappers/vosp-api-wrappers-java/

The -vid and -vkey variables reference the Veracode API ID and Veracode API Key from the Veracode Platform.
 
-vid $env:vid Your Veracode API ID from the Veracode Platform

-vkey $env:vkey Your Veracode API Secret Key from the Veracode Platform
