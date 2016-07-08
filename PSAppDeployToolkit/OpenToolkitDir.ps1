# Open Toolkit Folder
## Required Variables:
### $Env:Apps which is the root directory where Toolkits are stored.
## This Command opens a PSAppDeployToolkit Project Directory in a new Code Window.
## There is a bug in the latest few releases of Insiders that breaks opening external Windows.
## This command opens the selected toolkit directory in explorer and a New Code window.
Register-EditorCommand `
    -Name "PSAppDeployToolkit.OpenToolkitDir" `
    -DisplayName "Open Toolkit Directory" `
    -SuppressOutput `
    -ScriptBlock {
        param([Microsoft.PowerShell.EditorServices.Extensions.EditorContext]$context)
        $AppsDirs = Get-ChildItem -Path $Env:Apps -Directory 
        $List = $AppsDirs | Select-Object -ExpandProperty Name -ErrorAction Stop
        $Choices = [System.Management.Automation.Host.ChoiceDescription[]] @($List)
        $Selection = $host.ui.PromptForChoice('', "Please Select a Toolkit" , $choices,'0')
        $Name = $List[$Selection]
        
        $ToolkitSelection = $AppsDirs.FullName | Where-Object { $_ -like "*\$Name" }
        $ToolkitAppDir = Join-Path -Path $ToolkitSelection -ChildPath 'Toolkit' -Resolve
        
        if ($Env:VSCODE_IPC_HOOK -like '*Insiders*')
        {
            code-insiders $ToolkitAppDir
        }
        else 
        {
            code $ToolkitAppDir
        }
        Explorer.exe $ToolkitAppDir
    }