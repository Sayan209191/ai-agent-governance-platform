# Agent Runner (Python / FastAPI)

Simulates the Sales Agent and Refund Agent for local demos. Each mock agent
calls the Gateway's `/gateway/execute` endpoint exactly the way a real agent
integration would.

## Run locally

```bash
pip install -r requirements.txt
uvicorn main:app --reload --port 8000
```

## Try it

```bash
curl -X POST localhost:8000/agents/refund/run \
  -H "Content-Type: application/json" \
  -d '{"agent_id": "demo-agent", "amount": 25000}'
```
