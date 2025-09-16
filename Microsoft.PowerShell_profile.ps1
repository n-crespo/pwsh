function lg
{ lazygit @args
}
function n
{ nvim @args
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
Function e
{ yazi
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
$ENV:EDITOR = "nvim"
$env:NVIM_FULL_CONFIG = 2
$env:TERM = 'xterm-255color'
$env:PATH += ";C:\Users\nicol\sqlite\"
$env:PATH += ";C:\Users\nicol\AppData\Local\Programs\arduino-ide\resources\app\lib\backend\resources\"
$env:PATH += ";C:\Windows\System33"
$env:Path += ";C:\Users\user\AppData\Local\Programs\oh-my-posh\bin"
$env:ARDUINO_CONFIG_FILE = "C:\Users\nicol\.arduinoIDE\arduino-cli.yaml"
$env:FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git --exclude .venv'
$env:FZF_DEFAULT_OPTS='--style=minimal --info=inline --height=51% --reverse'
$env:_ZO_FZF_OPTS='--style=minimal --info=inline --height=51% --reverse'

Set-Alias whereis where.exe
Set-Alias which Get-Command

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

Set-Alias ff fastfetch

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
  Set-PSReadLineKeyHandler -Key Ctrl+r -ScriptBlock { Invoke-FuzzyHistory }

  # open a file
  Set-PSReadLineKeyHandler -Key Ctrl+o -ScriptBlock {
    $selectedFile = (fd --type f --hidden --exclude .git --exclude .venv) | Invoke-Fzf
    if ($selectedFile)
    {
      $currentDirectory = (Get-Location).Path
      $fullPathToOpen = Join-Path -Path $currentDirectory -ChildPath $selectedFile

      $nvimCommand = "nvim `"$fullPathToOpen`""
      Start-Process cmd.exe -ArgumentList "/c $nvimCommand" -NoNewWindow -Wait
    }
    [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
  }

  Set-PSReadLineKeyHandler -Key Ctrl+g -ScriptBlock {
    Get-ChildItem . -Recurse -Attributes Directory | Invoke-Fzf | Set-Location
    [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
  }
}

Invoke-Expression (& { (zoxide init powershell --cmd j | Out-String) }) # Initialize zoxide
# oh-my-posh prompt init pwsh --config C:\Users\nicol\.mytheme.omp.json | Invoke-Expression
