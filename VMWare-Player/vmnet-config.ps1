$ServiceName = 'VMnetDHCP'
$VmnetdhcpConf="C:\ProgramData\VMware\vmnetdhcp.conf"

$arrService = Get-Service -Name $ServiceName

While ($arrService.Status -ne 'Stopped')
	{
		write-host "service $ServiceName is  running, stop it"
		Stop-Service $ServiceName
		write-host "service $ServiceName is" $arrService.status
		write-host "stopping Service $ServiceName"
		Start-Sleep -seconds 10
		$arrService.Refresh()
		if ($arrService.Status -eq 'Stopped')
		{
			Write-Host "Service $ServiceName is  stopped now"
		}
	
	}


write-host "stop vmware dhcp and nat "

& 'C:\Program Files (x86)\VMware\VMware Player\vnetlib.exe' -- stop nat
& 'C:\Program Files (x86)\VMware\VMware Player\vnetlib.exe' -- stop dhcp

write-host "Clear all conf in $VmnetdhcpConf"

if (Test-Path $VmnetdhcpConf) 
	{ Clear-content $VmnetdhcpConf
	  Start-Sleep -seconds 10
	}

write-host "Configure vmnet1 and vmnet8"

& 'C:\Program Files (x86)\VMware\VMware Player\vnetlib.exe' -- set vnet vmnet1 mask 255.255.255.0
& 'C:\Program Files (x86)\VMware\VMware Player\vnetlib.exe' -- set vnet vmnet1 addr 192.168.144.0
& 'C:\Program Files (x86)\VMware\VMware Player\vnetlib.exe' -- update dhcp vmnet1
& 'C:\Program Files (x86)\VMware\VMware Player\vnetlib.exe' -- update adapter vmnet1
                                                          
& 'C:\Program Files (x86)\VMware\VMware Player\vnetlib.exe' -- set vnet vmnet8 mask 255.255.255.0
& 'C:\Program Files (x86)\VMware\VMware Player\vnetlib.exe' -- set vnet vmnet8 addr 192.168.59.0
& 'C:\Program Files (x86)\VMware\VMware Player\vnetlib.exe' -- update dhcp vmnet8
& 'C:\Program Files (x86)\VMware\VMware Player\vnetlib.exe' -- update nat vmnet8
& 'C:\Program Files (x86)\VMware\VMware Player\vnetlib.exe' -- update adapter vmnet8




Start-Sleep -seconds 10
write-host "Add fixed IP addresses to $VmnetdhcpConf"

add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "host ubuntu-template {"
add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "    hardware ethernet 00:0C:29:93:F8:14;"
add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "    fixed-address 192.168.59.254;"
add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "}" 


add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "host k8s-master {"
add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "    hardware ethernet 00:0C:29:D8:71:A0;"
add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "    fixed-address 192.168.59.129;"
add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "}" 

add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "host k8s-node {"
add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "    hardware ethernet 00:0C:29:2F:DA:49;"
add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "    fixed-address 192.168.59.130;"
add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "}" 


add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "host mq-storage {"
add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "    hardware ethernet 00:0c:29:48:9b:11;"
add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "    fixed-address 192.168.59.140;"
add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "}" 

add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "host mq1 {"
add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "    hardware ethernet 00:0C:29:B7:1C:44;"
add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "    fixed-address 192.168.59.141;"
add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "}" 


add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "host mq2 {"
add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "    hardware ethernet 00:50:56:3F:BA:FC;"
add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "    fixed-address 192.168.59.142;"
add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "}" 

add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "host mq3 {"
add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "    hardware ethernet 00:0C:29:76:C0:83;"
add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "    fixed-address 192.168.59.143;"
add-content -Encoding ASCII -Path $VmnetdhcpConf -Value "}" 


write-host "Start vmware dhcp and nat "
& 'C:\Program Files (x86)\VMware\VMware Player\vnetlib.exe' -- start dhcp
& 'C:\Program Files (x86)\VMware\VMware Player\vnetlib.exe' -- start nat


If ($arrService.Status -ne 'Running')
	{
		write-host "service $ServiceName is not running, start it"
		Start-Service $ServiceName
		write-host "service $ServiceName is "$arrService.status
		write-host "Starting service $ServiceName"
		Start-Sleep -seconds 10
		$arrService.Refresh()
		if ($arrService.Status -eq 'Running')
		{
			Write-Host "Service $ServiceName is now Running"
		}
	
	}
Else
	{
		write-host "service $ServiceName is  running, restart it"
		Restart-Service $ServiceName
		write-host "service $ServiceName is "$arrService.status
		write-host "Restarting service $ServiceName"
		Start-Sleep -seconds 10
		$arrService.Refresh()
		if ($arrService.Status -eq 'Running')
		{
			Write-Host "Service $ServiceName is now Running"
		}
	
	}