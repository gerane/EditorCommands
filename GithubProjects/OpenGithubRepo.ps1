# Open Github Repository
## Required Variables:
### $Env:Github which is the root directory where Git or Github Repositories are stored.
## There is a bug in the latest few releases of Insiders that breaks opening external Windows.
## This Command opens a Github Repository in a new code window.
Register-EditorCommand `
    -Name "GithubProjects.OpenGithubRepo" `
    -DisplayName "Open Github Repo in New Window" `
    -SuppressOutput `
    -ScriptBlock {
        param([Microsoft.PowerShell.EditorServices.Extensions.EditorContext]$context)
        $Repos = Get-ChildItem -Path $Env:Github
        $List = $Repos | Select-Object -ExpandProperty Name -ErrorAction Stop
        $Choices = [System.Management.Automation.Host.ChoiceDescription[]] @($List)
        $Selection = $host.ui.PromptForChoice('', "Please Select a Repository" , $choices,'0')
        $Name = $List[$Selection]
        
        $RepoSelection = $Repos.FullName | Where-Object { $_ -like "*\$Name" }        

	    if ($Env:VSCODE_IPC_HOOK -like '*Insiders*')
        {
            code-insiders $RepoSelection
        }
        else 
        {
            code $RepoSelection
        }              
    }