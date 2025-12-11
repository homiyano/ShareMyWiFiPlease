# Full ICS reset + enable sharing Wi-Fi -> Ethernet
# Run as Administrator

$publicName  = "Wi-Fi"
$privateName = "Ethernet"

$netShare = New-Object -ComObject HNetCfg.HNetShare

function Get-ConnectionByName($name) {
    $enum = $netShare.EnumEveryConnection()
    foreach ($conn in $enum) {
        $props = $netShare.NetConnectionProps($conn)
        if ($props.Name -eq $name) {
            return $conn
        }
    }
    throw "Adapter '$name' not found."
}

try {
    $publicConn  = Get-ConnectionByName $publicName
    $privateConn = Get-ConnectionByName $privateName

    $publicCfg  = $netShare.INetSharingConfigurationForINetConnection($publicConn)
    $privateCfg = $netShare.INetSharingConfigurationForINetConnection($privateConn)

    Write-Output "Resetting ICS state..."

    # Disable sharing on BOTH adapters to avoid ICS COM errors
    foreach ($conn in @($publicCfg, $privateCfg)) {
        if ($conn.SharingEnabled) {
            try {
                $conn.DisableSharing()
            } catch {}
        }
    }

    Start-Sleep -Seconds 2

    Write-Output "Enabling ICS: '$publicName' -> '$privateName'..."

    # Enable sharing fresh
    $publicCfg.EnableSharing(0)  # Public/internet
    $privateCfg.EnableSharing(1) # Home network

    Write-Output "ICS enabled successfully."
}
catch {
    Write-Error $_
}
