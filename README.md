# ShareMyWiFiPlease
Exactly what Windows fails to do reliably

A small PowerShell utility that automatically fixes Windows Internet Connection Sharing (ICS) so you can share your laptop’s Wi-Fi connection with your PS5 over Ethernet — without manually opening *ncpa.cpl* every time you reboot.

## Why this tool?
Windows ICS is notoriously unstable. After every restart, ICS often enters a broken state that requires:
1. Opening the Wi-Fi adapter properties  
2. Unticking "Allow other network users…"  
3. Clicking OK  
4. Enabling it again  

This script automates that entire workflow in one click.

## How it works
- Disables ICS on both Wi-Fi and Ethernet to reset Windows' internal state  
- Waits briefly  
- Re-enables ICS cleanly:  
  **Wi-Fi → Ethernet (PS5)**  
- Outputs status in the terminal  

## Usage
1. Save the script as `ToggleICS.ps1`  
2. Run VS Code or PowerShell **as Administrator**  
3. Execute:

```powershell
powershell.exe -ExecutionPolicy Bypass -File .\ToggleICS.ps1
```
