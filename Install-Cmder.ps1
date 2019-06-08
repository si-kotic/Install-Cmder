# Download latest release from: https://github.com/cmderdev/cmder/releases/latest
Invoke-WebRequest -UseBasicParsing -Uri https://github.com/cmderdev/cmder/releases/latest/download/cmder.zip -OutFile .\Cmder.zip

# Extract cmder.zip to C:\Program Files\Cmder\
New-Item -Path 'C:\Program Files' -Name "Cmder" -ItemType Directory -Force
Expand-Archive -Path .\Cmder.zip -DestinationPath 'C:\Program Files\Cmder\' -Force

# Import Scheduled Task (to start Cmder) using Cmder.xml
## This involves changing some details in Cmder.xml such as LogonTrigger\UserId
## Might also involve changing Author, some testing is required.
#$SID = (New-Object System.Security.Principal.NTAccount($ENV:USERDOMAIN,$ENV:USERNAME)).Translate([System.Security.Principal.SecurityIdentifier]).Value

$taskAction = New-ScheduledTaskAction -Execute "C:\Program Files\cmder\Cmder.exe"
$taskTrigger = New-ScheduledTaskTrigger -AtLogon -User "$ENV:USERDOMAIN\$ENV:USERNAME"
$taskPrincipal = New-ScheduledTaskPrincipal "Contoso\Administrator"
$taskSettings = New-ScheduledTaskSettingsSet -DisallowHardTerminate -AllowStartIfOnBatteries -MultipleInstances IgnoreNew -RestartCount 0 -DontStopIfGoingOnBatteries
$schTask = New-ScheduledTask -Action $taskAction -Trigger $taskTrigger -Principal $taskPrincipal -Settings $taskSettings
Register-ScheduledTask -TaskName Cmder -InputObject $schTask -User "$ENV:USERDOMAIN\$ENV:USERNAME"
Start-ScheduledTask -TaskName Cmder