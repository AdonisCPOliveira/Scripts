#Open PDC
get-addomain | select PDCEmulator

#Search in Security Events with code ID 4740
Get-WinEvent -FilterHashtable @{logname=’security’; id=4740} | fl
