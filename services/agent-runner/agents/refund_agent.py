"""Mock Refund Agent — demonstrates the gateway's auto vs. human-approval flow."""
import os
import httpx

GATEWAY_BASE_URL = os.getenv("GATEWAY_BASE_URL", "http://localhost:8080")


def run_refund_agent(agent_id: str, amount: float) -> dict:
    payload = {
        "agent_id": agent_id,
        "tool": "payments",
        "action": "refund",
        "payload": {"amount": amount},
    }
    # TODO(dev): add the agent's signed API key as a header once agent
    # identity issuance is wired up in the Control Plane.
    response = httpx.post(f"{GATEWAY_BASE_URL}/gateway/execute", json=payload, timeout=10.0)
    return response.json()
