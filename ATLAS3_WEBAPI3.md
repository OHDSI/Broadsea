# Atlas 3 and WebAPI 3.0 with Broadsea

Broadsea runs [Atlas 3](https://github.com/OHDSI/Atlas3) and WebAPI 3.0 (the [webapi-3.0 branch](https://github.com/OHDSI/WebAPI/tree/webapi-3.0)). This page covers what is needed to try them and what changed compared to WebAPI 2.x. For everything else, see the [README](README.md).

## Quick start

1. Clone Broadsea:

   ```
   git clone https://github.com/OHDSI/Broadsea.git
   cd Broadsea
   ```

2. Optional: set the key used to sign login tokens, so users stay logged in when WebAPI restarts:

   ```
   openssl rand -base64 48 > secrets/webapi/SECURITY_JWT_SECRET
   ```

3. Start Broadsea:

   ```
   docker compose --profile default up -d
   ```

4. Open http://127.0.0.1/atlas and log in:

   | Role       | Username | Password |
   |------------|----------|----------|
   | Admin      | admin    | admin    |
   | Atlas user | ohdsi    | ohdsi    |

   The Eunomia demo data source is preconfigured.

## What changed from WebAPI 2.x

- **Configuration:** WebAPI is configured through Broadsea's `.env` file, with the same variable names as before. Broadsea maps them onto WebAPI 3.0's Spring Boot 3 properties. Security providers are set up in Section 5.
- **Login is required:** WebAPI 3.0 has no "security disabled" mode. Users who are not logged in cannot see any data source, so database login is enabled by default. The `broadsea-atlasdb-init` container seeds the users above; change their passwords or switch to another security provider for anything beyond a demo.
- **Upgrading an existing Broadsea database:** the database is migrated in place and keeps its content. Database logins now come from `webapi.auth_user`, so users from the old `webapi_security.security` table need to be added again.
- **Images:** the default profile uses the published Atlas 3 image (`ghcr.io/ohdsi/atlas3:dev`) and a WebAPI 3.0 image (`ghcr.io/ohdsi/webapi:3.0-dev`) pinned by `WEBAPI_IMAGE_DIGEST` in `.env`, with the trexsql plugin release from `WEBAPI_TREXSQL_VERSION` added.

## Building from source

To build Atlas 3 and WebAPI from their git repositories instead of using the published images:

```
docker compose --profile atlasdb --profile content --profile webapi-from-git --profile atlas-from-git up -d --build
```

The repository branch or commit to build is set in Section 6 of `.env` (defaults: Atlas3 `develop` and WebAPI `webapi-3.0`).
