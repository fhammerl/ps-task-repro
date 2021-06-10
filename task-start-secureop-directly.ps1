$username = "pfxuser"
$password = "pwd1234!"
$workingDir = "C:\pstests" # Where the scripts and the binaries are


# Create user
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
New-LocalUser -Name $username -Password $securePassword -ErrorAction SilentlyContinue
Add-LocalGroupMember -Group "Administrators" -Member $username -ErrorAction SilentlyContinue

# Schedule to run
$action = New-ScheduledTaskAction -WorkingDirectory "$workingDir" -Execute "powershell" -Argument ".\secure-operation.ps1" 
$trigger = Get-CimClass "MSFT_TaskRegistrationTrigger" -Namespace "Root/Microsoft/Windows/TaskScheduler"
Register-ScheduledTask -TaskName "highsecuritytask" -Action $action -Trigger $trigger -User $username -Password $password -RunLevel Highest -Force
