---
name: postgresql-vps-agent
description: Use this skill when configuring PostgreSQL on a VPS for secure remote access, TLS, custom port changes, pg_hba rules, database and role management, backup and restore operations, connectivity verification, firewall restrictions, and safe cleanup of users or databases.
---

# PostgreSQL VPS Agent

Use this skill for self-managed PostgreSQL instances on VPS hosts where the task involves network exposure, TLS, authentication rules, role/database setup, verification, or teardown.

## Scope

- Secure remote PostgreSQL access
- Port changes to `5490`
- TLS enablement and certificate wiring
- Role and database creation
- Backup and restore operations
- Permission grants for existing databases
- Connection verification
- Firewall restriction to trusted client IPs
- Clean role and database removal

## Workflow

1. Confirm the host is a self-managed PostgreSQL VPS, not a managed service with provider-controlled networking or certificates.
2. Inspect the live PostgreSQL configuration before changing anything:
   - `SHOW config_file;`
   - `SHOW hba_file;`
   - `SHOW ssl;`
   - `SHOW port;`
   - `SHOW listen_addresses;`
3. Update PostgreSQL network settings to listen remotely on port `5490` and require TLS-backed access where possible.
4. Add narrow `pg_hba.conf` rules using `hostssl` and a trusted client CIDR, never broad internet exposure unless the user explicitly requires it.
5. Create the application role and database, preferring ownership by the application role.
6. If the database already exists and is owned by another role, grant the minimum access needed on the database, schema, tables, and sequences.
7. Restart or reload PostgreSQL as needed, then verify the service is actually listening on `5490`.
8. Restrict the firewall to the known client IP and verify remote connectivity with `sslmode=require`.
9. For backup and restore workflows, prefer custom-format dumps with `pg_dump -Fc` and `pg_restore`, and use `.pgpass` with mode `600` for non-interactive auth.
10. When removing access, terminate active sessions first, then drop the database and role safely.

## Rules

- Prefer `scram-sha-256` for password authentication.
- Prefer `hostssl` over `host` for remote rules.
- Do not recommend `0.0.0.0/0` or equivalent wide-open access unless the user explicitly accepts that risk.
- Use a dedicated application role instead of `postgres`.
- If a role owns objects elsewhere, reassign and drop owned objects before dropping the role.
- Call out any assumption that depends on distro packaging, service names, certificate paths, or firewall tooling.

## References

- Read [references/postgresql-vps-operations.md](references/postgresql-vps-operations.md) for exact commands, SQL snippets, and the verification checklist.
