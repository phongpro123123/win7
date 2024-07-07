# Start ngrok to forward RDP port
Start-Process -NoNewWindow -FilePath "C:\ngrok\ngrok.exe" -ArgumentList "tcp 3389"

# Keep the container running
while ($true) { Start-Sleep -Seconds 36000 }
