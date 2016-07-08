# Open Cloud Storage Folder from List
## This Command opens a Cloud Storage Provider's folder in a new Code window.
## If you use nonstandard folder locations you may have to alter this Editor Command 
Register-EditorCommand `
    -Name "Directories.OpenCloudDirEditor" `
    -DisplayName "Open Cloud Storage Folder from List in Editor" `
    -SuppressOutput `
    -ScriptBlock {
        param([Microsoft.PowerShell.EditorServices.Extensions.EditorContext]$context)
        
        $List = @(
            'OneDrive',
            'Google Drive',
            'Dropbox'
        )
                
        $Choices = [System.Management.Automation.Host.ChoiceDescription[]] @($List)
        $Selection = $host.ui.PromptForChoice('', "Please Select a Cloud Provider" , $choices,'0')
        $Name = $List[$Selection]
        $ProviderDir = Join-Path -Path $HOME -ChildPath $Name        
        $psEditor.Workspace.OpenFile($ProviderDir)
    }