function lg
{ lazygit @args
}
function n
{ nvim @args
}
function ns
{ nvim -c 'lua require("persistence").load()'

}
function g
{ git @args
}
Function n.
{ nvim .
}
Function nl
{nvim -c':e#<2'
}
function e
{
  $tmp = New-TemporaryFile
  yazi --cwd-file $tmp.FullName
  $cwd = Get-Content $tmp.FullName
  if ($cwd -ne $PWD.Path)
  {
    Set-Location $cwd
  }
  Remove-Item $tmp.FullName
}
Function q
{ exit
}
Function gp
{ git pull
}
Function so
{ . $PROFILE
}

Function attackstart
{
  try
  {
    vmrun -T ws start "C:\Users\nicol\OneDrive\Documents\Virtual Machines\Test VM\Test VM.vmx" nogui
  } catch
  { Write-Error "Failed to start the attack VM: $_"
  }
}

Function attackstop
{
  try
  {
    vmrun -T ws stop "C:\Users\nicol\OneDrive\Documents\Virtual Machines\Test VM\Test VM.vmx" hard
  } catch
  { Write-Error "Failed to stop the attack VM: $_"
  }
}

Function targetstart
{
  try
  {
    vmrun -T ws start "C:\Users\nicol\OneDrive\Documents\Virtual Machines\Target\Target.vmx" nogui
  } catch
  { Write-Error "Failed to start the target VM: $_"
  }
}
Function targetstop
{
  try
  {
    vmrun -T ws stop "C:\Users\nicol\OneDrive\Documents\Virtual Machines\Target\Target.vmx" hard
  } catch
  { Write-Error "Failed to stop the target VM: $_"
  }
}

# Environment variables
$env:EDITOR = "nvim"
$env:NVIM_FULL_CONFIG = "true"
$env:TERM = 'xterm-255color'
$env:PATH += ";C:\Users\nicol\sqlite\"
$env:PATH += ";C:\Users\nicol\AppData\Local\Programs\arduino-ide\resources\app\lib\backend\resources\"
$env:PATH += ";C:\Windows\System33"
$env:ARDUINO_CONFIG_FILE = "C:\Users\nicol\.arduinoIDE\arduino-cli.yaml"
$env:FZF_DEFAULT_OPTS="--style=minimal --info=inline --height=20% --reverse"
# $env:_ZO_FZF_OPTS="--style=minimal --info=inline --height=20% --reverse"
$env:FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude .git --exclude .venv"

Set-Alias whereis where.exe
Set-Alias which Get-Command
function gs
{git status
}

function eza_short
{ eza --icons=always --group-directories-first --color=always @args
}
Set-Alias ls eza_short

function eza_alh
{ eza -Alh --group-directories-first --color=always @args
}
Set-Alias la eza_alh

function eza_l
{ eza -l --icons=always --group-directories-first --color=always --git -a @args
}
Set-Alias l eza_l

function ltt
{ eza --tree @args
}
Set-Alias lt ltt

function pk
{
  Invoke-FuzzyKillProcess
  [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
}
function cenv
{
  py -m venv .venv
}
function senv
{
  .venv\Scripts\activate
}

function o
{
  fd --type f --exclude .git --hidden | Invoke-Fzf | ForEach-Object { nvim $_ }
  [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
}

Set-Alias ff fastfetch
Set-Alias open start

# PSReadLine configuration (interactive shell only)
if ($Host.UI.SupportsVirtualTerminal)
{
  Import-Module PSReadLine
  # Set-PSReadLineOption -PredictionSource HistoryAndPlugin
  # Set-PSReadLineOption -PredictionViewStyle Inline
  Set-PSReadLineOption -BellStyle None

  Set-PSReadLineKeyHandler -Chord 'Ctrl+w' -Function BackwardKillWord
  Set-PSReadLineKeyHandler -Key ctrl+d -Function ViExit
  # Set-PSReadLineKeyHandler -Key ctrl+enter -Function AcceptLine
  Set-PSReadLineKeyHandler -Key ctrl+n -Function NextHistory
  Set-PSReadLineKeyHandler -Key ctrl+p -Function PreviousHistory
  Set-PSReadLineKeyHandler -Key ctrl+l -Function ClearScreen

  Set-PSReadLineKeyHandler -Key Ctrl+j -ScriptBlock {
    zoxide query -l | Invoke-Fzf | Set-Location
    [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
  }
  # Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
  Set-PSReadLineKeyHandler -Key Ctrl+r -ScriptBlock {
    Invoke-FuzzyHistory
    [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
  }

  # # open a file (i can't get this to work)
  # Set-PSReadLineKeyHandler -Key Ctrl+o -ScriptBlock {
  #   Get-ChildItem . -Recurse -Attributes !Directory | Invoke-Fzf | % { neovide $_ }
  #   # fd -H -E .git/ | Invoke-Fzf | ForEach-Object { nvim $_ }
  #   [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
  # }

  Set-PSReadLineKeyHandler -Key Ctrl+g -ScriptBlock {
    Get-ChildItem . -Depth 4 -Attributes Directory | Invoke-Fzf | Set-Location
    [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
  }
  Invoke-Expression (& { (zoxide init powershell --cmd j | Out-String) }) # Initialize zoxide
}


function global:prompt
{
  $currentDirectory = (Get-Location).Path

  # Use the $HOME variable for the user's home directory
  $displayPath = $currentDirectory.Replace($HOME, "~")

  # Set the window title
  $Host.UI.RawUI.WindowTitle = $displayPath

  # Display the prompt with the modified path
  Write-Host "$displayPath` ❯" -NoNewline
  return " "
}
