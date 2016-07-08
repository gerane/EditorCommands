# Insert Todo
## Inserts a TODO message at the cursors current position.
Register-EditorCommand `
    -Name 'Todo.InsertTodo' `
    -DisplayName 'Insert Todo' `
    -SuppressOutput `
    -ScriptBlock {
        param([Microsoft.PowerShell.EditorServices.Extensions.EditorContext]$context)
        $Message = Read-Host 'Please enter Todo Message'
        $ToDo = "#TODO [$((Get-Date).ToShortDateString())]: $($Message)"
        $context.CurrentFile.InsertText($ToDo, $context.CursorPosition)
    }