# PostgreSQL VPS Operations

Use these commands and snippets when applying the `postgresql-vps-agent` skill.

## 1. Locate active config files

```bash
sudo -u postgres psql -c "SHOW config_file;"
sudo -u postgres psql -c "SHOW hba_file;"
```

## 2. Configure PostgreSQL to listen on the network

Edit `postgresql.conf`:

```conf
listen_addresses = '*'
port = 5490
ssl = on
```

If using your own certificate:

```conf
ssl_cert_file = 'server.crt'
ssl_key_file = 'server.key'
```

## 3. Configure remote access rules

Edit `pg_hba.conf` and allow only trusted IPs:

```conf
hostssl  mydb  myuser  YOUR_CLIENT_IP/32  scram-sha-256
```

Use `hostssl` instead of `host` so remote access requires TLS.

## 4. Create a PostgreSQL user

Inside `psql`:

```sql
CREATE USER myuser WITH PASSWORD 'StrongPasswordHere';
```

Or:

```sql
CREATE ROLE myuser WITH LOGIN PASSWORD 'StrongPasswordHere';
```

## 5. Create a database owned by that user

Recommended:

```sql
CREATE DATABASE mydb OWNER myuser;
```

## 6. Grant permissions if the database is owned by postgres

If the database already exists and is owned by `postgres`, grant access explicitly:

```sql
GRANT CONNECT ON DATABASE mydb TO myuser;
\c mydb
GRANT USAGE, CREATE ON SCHEMA public TO myuser;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO myuser;
GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA public TO myuser;
```

For future objects:

```sql
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO myuser;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT USAGE, SELECT, UPDATE ON SEQUENCES TO myuser;
```

## 7. Verify TLS and authentication

From a remote machine:

```bash
psql "host=YOUR_VPS_IP port=5490 dbname=mydb user=myuser sslmode=require"
```

Inside `psql`:

```sql
\conninfo
```

Confirm:

- The port is `5490`
- SSL is enabled
- The connection is using TLS

## 8. Restart PostgreSQL after changes

```bash
sudo systemctl restart postgresql
```

Use the distribution-specific service name if needed.

## 9. Open the firewall

Allow only trusted IPs to reach PostgreSQL:

```bash
sudo ufw allow from YOUR_CLIENT_IP to any port 5490 proto tcp
```

## 10. Backup and restore

For non-interactive `pg_dump` and `pg_restore`, use a `~/.pgpass` entry and lock down permissions:

```bash
chmod 600 ~/.pgpass
```

Example `~/.pgpass` line:

```text
localhost:5490:expense:expense:YOUR_PASSWORD
```

Backup script example using custom format:

```bash
#!/bin/bash

# Configuration
DB_NAME="krukrub_test"
DB_USER="admin"
DB_PORT="5490"
DB_HOST="localhost"
BACKUP_DIR="/home/wit/backup"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
FILENAME="${BACKUP_DIR}/backup_${DB_NAME}_${TIMESTAMP}.dump"

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

# Run pg_dump
# -Fc = custom postgres format (compressed)
# -w  = never prompt for password (uses .pgpass)
pg_dump -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -Fc -w "$DB_NAME" > "$FILENAME"

# Optional: Delete backups older than 7 days to save space
#find "$BACKUP_DIR" -type f -name "*.dump" -mtime +7 -delete

echo "Backup completed: $FILENAME"
```

Restore example:

```bash
pg_restore -d expense -U expense -h localhost -p 5490 --no-owner --role=expense backup_expense_20260509_040512.dump
```

Notes:

- `--no-owner` avoids restoring ownership metadata from the source cluster.
- `--role=expense` runs the restore as the target application role.
- Ensure the target database already exists before restore when using `-d`.

## 11. Delete a user and database

Terminate active sessions:

```sql
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'mydb'
  AND pid <> pg_backend_pid();
```

Drop the database:

```sql
DROP DATABASE mydb;
```

Drop the role:

```sql
DROP ROLE myuser;
```

If the role owns objects elsewhere:

```sql
REASSIGN OWNED BY myuser TO postgres;
DROP OWNED BY myuser;
DROP ROLE myuser;
```

## Safety notes

- Do not expose PostgreSQL to `0.0.0.0/0` unless unavoidable.
- Prefer `hostssl` rules and `scram-sha-256`.
- Use a dedicated app user instead of `postgres`.
- Make the app user the database owner when possible.
- Keep `~/.pgpass` at mode `600` so PostgreSQL accepts it and other users cannot read it.
- Use strong passwords and restrict firewall access to known IPs.

## Verification checklist

- `listen_addresses` set correctly
- Port changed to `5490`
- `ssl = on`
- `pg_hba.conf` uses `hostssl`
- Firewall allows only trusted IPs
- User can connect remotely
- `\conninfo` shows SSL/TLS
- Database and role cleanup works as expected
