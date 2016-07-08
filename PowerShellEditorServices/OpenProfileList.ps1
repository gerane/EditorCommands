# Open Profile from List
## This will prompt the user to select a PowerShell Profile to Open. Should work with any PSES supported Editor.
## This command will eventually be in PSES by default.
Register-EditorCommand `
    -Name 'PowerShellEditorServices.OpenProfileList' `
    -DisplayName 'Open Profile from List (Current User)' `
    -SuppressOutput `
    -ScriptBlock {
        param([Microsoft.PowerShell.EditorServices.Extensions.EditorContext]$context)
        
        $Current = Split-Path -Path $profile -Leaf        
        $List = @($Current,'Microsoft.VSCode_profile.ps1','Microsoft.PowerShell_profile.ps1','Microsoft.PowerShellISE_profile.ps1','Profile.ps1') | Select-Object -Unique
        $Choices = [System.Management.Automation.Host.ChoiceDescription[]] @($List)
        $Selection = $host.ui.PromptForChoice('Please Select a Profile', '(Current User)', $choices,'0')
        $Name = $List[$Selection]
        
        $ProfileDir = Split-Path $Profile -Parent
        $ProfileName = Join-Path -Path $ProfileDir -ChildPath $Name
        
        If (!(Test-Path -Path $ProfileName)) { New-Item -Path $ProfileName -ItemType File }
        
        $psEditor.Workspace.OpenFile($ProfileName)
    }