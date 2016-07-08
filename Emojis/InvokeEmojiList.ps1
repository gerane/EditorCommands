Import-Module -Name Emojis

# Insert Emoji from list at cursor
## Requires Emokis module by Trevor Sullivan (@pcgeek86)
## Install-Module -Name Emojis
Register-EditorCommand `
    -Name "Emokis.EmojiFromList" `
    -DisplayName "Inserts an Emoji from List" `
    -SuppressOutput `
    -ScriptBlock {
        param([Microsoft.PowerShell.EditorServices.Extensions.EditorContext]$context)
        $Names = (Get-Command -name Get-Emoji).Parameters['Name'].Attributes.ValidValues
        $caption = "Please select an Emoji"
        $message = " "
        [int]$defaultChoice = 0
        $Choices = [System.Management.Automation.Host.ChoiceDescription[]] @($Names)

        $Name = $host.ui.PromptForChoice($caption,$message, $choices,$defaultChoice)
        $Emoji = Get-Emoji -name $Names[$Name]
        $context.CurrentFile.InsertText($Emoji, $context.CursorPosition)
        $Selection = $context.SelectedRange.End

        # int startLine, int startColumn, int endLine, int endColumn
        $context.SetSelection($Selection.Line,($Selection.Column + 2),$Selection.Line,($Selection.Column + 2))
    }
