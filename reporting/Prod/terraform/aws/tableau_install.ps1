# wrote this cause i have bad memory

Invoke-WebRequest -Uri https://downloads.tableau.com/esdalt/2019.1.3/TableauServer-64bit-2019-1-3.exe -OutFile 'C:\packages\TableauServer-64bit-2019-1-3.exe'

# Open the right ports
New-NetFirewallRule -DisplayName 'Tableau Communication' -Direction Inbound -LocalPort 80,443,8850,8060,8061,8000-9000,27000-27009 -Protocol TCP -Action Allow -Profile Any

# command for mounting the ebs volume on the D drive.
Get-Disk | Where-Object PartitionStyle -Eq "RAW" | Initialize-Disk -PassThru | New-Partition -DriveLetter D -UseMaximumSize | Format-Volume