# PowerShell script to disable the system-wide proxy

# Disable the proxy settings
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyEnable -Value 0

# Clear the proxy address and port
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyServer -Value ""

# Apply the changes
netsh winhttp reset proxy
