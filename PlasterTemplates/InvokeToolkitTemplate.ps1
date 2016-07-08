# Plaster Toolkit Template
## Required Variables:
### $Env:Github which is the root directory where Git or Github Repositories are stored.
### $Env:Apps which is the root directory where Toolkits are stored.
## I would change some of these to not prompt Read-Host and manually hardcode them 
## At least until the next release comes out of Powershell extension that should increase the Editor Command timeout. 
## If you take too long when entering information it can currently timeout and kill the command.  
## This Command builds a Toolkit from a Plaster template.
Register-EditorCommand `
    -Name "PlasterTemplates.InvokeToolkitTemplate" `
    -DisplayName "Create New Toolkit from Template" `
    -SuppressOutput `
    -ScriptBlock {
        param([Microsoft.PowerShell.EditorServices.Extensions.EditorContext]$context)        
        [ValidateNotNullOrEmpty()]$Name = Read-Host 'Please type Toolkit Name'
        $Vendor = Read-Host 'Please Enter the Vendor Name'
        $Author = Read-Host 'Please Enter the Author Name'

        $List = @('NonInteractive','Interactive','Silent')        
        $Choices = [System.Management.Automation.Host.ChoiceDescription[]] @($List)
        $Selection = $host.ui.PromptForChoice('', "Please Select a Deploy Mode" , $choices,'0')
        $DeployMode = $List[$Selection]
        
        $ToolkitDir = Join-Path -Path $Env:Apps -ChildPath $Name
        $PlasterParams = @{
            TemplatePath = "$Env:Github\PlasterTemplates\ToolkitTemplate"
            DestinationPath = $ToolkitDir
            Vendor = $Vendor
            ToolkitName = $Name
            DeployMode = $DeployMode         
            Version = '1.0.0'
            Author = $Author
        }
        
        Invoke-Plaster @PlasterParams 
        
        $ToolkitScript = Join-Path -Path $ToolkitDir -ChildPath 'Toolkit\Deploy-Application.ps1'
        $psEditor.Workspace.OpenFile($ToolkitScript)

        explorer.exe "$($ToolkitDir)\Toolkit"  
    }