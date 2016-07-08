# Open Dev Toolkit Script
## Required Variables: 
### $env:Dev which is the root directory where the Dev Toolkit is stored.
## This is just a way to open a dev or test type Toolkit that is might have special settings for better debugging or testing code.
## Command opens the Deploy-Application.ps1 of the DevToolkit selected in Code.
Register-EditorCommand `
    -Name "PSAppDeployToolkit.OpenDevToolkitScript" `
    -DisplayName "Open Dev Toolkit Script" `
    -SuppressOutput `
    -ScriptBlock {
        param([Microsoft.PowerShell.EditorServices.Extensions.EditorContext]$context)        
        $TestToolkit = "$Env:Dev\DevToolkit\Toolkit\Deploy-Application.ps1"                                
        $psEditor.Workspace.OpenFile($TestToolkit)
    }