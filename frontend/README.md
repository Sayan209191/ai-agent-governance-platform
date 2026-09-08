# Frontend (Next.js)

Admin dashboard: agent registry, approval queue, audit explorer.

## Run locally

```bash
npm install
cp .env.local.example .env.local
npm run dev
```

## Structure

- `app/agents` — agent registry view
- `app/approvals` — pending approval queue
- `app/audit` — audit trail explorer
- `lib/api.ts` — fetch wrappers around the Control Plane API
