# AI Agent Governance Platform

A control plane that sits between AI agents and the tools they call — enforcing
permissions, evaluating policy, routing high-risk actions to human approval,
and recording an immutable audit trail of everything an agent does.

## Repo layout

```
.
├── frontend/            Next.js admin dashboard (agents, approvals, audit)
├── services/
│   ├── gateway/          Go — the latency-critical Agent Gateway (permission + policy enforcement)
│   ├── control-plane/    Spring Boot — identity, permissions admin, policy management, approvals API
│   └── agent-runner/     Python/FastAPI — mock agents (Sales Agent, Refund Agent) for local demo
├── policies/             OPA / Rego policy definitions
├── db/migrations/        SQL migrations (Postgres)
├── infra/                docker-compose + (future) k8s manifests
└── docs/                 Architecture doc, project guide, diagrams
```

## Why two backend services?

The **Gateway** (Go) sits in the hot path of every single agent action — it needs
to be fast and stay simple. The **Control Plane** (Spring Boot) owns everything
that isn't latency-critical: agent registry, permission/policy administration,
the approval queue, and (later) SSO/SAML. See `docs/ARCHITECTURE.md` for the
full reasoning and request flow.

## Quick start (local dev)

```bash
cp .env.example .env
docker compose up --build
```

This brings up Postgres, Redis, OPA, the Gateway, the Control Plane, the
Agent Runner, and the frontend. See `docs/PROJECT_GUIDE.md` for a full
walkthrough, port list, and how to run each service independently.

## Docs

- `docs/ARCHITECTURE.md` — full system architecture, data flow, data model
- `docs/PROJECT_GUIDE.md` — local setup, folder-by-folder guide, conventions
- Word/PDF versions of both are also provided for sharing outside the repo.
