# PowerShell script to configure a system-wide proxy
# Replace 'proxy_address' and 'proxy_port' with your proxy server's address and port

$proxy_address = "127.0.0.1"
$proxy_port = "1080"

# Enable the proxy settings
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyEnable -Value 1

# Set the proxy address and port
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyServer -Value "$proxy_address:$proxy_port"

# Apply the changes
netsh winhttp import proxy source=ie
