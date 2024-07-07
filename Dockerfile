# Use the official Windows Server Core image
FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Set environment variables
ENV NGROK_URL=https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz

# Install necessary tools
RUN powershell -Command \
    Invoke-WebRequest -Uri $env:NGROK_URL -OutFile ngrok.tgz; \
    tar -xzf ngrok.tgz -C C:\; \
    Remove-Item -Force ngrok.tgz

# Copy ngrok authtoken script
COPY ngrok_authtoken.ps1 C:\ngrok_authtoken.ps1

# Expose RDP port
EXPOSE 3389

# Start ngrok and RDP
CMD powershell -Command \
    Start-Process -NoNewWindow -FilePath C:\ngrok.exe -ArgumentList 'tcp 3389'; \
    Start-Process -NoNewWindow -FilePath C:\ngrok_authtoken.ps1; \
    while ($true) { Start-Sleep -Seconds 36000 }
