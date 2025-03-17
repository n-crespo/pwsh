function Exit-Shell { exit }

Set-Alias -Name q -Value Exit-Shell
Set-Alias -Name lg -Value lazygit
Set-Alias -Name n -Value nvim
Function n. { nvim . }
Function nl {nvim -c':e#<1'}
Function e { yazi }


# virtual machines
Function attackstart {
  vmrun -T ws start "C:\Users\nicol\OneDrive\Documents\Virtual Machines\Test VM\Test VM.vmx" nogui
}
Function attackstop { vmrun -T ws stop "C:\Users\nicol\OneDrive\Documents\Virtual Machines\Test VM\Test VM.vmx" hard }


Function targetstart {
  vmrun -T ws start "C:\Users\nicol\OneDrive\Documents\Virtual Machines\Target\Target.vmx" nogui
}
Function targetstop {
  vmrun -T ws stop "C:\Users\nicol\OneDrive\Documents\Virtual Machines\Target\Target.vmx" hard }

# other
# Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
Set-Alias -Name so -Value refreshenv

Import-Module PSReadLine
# $ENV:EDITOR = "C:\Program Files\Neovim\bin\nvim.exe"
$ENV:EDITOR = "\\wsl$\Ubuntu\usr\bin\nvim"
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle List

Set-PSReadLineKeyHandler -Chord 'Ctrl+w' -Function BackwardKillWord
Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit
Set-PSReadlineKeyHandler -Key ctrl+enter -Function AcceptLine
Set-PSReadlineKeyHandler -Key ctrl+n -Function NextHistory
Set-PSReadlineKeyHandler -Key ctrl+p -Function PreviousHistory
Set-PSReadlineOption -BellStyle None
Set-PSReadlineKeyHandler -Key ctrl+l -Function ClearScreen

$env:TERM='xterm-256color'
$env:PATH += ";C:\Users\nicol\sqlite\"

function lis { eza --icons=always --group-directories-first @args }
Set-Alias ls lis

function laa { ls -Alh --group-directories-first @args }
Set-Alias la laa

function ll { ls -l --group-directories-first --git -a @args }
Set-Alias l ll

function ltt { ls --tree @args }
Set-Alias lt ltt

Set-Alias ff fastfetch
# Clear-Host
