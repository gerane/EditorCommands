Import-Module -Name Emojis

# Replace Selected text with Emoji
## Requires Emokis module by Trevor Sullivan (@pcgeek86)
## Install-Module -Name Emojis
Register-EditorCommand `
    -Name "Emojis.InvokeEmojiSelection" `
    -DisplayName "Replace selected text with emoji" `
    -SuppressOutput `
    -ScriptBlock {
        param([Microsoft.PowerShell.EditorServices.Extensions.EditorContext]$context)
        $EmojiText = $context.CurrentFile.GetText($context.SelectedRange)
        $Emoji = Get-Emoji -Name $EmojiText
        if ($Emoji)
        {
            $context.CurrentFile.InsertText($Emoji, $context.SelectedRange)
            $Selection = $context.SelectedRange.End
            $context.SetSelection($Selection,$Selection)                     
        }
    }
