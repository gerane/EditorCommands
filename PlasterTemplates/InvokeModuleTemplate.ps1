# PLaster Module Template
## Required Variables:
### $Env:Github which is the root directory where Git or Github Repositories are stored.
## I have removed any multichoice option and replaced with single choice options since Code does not support multi yet.
## This example sets all defaults but the module name so when using Invole-Plaster the user is only prompted with the name.
## When finished it opens the new module in Code.
## Eventually the Powershell Extension should make some of this easier.
Register-EditorCommand `
    -Name "PlasterTemplates.InvokeModuleTemplate" `
    -DisplayName "Create New Module from Template" `
    -SuppressOutput `
    -ScriptBlock {
        param([Microsoft.PowerShell.EditorServices.Extensions.EditorContext]$context)        
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