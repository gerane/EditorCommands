# PLaster List Template
## Required Variables:
### $Env:Github which is the root directory where Git or Github Repositories are stored.
### $Env:Apps which is the root directory where Toolkits are stored.
## Example of using an Editor Command to combine multiple different Commands
Register-EditorCommand `
    -Name "PlasterTemplates.InvokeTemplateList" `
    -DisplayName "Create Template from List" `
    -SuppressOutput `
    -ScriptBlock {
        param([Microsoft.PowerShell.EditorServices.Extensions.EditorContext]$context)
        $List = @('Toolkit','Module')        
        $Choices = [System.Management.Automation.Host.ChoiceDescription[]] @($List)
        $Selection = $host.ui.PromptForChoice('', "Please Select a Plaster Template" , $choices,'0')
        $Template = $List[$Selection]

        switch ($Template)
        {
            'Toolkit'
            {
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

            'Module'
            {
                [ValidateNotNullOrEmpty()]$Name = Read-Host 'Please type Module Name'
        
                $PlasterParams = @{
                    TemplatePath = "$Env:Github\PlasterTemplates\ModuleTemplate"
                    Destination = "$Env:Github\$Name"
                    ModuleName = "$Name"
                    FullName = 'Brandon Padgett'
                    Version = '0.0.1'
                    Git = 'Yes'
                    PSake = 'Yes'
                    Pester = 'Yes'
                    PSDeploy = 'Yes'
                    AppVeyor = 'Yes'
                    PlatyPS = 'Yes'
                    ReadTheDocs = 'Yes'
                    Editor = 'VSCode'
                    License = 'MIT'
                }

                Invoke-Plaster @PlasterParams 
            
                if ($Env:VSCODE_IPC_HOOK -like '*Insiders*')
                {
                    code-insiders "$Env:Github\$Name"
                }
                else 
                {
                    code "$Env:Github\$Name"
                }
            }
        }
    }