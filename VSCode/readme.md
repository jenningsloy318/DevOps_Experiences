## Settings on Linux 
1. installed plugins:
```sh
# code --list-extensions
batisteo.vscode-django
bierner.markdown-preview-github-styles
cg-cnu.vscode-path-tools
christian-kohler.path-intellisense
csholmq.excel-to-markdown-table
donjayamanne.jupyter
donjayamanne.python-extension-pack
fabiospampinato.vscode-open-in-application
fallenwood.vimL
haaaad.ansible
ionutvmi.path-autocomplete
JerryHong.autofilename
jinsihou.diff-tool
john681611.relativepath
magicstack.MagicPython
mohsen1.prettify-json
ms-python.python
ms-vscode.Go
ryu1kn.partial-diff
samuelcolvin.jinjahtml
shd101wyy.markdown-preview-enhanced
tht13.python
timonwong.ansible-autocomplete
tomoki1207.pdf
VisualStudioExptTeam.vscodeintellicode
vscoss.vscode-ansible
wholroyd.jinja
vscode-blink-mind
vscod-mindmap
```


2. Settings
```json
{
    "markdown-preview-enhanced.codeBlockTheme": "github.css",
    "workbench.editor.enablePreview": false,
    "workbench.activityBar.visible": true,
    "workbench.statusBar.visible": true,
    "workbench.sideBar.location": "left",
    "files.eol": "\n",
    "editor.minimap.enabled": false,
    "editor.wordWrap": "on",
    "window.zoomLevel": 0,
    "editor.acceptSuggestionOnEnter": true,
    "editor.tabCompletion": true,
    "workbench.startupEditor": "newUntitledFile",
    "extensions.ignoreRecommendations": true,
    "extensions.showRecommendationsOnlyOnDemand": true,
    "git.ignoreMissingGitWarning": true,
    "workbench.editor.tabSizing": "fit",
    "workbench.editor.showTabs": true,
    "go.autocompleteUnimportedPackages": true,
    "workbench.editor.tabCloseButton": "left",
    "editor.tabSize": 2,
    "files.exclude": {
    "**/.git": false,
    "**/.svn": true,
    "**/.hg": true,
    "**/CVS": true,
    "**/.DS_Store": true
    },
    "editor.suggestSelection": "first",
    "vsintellicode.modify.editor.suggestSelection": "automaticallyOverrodeDefaultValue",
    "openInApplication.applications": {
          "docx": "wps", 
          "doc": "wps",
          "ppt": "wpp",
          "pptx": "wpp",
          "xls": "et",
          "xlsx": "et"
        }

}
``` 



## Settings on Windows 
1. installed plugins:
```sh
# code --list-extensions
bierner.markdown-preview-github-styles
cg-cnu.vscode-path-tools
christian-kohler.path-intellisense
csholmq.excel-to-markdown-table
cssho.vscode-svgviewer
DavidAnson.vscode-markdownlint
doublefint.pgsql
florianloch.text-transform
haaaad.ansible
in4margaret.compareit
ionutvmi.path-autocomplete
jakob101.RelativePath
JerryHong.autofilename
jinsihou.diff-tool
magicstack.MagicPython
mdickin.markdown-shortcuts
mohsen1.prettify-json
ms-python.python
ms-vscode.azure-account
ms-vscode.Go
ms-vscode.powershell
samuelcolvin.jinjahtml
sandcastle.vscode-open
SAPSE.vscode-cds
tht13.python
timonwong.ansible-autocomplete
tomoki1207.pdf
tushortz.python-extended-snippets
vscoss.vscode-ansible
wholroyd.jinja
```

2. Settings 
```json
// Place your settings in this file to overwrite the default settings
{  "editor.fontSize": 12,
    "workbench.editor.enablePreview": false,
    "terminal.external.windowsExec": "C:\\WINDOWS\\system32\\bash.exe",
    "terminal.integrated.shell.windows": "C:\\WINDOWS\\system32\\bash.exe",
    "terminal.integrated.shellArgs.windows":["--login"],
    "terminal.integrated.fontSize": 12,
    "terminal.integrated.rightClickCopyPaste": true,
    "workbench.activityBar.visible": true,
    "workbench.statusBar.visible": true,
    "workbench.sideBar.location": "left",
    "files.eol": "\n",
    "editor.minimap.enabled": false,
    "editor.wordWrap": "on",
    "window.zoomLevel": 0,
    "editor.acceptSuggestionOnEnter": true, 
    "editor.tabCompletion": true,
    "workbench.startupEditor": "newUntitledFile",
    "workbench.panel.location": "right",
    "extensions.ignoreRecommendations": true,
    "extensions.showRecommendationsOnlyOnDemand": true,
    "git.ignoreMissingGitWarning": true,
    "workbench.editor.tabSizing": "fit",
    "workbench.editor.showTabs": true,
    "go.autocompleteUnimportedPackages": true,
    "workbench.editor.tabCloseButton": "left",
    "editor.tabSize": 2,
    "files.exclude": {
        "**/.git": false,
        "**/.svn": true,
        "**/.hg": true,
        "**/CVS": true,
        "**/.DS_Store": true
      },
}
```