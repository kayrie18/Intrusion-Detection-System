# Run in Windows PowerShell AS ADMINISTRATOR.  Usage: .\start_ids.ps1 <your-wifi-IPv4>
# Copies the custom rules into Suricata, tests the config, then starts the IDS.
param([Parameter(Mandatory=$true)][string]$Ip)
$s = "C:\Program Files\Suricata"
Copy-Item "$PSScriptRoot\..\rules\local.rules" "$s\rules\local.rules" -Force
Set-Location $s
.\suricata.exe -T -c suricata.yaml -S rules\local.rules -v
Write-Host "Config OK. Starting Suricata on $Ip (Ctrl+C to stop)..."
.\suricata.exe -c suricata.yaml -S rules\local.rules -i $Ip
