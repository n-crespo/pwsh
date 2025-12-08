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
Set-Alias ls eza_short
Set-Alias la eza_alh
Set-Alias l eza_l
Set-Alias lt ltt
Set-Alias ff fastfetch
Set-Alias open start
Set-Alias s sfsu

function lg { lazygit @args }
function n { nvim @args }
function ns { nvim -c 'lua require("persistence").load()' }
function g { git @args }
function n. { nvim . }
function q { exit }
function gp { git pull }
function so { . $PROFILE }
function gs {git status }
function eza_short { eza --icons=always --group-directories-first --color=always @args }
function eza_alh { eza -Alh --group-directories-first --color=always @args }
function eza_l { eza -l --icons=always --group-directories-first --color=always --git -a @args }
function ltt { eza --tree @args }
function cenv { py -m venv .venv }
function senv { .venv\Scripts\activate }
function o { fd --type f --exclude .git --hidden | Invoke-Fzf | ForEach-Object { nvim $_ } }
function pk {
  Invoke-FuzzyKillProcess
  [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
}
function e {
  $tmp = New-TemporaryFile
  yazi --cwd-file $tmp.FullName
  $cwd = Get-Content $tmp.FullName
  if ($cwd -ne $PWD.Path)
  {
    Set-Location $cwd
  }
  Remove-Item $tmp.FullName
}
function attackstart {
  try
  {
    vmrun -T ws start "C:\Users\nicol\OneDrive\Documents\Virtual Machines\Test VM\Test VM.vmx" nogui
  } catch
  { Write-Error "Failed to start the attack VM: $_"
  }
}
function attackstop {
  try
  {
    vmrun -T ws stop "C:\Users\nicol\OneDrive\Documents\Virtual Machines\Test VM\Test VM.vmx" hard
  } catch
  { Write-Error "Failed to stop the attack VM: $_"
  }
}
function targetstart {
  try
  {
    vmrun -T ws start "C:\Users\nicol\OneDrive\Documents\Virtual Machines\Target\Target.vmx" nogui
  } catch
  { Write-Error "Failed to start the target VM: $_"
  }
}
function targetstop {
  try
  {
    vmrun -T ws stop "C:\Users\nicol\OneDrive\Documents\Virtual Machines\Target\Target.vmx" hard
  } catch
  { Write-Error "Failed to stop the target VM: $_"
  }
}

function global:prompt {
  $currentDirectory = (Get-Location).Path
  $displayPath = $currentDirectory.Replace($HOME, "~")
  $windowTitle = "${displayPath}: "

  if ($Host.Name -ne "ConsoleHost") {
      $processName = $Host.Name
  }
  else {
      $processName = (Get-Process -Id $PID).ProcessName
      $windowTitle = "${displayPath}"
  }

  # to include the name of the host process even if it's the console, uncomment the line below:
  # $Host.UI.RawUI.WindowTitle = "$windowTitle $processName"
  if ($Host.Name -ne "ConsoleHost") {
      $Host.UI.RawUI.WindowTitle = "${windowTitle}: $($Host.Name)"
  } else {
      $Host.UI.RawUI.WindowTitle = "${displayPath}"
  }

  Write-Host "[win] ${displayPath}` ❯" -NoNewline
  return " "
}

if ($Host.UI.SupportsVirtualTerminal) {
  # interactive shell only
  # [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
  Import-Module PSReadLine
  Set-PSReadLineOption -BellStyle None
  Set-PSReadLineKeyHandler -Chord 'Ctrl+w' -Function BackwardKillWord
  Set-PSReadLineKeyHandler -Key ctrl+d -Function ViExit
  Set-PSReadLineKeyHandler -Key ctrl+n -Function NextHistory
  Set-PSReadLineKeyHandler -Key ctrl+p -Function PreviousHistory
  Set-PSReadLineKeyHandler -Key ctrl+l -Function ClearScreen
  Set-PSReadLineKeyHandler -Key ctrl+enter -Function AcceptLine

  Set-PSReadLineKeyHandler -Key Ctrl+r -ScriptBlock { Invoke-FuzzyHistory }
  Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
  Set-PSReadLineKeyHandler -Key Ctrl+j -ScriptBlock { zoxide query -l | Invoke-Fzf | Set-Location }

  Set-PsFzfOption -TabExpansion
  Set-PsFzfOption -EnableAliasFuzzyEdit # fe
  Set-PsFzfOption -EnableAliasFuzzyKill # fkill
  Set-PsFzfOption -EnableAliasFuzzyScoop # fs
  Set-PsFzfOption -EnableAliasPsFzfRipGrep
  # Set-PsFzfOption -EnableAliasFuzzyEdit # pk

  # Set-PSReadLineOption -PredictionSource HistoryAndPlugin
  # Set-PSReadLineOption -PredictionViewStyle Inline

  # Set-PSReadLineKeyHandler -Key Ctrl+g -ScriptBlock {
  #   Get-ChildItem . -Depth 4 -Attributes Directory | Invoke-Fzf | Set-Location
  # }

  # open a file (i can't get this to work)
  # Set-PSReadLineKeyHandler -Key Ctrl+o -ScriptBlock {
    # Invoke-FuzzyEdit
    # [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
  # }
}

Invoke-Expression (& { (zoxide init powershell --cmd j | Out-String) }) # Initialize zoxide
Invoke-Expression (&sfsu hook)
