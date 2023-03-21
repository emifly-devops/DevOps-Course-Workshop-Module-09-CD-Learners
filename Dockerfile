FROM mcr.microsoft.com/dotnet/sdk:6.0

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

WORKDIR /opt/module-9

COPY ./ ./

RUN dotnet build

WORKDIR /opt/module-9/DotnetTemplate.Web

RUN npm ci && \
    find ./node_modules ! -user root | xargs chown root:root
RUN npm run build

ENTRYPOINT ["dotnet", "run"]
