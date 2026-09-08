// Agent registry view. TODO(dev): fetch real data via lib/api.ts::getAgents
// once an org/session context is available.
export default function AgentsPage() {
  return (
    <div>
      <h1 className="text-xl font-semibold mb-4">Agents</h1>
      <p className="text-slate-600">Registered agents will be listed here.</p>
    </div>
  );
}
