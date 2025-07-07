# Learn about building .NET container images:
# https://github.com/dotnet/dotnet-docker/blob/main/samples/README.md
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY ["Test_website/Test_website.csproj", "Test_website/"]
RUN dotnet restore "Test_website/Test_website.csproj"

# copy everything else and build app
COPY . .
WORKDIR /source/Test_website
RUN dotnet publish -o /app


# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "Test_website.dll"]
