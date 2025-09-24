# Define the output file path
$outputFile = "Your file Path C:\.."
	
# Start writing to the output file and display in the shell
"System Automation script:" | Tee-Object -FilePath $outputFile 
"----------------------" | Tee-Object -FilePath $outputFile -Append 
# Get the OS name and store it in a variable
$osVersion = (Get-ComputerInfo).OsName
$osCPU = (Get-ComputerInfo).CsProcessors.Name
$osTMemory = ([math]::floor([int]((Get-ComputerInfo).OsTotalVisibleMemorySize) / 1024)).ToString() + " GB"
$osFMemory = ([math]::floor([int]((Get-ComputerInfo).OSFreePhysicalMemory) / 1024)).ToString() + " GB"
$diskSpace = Get-Volume | Where-Object { $_.DriveLetter -eq 'C' } | Select-Object DriveLetter,@{Name='Used(GB)';Expression={[math]::round($_.SizeRemaining / 1GB, 2)}}, @{Name='Total(GB)';Expression={[math]::round($_.Size / 1GB, 2)}},@{Name='Free(GB)';Expression={[math]::round(($_.Size-$_.SizeRemaining)/ 1GB, 2)}}

$networkAdapters = Get-NetAdapter | Select-Object Name, InterfaceDescription, ifIndex, Status, MacAddress, LinkSpeed 
$networkIPaddress = Get-NetIPAddress | Select-Object IPAddress, InterfaceAlias

# Write the OS system settings to the output file and display in the shell
"Operating System: $osVersion" | Tee-Object -FilePath $outputFile -Append 
"Operating System CPU: $osCPU" | Tee-Object -FilePath $outputFile -Append 
"Operating System Total RAM: $osTMemory`nOperating System Free RAM: $osFMemory" | Tee-Object -FilePath $outputFile -Append 
"Operating System Hard disk space: $diskSpace" | Tee-Object -FilePath $outputFile -Append 

# Write network configurations to the output file and display in the shell
"Network Configurations:" | Tee-Object -FilePath $outputFile -Append 
"----------------------" | Tee-Object -FilePath $outputFile -Append 
"Operating System Network Adapters:" | Tee-Object -FilePath $outputFile -Append
$networkAdapters | Tee-Object -FilePath $outputFile -Append 
"Operating System Network IP Addresses:" | Tee-Object -FilePath $outputFile -Append 
$networkIPaddress | Tee-Object -FilePath $outputFile -Append 
"Internet Protocol Configurations:" | Tee-Object -FilePath $outputFile -Append 

# Append the output of ipconfig /all to the file and display in the shell
ipconfig /all | Tee-Object -FilePath $outputFile -Append 
