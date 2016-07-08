# Open Toolkit Script
## Required Variables:
### $env:Apps which is the root directory where Toolkits are stored.
## Prompts user with a list of PSAppDeployToolkit project names based on their directory name.
## Command opens the Deploy-Application.ps1 of the project selected in Code.
Register-EditorCommand `
    -Name "PSAppDeployToolkit.OpenToolkitScript" `
    -DisplayName "Open Toolkit Script" `
    -SuppressOutput `
    -ScriptBlock {
        param([Microsoft.PowerShell.EditorServices.Extensions.EditorContext]$context)
        $AppsDirs = Get-ChildItem -Path $Env:Apps -Directory 
        $List = $AppsDirs | Select-Object -ExpandProperty Name -ErrorAction Stop
        $Choices = [System.Management.Automation.Host.ChoiceDescription[]] @($List)
        $Selection = $host.ui.PromptForChoice('', "Please Select a Toolkit" , $choices,'0')
        $Name = $List[$Selection]
        
        $ToolkitSelection = $AppsDirs.FullName | Where-Object { $_ -like "*\$Name" }
        $ToolkitScript = Join-Path -Path $ToolkitSelection -ChildPath 'Toolkit\Deploy-Application.ps1' -Resolve
        
        $psEditor.Workspace.OpenFile($ToolkitScript)
    }