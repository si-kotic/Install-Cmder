# Download latest release from: https://github.com/cmderdev/cmder/releases/latest
Invoke-WebRequest -UseBasicParsing -Uri https://github.com/cmderdev/cmder/releases/latest/download/cmder.zip -OutFile .\Cmder.zip

# Extract cmder.zip to C:\Program Files\Cmder\
New-Item -Path 'C:\Program Files' -Name "Cmder" -ItemType Directory -Force
Expand-Archive -Path .\Cmder.zip -DestinationPath 'C:\Program Files\' -Force

# Copy ConEmu.xml to C:\Program Files\cmder\vendor\conemu-maximus5\ConEmu.xml
Copy-Item -Path .\ConEmu.xml -Destination "C:\Program Files\cmder\vendor\conemu-maximus5\" -Force

# Import Scheduled Task (to start Cmder) using Cmder.xml
## This involves changing some details in Cmder.xml such as LogonTrigger\UserId
## Might also involve changing Author, some testing is required.
#$SID = (New-Object System.Security.Principal.NTAccount($ENV:USERDOMAIN,$ENV:USERNAME)).Translate([System.Security.Principal.SecurityIdentifier]).Value
$trigger = New-ScheduledTaskTrigger -AtLogOn -User "$ENV:USERDOMAIN\$ENV:USERNAME"
Register-ScheduledTask -TaskName Cmder -Xml (Get-Content .\Cmder.xml | Out-String) -User "$ENV:USERDNSDOMAIN\$ENV:USERNAME" -Trigger $trigger -Force