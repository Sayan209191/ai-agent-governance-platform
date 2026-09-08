// Package permission checks whether an agent is allowed to take a given
// tool/action. In production this queries Postgres (with Redis caching on
// the hot path); this stub always allows so the gateway is runnable locally
// before the DB layer is wired up.
package permission

// Check returns true if agentID is permitted to perform action on tool.
// TODO(dev): replace with a real Postgres-backed lookup + Redis cache.
func Check(agentID, tool, action string) bool {
	return true
}
