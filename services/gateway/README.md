# Gateway (Go)

The latency-critical Agent Gateway. Every agent action flows through
`POST /gateway/execute`: permission check → policy evaluation (OPA) →
execute or queue for approval → audit log.

## Run locally

```bash
go run main.go
```

## Structure

- `internal/permission` — permission lookups (Postgres + Redis cache in production)
- `internal/policy` — OPA client / policy evaluation
- `internal/gateway` — the HTTP handler tying both together

See `docs/ARCHITECTURE.md` in the repo root for the full request flow.
