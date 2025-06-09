function lg { lazygit @args }
function n { nvim @args }
function g { git @args }
Function n. { nvim . }
Function nl {nvim -c':e#<1'}
Function e { yazi }
Function q { exit }

Function attackstart {
    try {
        vmrun -T ws start "C:\Users\nicol\OneDrive\Documents\Virtual Machines\Test VM\Test VM.vmx" nogui
    } catch {
        Write-Error "Failed to start the attack VM: $_"
    }
}
Function attackstop {
    try {
        vmrun -T ws stop "C:\Users\nicol\OneDrive\Documents\Virtual Machines\Test VM\Test VM.vmx" hard
    } catch {
        Write-Error "Failed to stop the attack VM: $_"
    }
}

Function targetstart {
    try {
        vmrun -T ws start "C:\Users\nicol\OneDrive\Documents\Virtual Machines\Target\Target.vmx" nogui
    } catch {
        Write-Error "Failed to start the target VM: $_"
    }
}
Function targetstop {
    try {
        vmrun -T ws stop "C:\Users\nicol\OneDrive\Documents\Virtual Machines\Target\Target.vmx" hard
    } catch {
        Write-Error "Failed to stop the target VM: $_"
    }
}

# Environment variables
$ENV:EDITOR = "\\wsl$\Ubuntu\usr\bin\nvim"
$env:TERM = 'xterm-256color'
$env:PATH += ";C:\Users\nicol\sqlite\"
$env:PATH += ";C:\Users\nicol\AppData\Local\Programs\arduino-ide\resources\app\lib\backend\resources\"
$env:ARDUINO_CONFIG_FILE = "C:\Users\nicol\.arduinoIDE\arduino-cli.yaml"

function lis { eza --icons=always --group-directories-first @args }
Set-Alias ls lis

function laa { ls -Alh --group-directories-first @args }
Set-Alias la laa

function ll { ls -l --group-directories-first --git -a @args }
Set-Alias l ll

function ltt { ls --tree @args }
Set-Alias lt ltt

Set-Alias ff fastfetch

# PSReadLine configuration (interactive shell only)
if ($Host.UI.SupportsVirtualTerminal) {
    Import-Module PSReadLine
    Set-PSReadLineOption -PredictionSource HistoryAndPlugin
    Set-PSReadLineOption -PredictionViewStyle List
    Set-PSReadLineOption -BellStyle None

    Set-PSReadLineKeyHandler -Chord 'Ctrl+w' -Function BackwardKillWord
    Set-PSReadLineKeyHandler -Key ctrl+d -Function ViExit
    # Set-PSReadLineKeyHandler -Key ctrl+enter -Function AcceptLine
    Set-PSReadLineKeyHandler -Key ctrl+n -Function NextHistory
    Set-PSReadLineKeyHandler -Key ctrl+p -Function PreviousHistory
    Set-PSReadLineKeyHandler -Key ctrl+l -Function ClearScreen

    # Define a custom function to insert "ji"
    function Insert-Ji {
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert("ji")
        [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
    }

    # Bind Ctrl+j to the custom Insert-Ji function
    Set-PSReadLineKeyHandler -Key Ctrl+j -ScriptBlock { Insert-Ji }
}

# Initialize zoxide
Invoke-Expression (& { (zoxide init powershell --cmd j | Out-String) })
