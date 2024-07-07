# Use the official Ubuntu base image
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-goodies \
    xrdp \
    sudo \
    wget \
    curl \
    && apt-get clean

# Add a user for RDP
RUN useradd -m -s /bin/bash ubuntu && echo "ubuntu:ubuntu" | chpasswd && adduser ubuntu sudo

# Configure XRDP
RUN echo "xfce4-session" > /home/ubuntu/.xsession
RUN sed -i 's/3389/3389/g' /etc/xrdp/xrdp.ini

# Expose the RDP port
EXPOSE 3389

# Start XRDP
CMD ["/usr/sbin/xrdp", "-nodaemon"]
