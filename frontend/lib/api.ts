// Thin fetch wrappers around the Control Plane API.
// TODO(dev): add auth headers once OIDC login is wired up.

const CONTROL_PLANE_URL =
  process.env.NEXT_PUBLIC_CONTROL_PLANE_URL || "http://localhost:8081";

export async function getAgents(orgId: string) {
  const res = await fetch(`${CONTROL_PLANE_URL}/api/agents?orgId=${orgId}`);
  return res.json();
}

export async function getPendingApprovals(orgId: string) {
  const res = await fetch(`${CONTROL_PLANE_URL}/api/approvals?orgId=${orgId}`);
  return res.json();
}

export async function getAuditLogs(orgId: string) {
  const res = await fetch(`${CONTROL_PLANE_URL}/api/audit-logs?orgId=${orgId}`);
  return res.json();
}
