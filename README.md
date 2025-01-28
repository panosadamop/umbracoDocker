## Setting up Umbraco with Docker Compose

### Build and Start the Containers
Run the following command to build and start the containers:

```bash
docker-compose up --build
```

---

### Access Umbraco
Open your browser and navigate to:

```text
http://localhost:8080
```

Follow the Umbraco setup wizard to complete the installation.

---

### Database Configuration
During the setup wizard, provide the following connection string:

```text
Server=db;Database=UmbracoDb;User Id=sa;Password=YourStrongPassword;
```

---

### Persist Data
This setup uses Docker volumes to persist data:

- **`umbraco-data`**: Stores Umbraco site data.
- **`mssql-data`**: Stores MSSQL database files.

These volumes ensure that your data is preserved even if the containers are stopped or restarted.

---

### Key Dockerfile Steps

#### Copy the Project Files
- The line `COPY *.sln ./` ensures the solution file is copied into the Docker build context.
- The line `COPY UmbracoProject/*.csproj ./UmbracoProject/` ensures that the `.csproj` file for your Umbraco project is available.

#### Restore Dependencies
- The `RUN dotnet restore` command restores all required dependencies because the `.sln` and `.csproj` files are present in the correct location.

#### Copy All Files
- The `COPY . .` command includes all remaining project files, ensuring the build completes successfully.

#### Publish
- The `dotnet publish` command outputs the built application to the `/app` directory.

---

This setup ensures that your Umbraco CMS and MSSQL database run in isolated containers while maintaining data persistence and reliability.

