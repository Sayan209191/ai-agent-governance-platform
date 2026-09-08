# Project Guide

See the full version (with tables and a free-tier hosting reference) in
`PROJECT_GUIDE.docx` / `PROJECT_GUIDE.pdf` shared alongside this repo.

## Quick start

```bash
cp .env.example .env
docker compose up --build
```

## Ports

| Service | Port |
|---|---|
| Frontend | 3000 |
| Control Plane | 8081 |
| Gateway | 8080 |
| Agent Runner | 8000 |
| Postgres | 5432 |
| Redis | 6379 |
| OPA | 8181 |

## Conventions

- Every new table includes `org_id` from the start.
- The Gateway and Control Plane never touch each other's database directly — HTTP only.
- Every governed action produces an `audit_logs` entry, including denials.
- Unfinished integration points are marked `TODO(dev)` — grep for these to find what's stubbed.
