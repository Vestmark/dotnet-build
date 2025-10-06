#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/sdk:8.0

RUN useradd --uid 1001 jenkins && mkdir /home/jenkins && chown jenkins:jenkins /home/jenkins

# Install Java
RUN apt-get update
RUN apt-get install -y openjdk-17-jre-headless

# Create symlinks to allow the Java environment varible to point to the locally installed path
RUN ln -s /usr/lib/jvm/java-17-openjdk-amd64 /usr/lib/jvm/openjdk-11.0.16_8
RUN ln -s /usr/lib/jvm/java-17-openjdk-amd64 /usr/lib/jvm/openjdk-17

USER jenkins

WORKDIR /src

COPY --chown=jenkins:jenkins ./scripts /scripts

# Create symlinks to retired test script
RUN ln -s /scripts/test.sh /scripts/test-cc.sh
RUN ln -s /scripts/sonar.sh /scripts/sonar-cc.sh

# Install dotnet tools
RUN dotnet tool install --global dotnet-sonarscanner

RUN echo "export PATH=$PATH:/home/jenkins/.dotnet/tools:/scripts" >> ~/.bashrc
