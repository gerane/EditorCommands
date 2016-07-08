## Editor Keybindings

These keyboard shortcuts are stored in the Keybindings.json. This can be accessed via File>Preferences>Keyboard Shortcuts
- **alt+p**: You can set the Editor Commands menu as a Keybinding in Code. I like alt+p
- **ctrl+shift+t**: I also set a Test Task Runner that runs any Pester tests in the open project.
- **ctrl+shift+r**: This runs selected text in the Integrated terminal. f8 still runs selected in the Powershell Extension, which will eventually be merged.

```json
// Place your key bindings in this file to overwrite the defaults
[
    { "key": "ctrl+shift+t",          "command": "workbench.action.tasks.test" },
    { "key": "ctrl+shift+r",          "command": "workbench.action.terminal.runSelectedText" },
    { "key": "alt+p",      "command": "PowerShell.ShowAdditionalCommands",
                                         "when": "editorLangId == 'powershell'" } 
]
```
## Directories
Commands for working with Directories. These are some examples that can easily be edited to add new folders in your own environments. These examples are focused mainly on folders in the Home directory but can be easily altered.

## Emojis
Fun Commands the show some of the ways text selection can be used in the Editor. Commands to insert or replace text with Emojis.
- Requires the Emoji Module.

## GithubProjects
Commands for manipulating Github or Git Repositories
- $Env:Github: Path to directory that contains Github or Git Repositories.

## PlasterTemplates
Commands for working with Plaster. Has Example Templates and Editor Commands.
- The Plaster Templates can by found in my PlasterTemplates Repo. A link is in the Notes section.

## PowerShellEditorServices
Commands for opening PowerShell Profiles. These will eventually be in PowerShellEditorServices by default.

## PSAppDeployToolkit
Commands for working with PSAppDeployToolkit.
- Path for Toolkits is in the following format "$Env:Apps\ToolkitName\Toolkit\Deploy-Application.ps1" etc
- $Env:Apps: Path to directory that contains PSAppDeployToolkit Toolkit Projects
- $Env:Dev: Path to directory that contains Dev or Test Toolkits
- Requires PSAppDeployToolkit

## Todo
Commands for working with Todos in files. Eventually want to add a command to search for files with Todos in the project. The api to access the workspace directory is scheduled to be added in version 7.0

## Contributing
Please feel free to contribute ideas for Editor Commands. I would like to start collecting examples of Editor Commands so people have a good resource to get ideas or see how they work.

## Notes
- Emoji Commands require [Emojis Module](https://www.powershellgallery.com/packages/Emojis/0.1) by [Trevor Sullivan](https://twitter.com/pcgeek86)
- For the Toolkit Commands you need [PSAppDeployToolkit](https://github.com/PSAppDeployToolkit/PSAppDeployToolkit). It is a Software and Configuration Deployment Toolkit.
- Plaster Templates can be found in my [PlasterTemplates](https://github.com/gerane/PlasterTemplates) Repository. 