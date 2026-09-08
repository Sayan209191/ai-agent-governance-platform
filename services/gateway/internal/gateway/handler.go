// Package gateway implements the core /gateway/execute flow:
// authenticate agent -> check permission -> evaluate policy -> execute or
// queue for approval -> write audit log.
package gateway

import (
	"encoding/json"
	"net/http"

	"github.com/yourorg/ai-agent-governance/gateway/internal/permission"
	"github.com/yourorg/ai-agent-governance/gateway/internal/policy"
)

type ExecuteRequest struct {
	AgentID string                 `json:"agent_id"`
	Tool    string                 `json:"tool"`
	Action  string                 `json:"action"`
	Payload map[string]interface{} `json:"payload"`
}

type ExecuteResponse struct {
	Status string `json:"status"` // executed | pending_approval | denied
	Detail string `json:"detail,omitempty"`
}

// ExecuteHandler is the single entrypoint every agent action passes through.
// TODO(dev): wire real Postgres-backed permission lookups and a real OPA
// client; this stub shows the intended control flow.
func ExecuteHandler(w http.ResponseWriter, r *http.Request) {
	var req ExecuteRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, "invalid request body", http.StatusBadRequest)
		return
	}

	if !permission.Check(req.AgentID, req.Tool, req.Action) {
		writeJSON(w, http.StatusForbidden, ExecuteResponse{
			Status: "denied",
			Detail: "agent lacks permission for this tool/action",
		})
		return
	}

	decision := policy.Evaluate(req.Action, req.Payload)

	switch decision {
	case "auto":
		// TODO(dev): call the real tool endpoint, record tool_calls + audit_logs
		writeJSON(w, http.StatusOK, ExecuteResponse{Status: "executed"})
	default:
		// TODO(dev): create an approvals row via the Control Plane API
		writeJSON(w, http.StatusAccepted, ExecuteResponse{
			Status: "pending_approval",
			Detail: decision,
		})
	}
}

func writeJSON(w http.ResponseWriter, status int, body interface{}) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)
	json.NewEncoder(w).Encode(body)
}
