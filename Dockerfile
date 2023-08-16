# Use the official .NET Core SDK image as the build environment
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env
WORKDIR /app

# Copy all project files to the container
COPY . .

# Build your .NET application
RUN dotnet restore
RUN dotnet build -c Release
RUN dotnet publish -c Release -o out

# Use a runtime image for the final container
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build-env /app/out .

# Set the entry point for your application
ENTRYPOINT ["dotnet", "YourApp.dll"]
