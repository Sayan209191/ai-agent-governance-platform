// Audit explorer. TODO(dev): fetch via lib/api.ts::getAuditLogs and add
// filtering by agent/action/date once the dataset is non-trivial.
export default function AuditPage() {
  return (
    <div>
      <h1 className="text-xl font-semibold mb-4">Audit Trail</h1>
      <p className="text-slate-600">Audit log entries will be listed here.</p>
    </div>
  );
}
