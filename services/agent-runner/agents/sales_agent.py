"""Mock Sales Agent — demonstrates a simple, always-auto-approved action."""
import os
import httpx

GATEWAY_BASE_URL = os.getenv("GATEWAY_BASE_URL", "http://localhost:8080")


def run_sales_agent(agent_id: str) -> dict:
    payload = {
        "agent_id": agent_id,
        "tool": "crm",
        "action": "update_contact",
        "payload": {},
    }
    response = httpx.post(f"{GATEWAY_BASE_URL}/gateway/execute", json=payload, timeout=10.0)
    return response.json()
