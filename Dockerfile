FROM ubuntu:latest
LABEL maintainer="Sean King <r.sean.king@gmail.com>"

# Install Dependencies
RUN apt-get update -y
RUN apt-get install -y wget gnupg2 wget ca-certificates apt-transport-https

# Add Ubiquiti to Source List
RUN echo 'deb https://www.ui.com/downloads/unifi/debian stable ubiquiti' | tee /etc/apt/sources.list.d/100-ubnt-unifi.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 06E85760C0A52C50 

# Prevent possibility of an incompatible Java release 
RUN apt-mark hold openjdk-11-*

# Install Unifi Controller
RUN apt-get update 
RUN apt-get install -y unifi

VOLUME [ "/usr/lib/unifi/data", "/usr/lib/unifi/logs" ]

EXPOSE 6789/tcp 8080/tcp 8443/tcp 8880/tcp 8843/tcp 3478/udp 10001/udp 1900/udp

ENTRYPOINT ["/usr/bin/java", "-Xmx2048m", "-jar", "/usr/lib/unifi/lib/ace.jar"]
CMD ["start"]