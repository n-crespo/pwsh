# environment variables
$env:EDITOR = "nvim"
$env:NVIM_FULL_CONFIG = "true"
$env:TERM = 'xterm-255color'
$env:FZF_DEFAULT_OPTS="--style=minimal --info=inline --height=20% --reverse"
$env:FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude .git --exclude .venv"
$env:XDG_DATA_HOME = "$env:LOCALAPPDATA"

# functions
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
function n.
{ nvim .
}
function q
{ exit
}
function gp
{ git pull
}
function so
{ . $PROFILE
}
function gs
{ git status
}
function tt
{ ttyper
}
function eza_short
{ eza --icons=always --group-directories-first --color=always @args
}
function eza_alh
{ eza -Alh --group-directories-first --color=always @args
}
function eza_l
{ eza -l --icons=always --group-directories-first --color=always --git -a @args
}
function ltt
{ eza --tree @args
}
function cenv
{ python -m venv .venv
}
function senv
{ .venv\Scripts\activate
}

function o
{
  $selection = fd --type f --exclude .git --hidden | Invoke-Fzf
  if ($selection)
  { nvim $selection
  }
}

function e
{
  $tmp = New-TemporaryFile
  yazi --cwd-file $tmp.FullName
  $cwd = Get-Content $tmp.FullName
  if ($cwd -ne $PWD.Path)
  { Set-Location $cwd
  }
  Remove-Item $tmp.FullName
}

# prompt (already optimized via .NET calls)
function global:prompt
{
  $displayPath = $pwd.Path -replace [regex]::Escape($HOME), "~"
  if ($pwd.Provider.Name -eq "FileSystem")
  {
    [Console]::Write("$([char]27)]9;9;`"$($pwd.Path)`"$([char]27)\")
  }
  $Host.UI.RawUI.WindowTitle = $displayPath
  [Console]::Write("[win] $displayPath ❯")
  return " "
}

# aliases
Set-Alias whereis where.exe
Set-Alias which Get-Command
Set-Alias ls eza_short
Set-Alias la eza_alh
Set-Alias l eza_l
Set-Alias lt ltt
Set-Alias ff fastfetch
Set-Alias open start
Set-Alias s sfsu
Set-Alias p pipes-rs

Set-PSReadlineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
# Set-PSReadLineKeyHandler -Key Ctrl+r -ScriptBlock { Invoke-FuzzyHistory }
# Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+r' -PSReadlineChordReverseHistory 'Ctrl+r'
# open file with <C-o>
Set-PSReadLineKeyHandler -Key "Ctrl+o" -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert("o")
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}
Set-PSReadLineKeyHandler -Key "Alt+p" -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert("o")
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Invoke-Expression (& { (zoxide init powershell --cmd j | Out-String) }) # Initialize zoxide
Invoke-Expression (&sfsu hook)
