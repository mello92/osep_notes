# Script to enable RDP and configure firewall rules
# Run this script with administrative privileges

# Enable RDP
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0

# Set RDP authentication to Secure Layer (NLA)
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "UserAuthentication" -Value 1

# Add Remote Desktop Users group to the Allow log on through Remote Desktop Services user right
$UserRight = "SeRemoteInteractiveLogonRight"
$RemoteDesktopUsers = "Remote Desktop Users"
$LocalSecurityAuthority = New-Object -TypeName 'System.DirectoryServices.DirectoryEntry' -ArgumentList 'WinNT://./LSA'
$SecuritySetting = $LocalSecurityAuthority.Children.Find($UserRight, 'System.Security.Principal.SecurityIdentifier').Value
$SecuritySetting = $SecuritySetting + ", " + $RemoteDesktopUsers
$LocalSecurityAuthority.Children.Find($UserRight, 'System.Security.Principal.SecurityIdentifier').Value = $SecuritySetting

# Enable Remote Desktop firewall rules
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Restart the Remote Desktop Services service
Restart-Service -Name TermService -Force
