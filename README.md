# Install-Cmder
This script downloads the latest version of Cmder, installs it and creates a Scheduled Task to launch Cmder at the point of logging on for the current user.

A customised settings file is provided if you wish to import it after install.

## Usage
### Installation
1. Download and extract https://github.com/si-kotic/Install-Cmder/archive/master.zip
1. Launch Powershell and navigate to the recently extracted `master` folder
1. Run `& .\Install-Cmder.ps1`

### Importing Settings
1. Once Cmder has been succesfully installed, right-hand click on the Title Bar for Cmder and select Settings
1. Click on Import at the bottom of the Settings window.
1. Select the `ConEmu.xml` file from the `master` folder and click OK
1. Click Confirm (Import settings via merging)
1. Click OK on the subsequent prompt
1. Click Save settings at the bottom of the Settings window.