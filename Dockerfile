#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/sdk:8.0

RUN useradd --uid 1001 jenkins && mkdir /home/jenkins && chown jenkins:jenkins /home/jenkins

# Install Java, curl, and unzip
RUN apt-get update
RUN apt-get install -y openjdk-17-jre-headless curl unzip

# Create symlink to allow the Java environment varible to point to the locally installed path
RUN ln -s /usr/lib/jvm/java-17-openjdk-amd64 /usr/lib/jvm/openjdk-11.0.16_8

# Install AWS SAM CLI
RUN curl -k -L "https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip" -o "aws-sam-cli.zip" \
    && unzip aws-sam-cli.zip -d sam-install \
    && ./sam-install/install

USER jenkins

WORKDIR /src

COPY --chown=jenkins:jenkins ./scripts /scripts

# Install dotnet tools
RUN dotnet tool install --global dotnet-sonarscanner
RUN dotnet tool install -g Amazon.Lambda.Tools

RUN echo "export PATH=$PATH:/home/jenkins/.dotnet/tools:/scripts:usr/local/aws-sam-cli" >> ~/.bashrc
