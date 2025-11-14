# syntax=docker/dockerfile:1

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Restore dependencies first to leverage layer caching
COPY LibraryManagement.csproj ./
RUN dotnet restore "LibraryManagement.csproj"

# Copy the rest of the source and publish a trimmed release build
COPY . .
RUN dotnet publish "LibraryManagement.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "LibraryManagement.dll"]
