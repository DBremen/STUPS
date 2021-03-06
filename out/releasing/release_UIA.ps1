###################################################################################
#  the UIAutomation module release script
# v. 1.0 2013/02/24 the initial version
# v. 1.1 2013/02/27 excluded 3rd party sources
###################################################################################

param(
      [string]$Password,
      [string]$DirName
      )

Set-StrictMode -Version Latest;
if ("" -eq $DirName) {
	Write-Error "Empty dir!";
}

[string]$pathToSignTool = "C:\Program Files (x86)\Windows Kits\8.0\bin\x64\signtool.exe";
[string]$pathToProjectRoot = "C:\Projects\PS\STUPS";
[string]$pathToCertificate = "$($pathToProjectRoot)\certificate\my\SoftwareTestingUsingPowerShell.pfx";
[string]$pathToTimeStamp = "http://timestamp.verisign.com/scripts/timestamp.dll";


# Creating output directories
New-Item -Path "$($pathToProjectRoot)\out\" -Name "$($DirName)" -ItemType directory
New-Item -Path "$($pathToProjectRoot)\out\$($DirName)\" -Name "35" -ItemType directory
New-Item -Path "$($pathToProjectRoot)\out\$($DirName)\" -Name "40" -ItemType directory
New-Item -Path "$($pathToProjectRoot)\out\$($DirName)\" -Name "Metro" -ItemType directory
New-Item -Path "$($pathToProjectRoot)\out\$($DirName)\" -Name "sources" -ItemType directory
New-Item -Path "$($pathToProjectRoot)\out\$($DirName)\" -Name "samples" -ItemType directory
New-Item -Path "$($pathToProjectRoot)\out\$($DirName)\" -Name "JavaAccessSupport" -ItemType directory

# Java Access Support
Copy-Item -Path "$($pathToProjectRoot)\UIA\InstallJavaSupport.ps1" -Destination "$($pathToProjectRoot)\out\$($DirName)\JavaAccessSupport"

function Run-FrameworkSet
{
    param(
          [string]$FolderSuffix,
          [string]$OutputFolderName
          )
    
    Start-Process -FilePath $pathToSignTool -ArgumentList @("sign", "/f", "$($pathToCertificate)", "/t", "$($pathToTimeStamp)", "/p", "$($Password)", "$($pathToProjectRoot)\UIA\UIAutomationSpy$($FolderSuffix)\bin\Release35\UIAutomation.dll") -NoNewWindow -Wait;
    Start-Process -FilePath $pathToSignTool -ArgumentList @("sign", "/f", "$($pathToCertificate)", "/t", "$($pathToTimeStamp)", "/p", "$($Password)", "$($pathToProjectRoot)\UIA\UIAutomationSpy$($FolderSuffix)\bin\Release35\TMX.dll") -NoNewWindow -Wait;
    Start-Process -FilePath $pathToSignTool -ArgumentList @("sign", "/f", "$($pathToCertificate)", "/t", "$($pathToTimeStamp)", "/p", "$($Password)", "$($pathToProjectRoot)\UIA\UIAutomationSpy$($FolderSuffix)\bin\Release35\Tmx.Interfaces.dll") -NoNewWindow -Wait;
    Start-Process -FilePath $pathToSignTool -ArgumentList @("sign", "/f", "$($pathToCertificate)", "/t", "$($pathToTimeStamp)", "/p", "$($Password)", "$($pathToProjectRoot)\UIA\UIAutomationSpy$($FolderSuffix)\bin\Release35\UIAutomationSpy.exe") -NoNewWindow -Wait;
    if ([string]::IsNullOrEmpty($FolderSuffix)) {
        Start-Process -FilePath $pathToSignTool -ArgumentList @("sign", "/f", "$($pathToCertificate)", "/t", "$($pathToTimeStamp)", "/p", "$($Password)", "$($pathToProjectRoot)\UIA\UIAutomationAliases$($FolderSuffix)\bin\Release35\UIAutomationAliases.dll") -NoNewWindow -Wait;
    }
    Start-Process -FilePath $pathToSignTool -ArgumentList @("sign", "/f", "$($pathToCertificate)", "/t", "$($pathToTimeStamp)", "/p", "$($Password)", "$($pathToProjectRoot)\UIA\UIARunner$($FolderSuffix)\bin\Release35\UIARunner.exe") -NoNewWindow -Wait;
    Start-Process -FilePath $pathToSignTool -ArgumentList @("sign", "/f", "$($pathToCertificate)", "/t", "$($pathToTimeStamp)", "/p", "$($Password)", "$($pathToProjectRoot)\UIA\UIARunner$($FolderSuffix)\bin\Release35\PSRunner.dll") -NoNewWindow -Wait;
    Start-Process -FilePath $pathToSignTool -ArgumentList @("sign", "/f", "$($pathToCertificate)", "/t", "$($pathToTimeStamp)", "/p", "$($Password)", "$($pathToProjectRoot)\UIA\UIARunner$($FolderSuffix)\bin\Release35\PSTestRunner.dll") -NoNewWindow -Wait;
    Start-Process -FilePath $pathToSignTool -ArgumentList @("sign", "/f", "$($pathToCertificate)", "/t", "$($pathToTimeStamp)", "/p", "$($Password)", "$($pathToProjectRoot)\UIA\UIARunner$($FolderSuffix)\bin\Release35\PSTestLibrary.dll") -NoNewWindow -Wait;
    if ("Metro" -eq $OutputFolderName) {
        Start-Process -FilePath $pathToSignTool -ArgumentList @("sign", "/f", "$($pathToCertificate)", "/t", "$($pathToTimeStamp)", "/p", "$($Password)", "$($pathToProjectRoot)\UIA\bgshell-21772\NET40\BgShell\bin\Release\*.*") -NoNewWindow -Wait;
    }

    Copy-Item -Path "$($pathToProjectRoot)\UIA\UIAutomationSpy$($FolderSuffix)\bin\Release35\UIAutomation.dll" -Destination "$($pathToProjectRoot)\out\$($DirName)\$($OutputFolderName)"
    Copy-Item -Path "$($pathToProjectRoot)\UIA\UIAutomationSpy$($FolderSuffix)\bin\Release35\TMX.dll" -Destination "$($pathToProjectRoot)\out\$($DirName)\$($OutputFolderName)"
    Copy-Item -Path "$($pathToProjectRoot)\UIA\UIAutomationSpy$($FolderSuffix)\bin\Release35\Tmx.Interfaces.dll" -Destination "$($pathToProjectRoot)\out\$($DirName)\$($OutputFolderName)"
    Copy-Item -Path "$($pathToProjectRoot)\UIA\UIAutomationSpy$($FolderSuffix)\bin\Release35\System.Data.SQLite.dll" -Destination "$($pathToProjectRoot)\out\$($DirName)\$($OutputFolderName)"
    Copy-Item -Path "$($pathToProjectRoot)\UIA\UIAutomationSpy$($FolderSuffix)\bin\Release35\System.Data.SQLite.xml" -Destination "$($pathToProjectRoot)\out\$($DirName)\$($OutputFolderName)"
    Copy-Item -Path "$($pathToProjectRoot)\UIA\UIAutomation$($FolderSuffix)\bin\Release35\*hibe*" -Destination "$($pathToProjectRoot)\out\$($DirName)\$($OutputFolderName)"
    Copy-Item -Path "$($pathToProjectRoot)\UIA\UIAutomation$($FolderSuffix)\bin\Release35\*log*" -Destination "$($pathToProjectRoot)\out\$($DirName)\$($OutputFolderName)"
    Copy-Item -Path "$($pathToProjectRoot)\UIA\UIAutomation$($FolderSuffix)\bin\Release35\*iesi*" -Destination "$($pathToProjectRoot)\out\$($DirName)\$($OutputFolderName)"
    Copy-Item -Path "$($pathToProjectRoot)\UIA\UIAutomation$($FolderSuffix)\bin\Release35\*castle*" -Destination "$($pathToProjectRoot)\out\$($DirName)\$($OutputFolderName)"
    Copy-Item -Path "$($pathToProjectRoot)\UIA\UIAutomation$($FolderSuffix)\bin\Release35\*access*" -Destination "$($pathToProjectRoot)\out\$($DirName)\$($OutputFolderName)"
    Copy-Item -Path "$($pathToProjectRoot)\UIA\UIAutomation$($FolderSuffix)\bin\Release35\*ninj*" -Destination "$($pathToProjectRoot)\out\$($DirName)\$($OutputFolderName)"
    Copy-Item -Path "$($pathToProjectRoot)\UIA\UIAutomation$($FolderSuffix)\bin\Release35\*input*" -Destination "$($pathToProjectRoot)\out\$($DirName)\$($OutputFolderName)"
    Copy-Item -Path "$($pathToProjectRoot)\UIA\UIAutomationSpy$($FolderSuffix)\bin\Release35\UIAutomationSpy.*" -Destination "$($pathToProjectRoot)\out\$($DirName)\$($OutputFolderName)"
    if ([string]::IsNullOrEmpty($FolderSuffix)) {
        Copy-Item -Path "$($pathToProjectRoot)\UIA\UIAutomationAliases$($FolderSuffix)\bin\Release35\UIAutomationAliases.dll" -Destination "$($pathToProjectRoot)\out\$($DirName)\$($OutputFolderName)"
    }
    Copy-Item -Path "$($pathToProjectRoot)\UIA\UIARunner$($FolderSuffix)\bin\Release35\UIARunner.*" -Destination "$($pathToProjectRoot)\out\$($DirName)\$($OutputFolderName)"
    Copy-Item -Path "$($pathToProjectRoot)\UIA\UIARunner$($FolderSuffix)\bin\Release35\PSRunner.dll" -Destination "$($pathToProjectRoot)\out\$($DirName)\$($OutputFolderName)"
    Copy-Item -Path "$($pathToProjectRoot)\UIA\UIARunner$($FolderSuffix)\bin\Release35\PSTestRunner.dll" -Destination "$($pathToProjectRoot)\out\$($DirName)\$($OutputFolderName)"
    Copy-Item -Path "$($pathToProjectRoot)\UIA\UIARunner$($FolderSuffix)\bin\Release35\PSTestLibrary.dll" -Destination "$($pathToProjectRoot)\out\$($DirName)\$($OutputFolderName)"
    if ("Metro" -eq $OutputFolderName) {
        Copy-Item -Path "$($pathToProjectRoot)\UIA\bgshell-21772\NET40\BgShell\bin\Release\*.*" -Destination "$($pathToProjectRoot)\out\$($DirName)\$($OutputFolderName)"
    }
}

Run-FrameworkSet '' '35';
Run-FrameworkSet '40' '40';
Run-FrameworkSet '40Metro' 'Metro';

Copy-Item -Path "$($pathToProjectRoot)\certificate\SoftwareTestingUsingPowerShell.cer" -Destination "$($pathToProjectRoot)\out\$($DirName)\Metro"

# Source code
Start-Process -FilePath "xcopy" -ArgumentList @("$($pathToProjectRoot)\UIA\*.?s*", "$($pathToProjectRoot)\out\$($DirName)\sources\UIA\", "/s", "/v", "/i", "/exclude:exclude_UIA.txt") -NoNewWindow -Wait;
Start-Process -FilePath "xcopy" -ArgumentList @("$($pathToProjectRoot)\PS\*.cs*", "$($pathToProjectRoot)\out\$($DirName)\sources\PS\", "/s", "/v", "/i") -NoNewWindow -Wait;
Start-Process -FilePath "xcopy" -ArgumentList @("$($pathToProjectRoot)\PSTestLib\*.cs*", "$($pathToProjectRoot)\out\$($DirName)\sources\PSTestLib\", "/s", "/v", "/i") -NoNewWindow -Wait;
Copy-Item -Path "$($pathToProjectRoot)\*.sln" -Destination "$($pathToProjectRoot)\out\$($DirName)\sources";

# Samples
Start-Process -FilePath "xcopy" -ArgumentList @("$($pathToProjectRoot)\samples\UIAutomation\*.ps*", "$($pathToProjectRoot)\out\$($DirName)\samples", "/s", "/v", "/i") -NoNewWindow -Wait;
return;
