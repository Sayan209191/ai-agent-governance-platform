"""
Agent Runner — simulates agents (Sales Agent, Refund Agent) calling the
Gateway, for local demos and integration testing. Keeps LLM/agent-specific
logic isolated from the Control Plane, per docs/ARCHITECTURE.md.
"""
from fastapi import FastAPI
from pydantic import BaseModel

from agents.refund_agent import run_refund_agent
from agents.sales_agent import run_sales_agent

app = FastAPI(title="Agent Runner")


class RefundRequest(BaseModel):
    agent_id: str
    amount: float


@app.get("/healthz")
def healthz():
    return {"status": "ok"}


@app.post("/agents/refund/run")
def refund(req: RefundRequest):
    return run_refund_agent(req.agent_id, req.amount)


@app.post("/agents/sales/run")
def sales(agent_id: str):
    return run_sales_agent(agent_id)
