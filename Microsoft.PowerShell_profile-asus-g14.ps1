
Clear-Host
function Exit-Shell { exit }

Set-Alias -Name q -Value Exit-Shell
Set-Alias -Name lg -Value lazygit
Set-Alias -Name gg -Value lazygit
Set-Alias -Name n -Value nvim
# Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
Set-Alias -Name so -Value refreshenv
# Import-Module -Name Terminal-Icons
Import-Module PSReadLine
$ENV:EDITOR = "C:\Program Files\Neovim\bin\nvim.exe"
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode vi
Remove-Alias r
Set-PSReadLineKeyHandler -Chord 'Ctrl+w' -Function BackwardKillWord
$env:TERM='xterm-256color'
$env:PATH += ";C:\Users\nicol\sqlite\"
$env:PATH += ";C:\Users\nicol\scoop\shims"
