# Control Plane (Spring Boot)

Owns identity, permissions administration, policy management, and the
approval queue. Everything here is admin/CRUD traffic, not the
latency-critical enforcement path — that's the separate Go Gateway
(`services/gateway`).

## Run locally

```bash
mvn spring-boot:run
```

## Modules

- `agent` — agent registry (register, list, enable/disable)
- `permission` — per-agent permission grants (admin CRUD)
- `policy` — policy definitions (admin CRUD; evaluated at runtime by OPA via the Gateway)
- `approval` — the human approval queue
- `audit` — read-only audit log API for the dashboard's Audit Explorer
- `config` — security configuration

## Note on free-tier hosting

The Dockerfile caps heap at `-Xmx350m` to fit Render's free 512MB instance.
See `docs/PROJECT_GUIDE.md` for the full free-tier hosting notes.
