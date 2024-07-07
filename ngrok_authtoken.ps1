param (
    [string]$authtoken
)

if (-not $authtoken) {
    $authtoken = Read-Host -Prompt "2Nvl9INkYFRfl3uLSf3sU7PaAAL_4yoNusPRs3YbTpqcyuEdr"
}

& C:\ngrok.exe authtoken $authtoken
