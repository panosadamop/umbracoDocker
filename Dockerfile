# Use the official .NET runtime image as a base
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80

# Use the official .NET SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Copy project files
COPY *.sln ./
COPY UmbracoProject/*.csproj ./UmbracoProject/

# Restore dependencies
RUN dotnet restore

# Copy the rest of the project files and build
COPY . .
WORKDIR /src/UmbracoProject
RUN dotnet publish -c Release -o /app

# Final stage: runtime
FROM base AS final
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "Umbraco.Web.UI.dll"]
