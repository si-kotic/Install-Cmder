# Identify latest release from: https://github.com/cmderdev/cmder/releases/latest

# Download cmder.zip

# Extract cmder.zip to C:\Program Files\Cmder\
New-Item -Path 'C:\Program Files' -Name "Cmder" -ItemType Directory -Force
Expand-Archive -Path .\Cmder.zip -DestinationPath 'C:\Program Files\' -Force

# Copy ConEmu.xml to C:\Program Files\cmder\vendor\conemu-maximus5\ConEmu.xml
Copy-Item -Path .\ConEmu.xml -Destination "C:\Program Files\cmder\vendor\conemu-maximus5\" -Force

# Import Scheduled Task (to start Cmder) using Cmder.xml
## This involves changing some details in Cmder.xml such as LogonTrigger\UserId
## Might also involve changing Author, some testing is required.
[xml]$schTask = Get-Content .\Cmder.xml
$schTask.task.Triggers.LogonTrigger.UserId = $ENV:USERNAME
$SID = (New-Object System.Security.Principal.NTAccount($ENV:USERDOMAIN,$ENV:USERNAME)).Translate([System.Security.Principal.SecurityIdentifier]).Value
$schTask.Task.Principals.Principal..UserId = $SID
$schTask.Save((Get-Location).Path + "\schTask.xml")
