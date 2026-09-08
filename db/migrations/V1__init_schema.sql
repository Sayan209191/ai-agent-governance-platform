-- AI Agent Governance Platform — initial schema
-- Every table carries org_id from day one so Row-Level Security can be turned
-- on later (see docs/ARCHITECTURE.md, section on multi-tenancy) without a
-- migration that touches every row.

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE organizations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    org_id UUID NOT NULL REFERENCES organizations(id),
    email TEXT NOT NULL UNIQUE,
    role TEXT NOT NULL DEFAULT 'member', -- admin | approver | member
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE agents (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    org_id UUID NOT NULL REFERENCES organizations(id),
    name TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'active', -- active | disabled
    owner_id UUID REFERENCES users(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE agent_identities (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    org_id UUID NOT NULL REFERENCES organizations(id),
    agent_id UUID NOT NULL REFERENCES agents(id),
    api_key_hash TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE permissions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    org_id UUID NOT NULL REFERENCES organizations(id),
    agent_id UUID NOT NULL REFERENCES agents(id),
    tool TEXT NOT NULL,        -- e.g. "crm", "payments"
    action TEXT NOT NULL,      -- e.g. "read", "write", "delete"
    allowed BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE policies (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    org_id UUID NOT NULL REFERENCES organizations(id),
    name TEXT NOT NULL,
    rule_json JSONB NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE approvals (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    org_id UUID NOT NULL REFERENCES organizations(id),
    agent_id UUID NOT NULL REFERENCES agents(id),
    action TEXT NOT NULL,
    payload JSONB,
    status TEXT NOT NULL DEFAULT 'pending', -- pending | approved | rejected
    approver_id UUID REFERENCES users(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    resolved_at TIMESTAMPTZ
);

CREATE TABLE executions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    org_id UUID NOT NULL REFERENCES organizations(id),
    agent_id UUID NOT NULL REFERENCES agents(id),
    status TEXT NOT NULL DEFAULT 'running', -- running | completed | failed
    started_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    completed_at TIMESTAMPTZ
);

CREATE TABLE tool_calls (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    org_id UUID NOT NULL REFERENCES organizations(id),
    execution_id UUID NOT NULL REFERENCES executions(id),
    tool TEXT NOT NULL,
    action TEXT NOT NULL,
    payload JSONB,
    result JSONB,
    latency_ms INTEGER,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE audit_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    org_id UUID NOT NULL REFERENCES organizations(id),
    execution_id UUID REFERENCES executions(id),
    event_type TEXT NOT NULL, -- permission_check | policy_decision | approval_created | approval_resolved | tool_call
    detail_json JSONB NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Indexes: every hot query is scoped by org_id first.
CREATE INDEX idx_agents_org ON agents (org_id);
CREATE INDEX idx_permissions_org_agent ON permissions (org_id, agent_id);
CREATE INDEX idx_approvals_org_status ON approvals (org_id, status);
CREATE INDEX idx_audit_logs_org_created ON audit_logs (org_id, created_at DESC);
CREATE INDEX idx_tool_calls_org_execution ON tool_calls (org_id, execution_id);

-- Row-Level Security is defined here but left DISABLED for the single-org
-- POC. Enable with `ALTER TABLE ... ENABLE ROW LEVEL SECURITY;` plus a
-- current-tenant session variable when the multi-tenant phase begins
-- (see docs/ARCHITECTURE.md).
