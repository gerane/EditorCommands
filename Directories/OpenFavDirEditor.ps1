# Open Favorite Folder from List in Editor
## This Command opens a Favirote folder in a new Code window.
## The idea is to add lists of Folders you regularly are needing to open.
Register-EditorCommand `
    -Name "Directories.OpenFavDirEditor" `
    -DisplayName "Open Favorite Folder from List in Editor" `
    -SuppressOutput `
    -ScriptBlock {
        param([Microsoft.PowerShell.EditorServices.Extensions.EditorContext]$context)
        
        $List = @(
            'Home',
            'Documents',
            'OneDrive',
            'Downloads',
            'Google Drive',
            'Dropbox'
        )
                
        $Choices = [System.Management.Automation.Host.ChoiceDescription[]] @($List)
        $Selection = $host.ui.PromptForChoice('', "Please Select a Favorite Folder" , $choices,'0')
        $Name = $List[$Selection]
        if ($Name -eq 'Home')
        {
            $FavDir = $Home
        }
        else 
        {
            $FavDir = Join-Path -Path $HOME -ChildPath $Name
        }
        $psEditor.Workspace.OpenFile($FavDir)
    }