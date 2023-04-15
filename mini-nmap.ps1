# PowerShell script to scan open ports on a target IP address
# Replace 'target_ip' with the desired IP address or hostname
# Replace 'start_port' and 'end_port' with the desired port range

$target_ip = "192.168.1.100"
$start_port = 1
$end_port = 1024
$timeout = 2000

function Test-Port {
    param($IP, $Port, $Timeout)

    $tcpclient = New-Object Net.Sockets.TcpClient
    $iar = $tcpclient.BeginConnect($IP, $Port, $null, $null)
    $wait = $iar.AsyncWaitHandle.WaitOne($Timeout, $false)
    if ($wait) {
        try {
            $tcpclient.EndConnect($iar) | Out-Null
            $true
        } catch {
            $false
        }
    } else {
        $false
    }
}

$start_port..$end_port | ForEach-Object {
    if (Test-Port -IP $target_ip -Port $_ -Timeout $timeout) {
        "Port $_ is open"
    }
}
