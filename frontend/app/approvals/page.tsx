// Pending approval queue. TODO(dev): fetch via lib/api.ts::getPendingApprovals
// and wire Approve/Reject buttons to the Control Plane's /api/approvals/{id}/approve|reject.
export default function ApprovalsPage() {
  return (
    <div>
      <h1 className="text-xl font-semibold mb-4">Approval Queue</h1>
      <p className="text-slate-600">Pending approvals will be listed here.</p>
    </div>
  );
}
