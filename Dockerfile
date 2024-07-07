# Use the official Windows Server Core 2019 image
FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Install Chocolatey package manager
RUN powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command \
    Set-ExecutionPolicy Bypass -Scope Process -Force; \
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install ngrok
RUN choco install ngrok -y

# Install and enable RDP
RUN powershell -Command \
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name 'fDenyTSConnections' -Value 0; \
    Enable-NetFirewallRule -DisplayGroup 'Remote Desktop'; \
    Add-WindowsFeature -Name RDS-RD-Server

# Download and extract ngrok
RUN powershell -Command \
    Invoke-WebRequest -Uri https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz -OutFile ngrok.tgz; \
    tar -xvf ngrok.tgz -C C:\ngrok

# Add a script to start ngrok and keep the container running
COPY start.ps1 C:\start.ps1

# Expose the RDP port
EXPOSE 3389

# Set the entrypoint to the start script
ENTRYPOINT ["powershell", "C:\\start.ps1"]
