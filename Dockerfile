FROM ubuntu:18.04
LABEL maintainer="Sean King <r.sean.king@gmail.com>"

# Install Dependencies
RUN apt-get update 
RUN apt-get -y install wget gnupg2 openjdk-8-jre-headless

# Add Mongo to Source List
RUN wget -qO - https://www.mongodb.org/static/pgp/server-3.4.asc | apt-key add -
RUN echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list

# Add Ubiquiti to Source List
RUN echo 'deb https://www.ui.com/downloads/unifi/debian stable ubiquiti' | tee /etc/apt/sources.list.d/100-ubnt-unifi.list
RUN wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg 

# Install Unifi Controller
RUN apt-get update
RUN apt-get -y install unifi

VOLUME [ "/usr/lib/unifi/data", "/usr/lib/unifi/logs" ]

EXPOSE 6789/tcp 8080/tcp 8443/tcp 8880/tcp 8843/tcp 3478/udp

ENTRYPOINT ["/usr/bin/java", "-Xmx2048m", "-jar", "/usr/lib/unifi/lib/ace.jar"]
CMD ["start"]