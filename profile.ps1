# Environment variables
$env:EDITOR = "nvim"
$env:NVIM_FULL_CONFIG = "true"
$env:TERM = 'xterm-255color'
$env:PATH += ";C:\Users\nicol\sqlite\"
$env:PATH += ";C:\Users\nicol\AppData\Local\Programs\arduino-ide\resources\app\lib\backend\resources\"
$env:PATH += ";C:\Windows\System33"
$env:ARDUINO_CONFIG_FILE = "C:\Users\nicol\.arduinoIDE\arduino-cli.yaml"
$env:FZF_DEFAULT_OPTS="--style=minimal --info=inline --height=20% --reverse"
$env:FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude .git --exclude .venv"
# $env:_ZO_FZF_OPTS="--style=minimal --info=inline --height=20% --reverse"
# $PSModuleAutoLoadingPreference = 'None'
# Import-Module Microsoft.PowerShell.Utility
# Import-Module Microsoft.PowerShell.Management
# Import-Module PsFzf

function lg { lazygit @args }
function n { nvim @args }
function ns { nvim -c 'lua require("persistence").load()' }
function g { git @args }
function n. { nvim . }
function q { exit }
function gp { git pull }
function so { . $PROFILE }
function gs { git status }
function tt { ttyper }
function eza_short { eza --icons=always --group-directories-first --color=always @args }
function eza_alh { eza -Alh --group-directories-first --color=always @args }
function eza_l { eza -l --icons=always --group-directories-first --color=always --git -a @args }
function ltt { eza --tree @args }
function cenv { py -m venv .venv }
function senv { .venv\Scripts\activate }
function o { fd --type f --exclude .git --hidden | Invoke-Fzf | ForEach-Object { nvim $_ } }
function e {
  $tmp = New-TemporaryFile
  yazi --cwd-file $tmp.FullName
  $cwd = Get-Content $tmp.FullName
  if ($cwd -ne $PWD.Path) { Set-Location $cwd }
  Remove-Item $tmp.FullName
}
function attackstart {
  try {
    vmrun -T ws start "C:\Users\nicol\OneDrive\Documents\Virtual Machines\Test VM\Test VM.vmx" nogui
  } catch { Write-Error "Failed to start the attack VM: $_" }
}
function attackstop {
  try {
    vmrun -T ws stop "C:\Users\nicol\OneDrive\Documents\Virtual Machines\Test VM\Test VM.vmx" hard
  } catch { Write-Error "Failed to stop the attack VM: $_" }
}
function targetstart {
  try {
    vmrun -T ws start "C:\Users\nicol\OneDrive\Documents\Virtual Machines\Target\Target.vmx" nogui
  } catch { Write-Error "Failed to start the target VM: $_" }
}
function targetstop {
  try {
    vmrun -T ws stop "C:\Users\nicol\OneDrive\Documents\Virtual Machines\Target\Target.vmx" hard
  } catch { Write-Error "Failed to stop the target VM: $_" }
}
function global:prompt {
  # using automatic variable $pwd is faster than calling Get-Location
  $displayPath = $pwd.Path -replace [regex]::Escape($HOME), "~"

  # direct .NET write is faster than Write-Host for the OSC sequence
  if ($pwd.Provider.Name -eq "FileSystem") {
      [Console]::Write("$([char]27)]9;9;`"$($pwd.Path)`"$([char]27)\")
  }

  # update window title
  if ($Host.Name -ne "ConsoleHost") {
      $Host.UI.RawUI.WindowTitle = "$(displayPath): $($Host.Name)"
  } else {
      $Host.UI.RawUI.WindowTitle = $displayPath
  }

  [Console]::Write("[win] $displayPath ❯")
  return " "
}

Set-Alias whereis where.exe
Set-Alias which Get-Command
Set-Alias ls eza_short
Set-Alias la eza_alh
Set-Alias l eza_l
Set-Alias lt ltt
Set-Alias ff fastfetch
Set-Alias open start
Set-Alias s sfsu

Set-PSReadlineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

# if ($Host.UI.SupportsVirtualTerminal) {
#   Import-Module PSReadLine
#   Set-PSReadLineOption -BellStyle None
#   Set-PSReadLineKeyHandler -Key Ctrl+r -ScriptBlock { Invoke-FuzzyHistory }
#   Set-PSReadLineKeyHandler -Key Ctrl+j -ScriptBlock { zoxide query -l | Invoke-Fzf | Set-Location }

Invoke-Expression (& { (zoxide init powershell --cmd j | Out-String) }) # Initialize zoxide
Invoke-Expression (&sfsu hook)
