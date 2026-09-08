# AI Agent Governance Platform — Architecture

See the full illustrated version (with diagram, tables, and design rationale)
in `ARCHITECTURE.docx` / `ARCHITECTURE.pdf` shared alongside this repo.

## Summary

The platform is a governance control plane between AI agents and the tools
they call. Every agent action passes through the **Agent Gateway** (Go),
which checks permissions, evaluates policy via **OPA**, and either executes
the action or routes it to a human approver via the **Control Plane**
(Spring Boot). Every decision is written to an append-only `audit_logs` table.

## Services

- **frontend/** — Next.js dashboard (agents, approvals, audit)
- **services/gateway/** — Go — latency-critical permission + policy enforcement
- **services/control-plane/** — Spring Boot — identity, admin, approvals
- **services/agent-runner/** — Python/FastAPI — mock agents for demos
- **policies/** — OPA/Rego policy definitions

## Data model

Every table carries `org_id` from the first migration (`db/migrations/V1__init_schema.sql`)
so Row-Level Security can be enabled later without a schema rewrite. See the
full document for the complete table-by-table breakdown.
