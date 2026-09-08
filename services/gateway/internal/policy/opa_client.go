// Package policy evaluates governance policy for a given action, normally by
// calling the OPA sidecar's REST API. This stub applies the same thresholds
// as policies/refund_policy.rego so the gateway is runnable before the real
// OPA HTTP call is wired up.
package policy

// Evaluate returns one of: "auto", "manager", "finance".
// TODO(dev): replace with a real HTTP call to OPA at OPA_URL, POST
// /v1/data/governance/refund/decision with {"input": {...}}.
func Evaluate(action string, payload map[string]interface{}) string {
	amount, _ := payload["amount"].(float64)
	switch {
	case amount < 1000:
		return "auto"
	case amount < 10000:
		return "manager"
	default:
		return "finance"
	}
}
