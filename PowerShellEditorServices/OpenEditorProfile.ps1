# Open Current Editor Profile
## This will open the current Editor's Profile. Should work with any PSES supported Editor.
## This command will eventually be in PSES by default.
Register-EditorCommand `
    -Name 'PowerShellEditorServices.OpenEditorProfile' `
    -DisplayName 'Open Editor Profile' `
    -SuppressOutput `
    -ScriptBlock {
        param([Microsoft.PowerShell.EditorServices.Extensions.EditorContext]$context)
        If (!(Test-Path -Path $Profile)) { New-Item -Path $Profile -ItemType File }
        $psEditor.Workspace.OpenFile($Profile)
    }