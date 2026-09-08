package com.aigovernance.controlplane.approval;

import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.UUID;

/**
 * Approval queue API — backs the dashboard's approval queue and the
 * Gateway's "pending_approval" flow (see services/gateway).
 */
@RestController
@RequestMapping("/api/approvals")
public class ApprovalController {

    private final ApprovalRepository approvalRepository;

    public ApprovalController(ApprovalRepository approvalRepository) {
        this.approvalRepository = approvalRepository;
    }

    @GetMapping
    public List<Approval> pending(@RequestParam UUID orgId) {
        return approvalRepository.findByOrgIdAndStatus(orgId, "pending");
    }

    @PostMapping("/{id}/approve")
    public Approval approve(@PathVariable UUID id, @RequestParam UUID approverId) {
        Approval approval = approvalRepository.findById(id).orElseThrow();
        approval.setStatus("approved");
        approval.setApproverId(approverId);
        approval.setResolvedAt(java.time.Instant.now());
        // TODO(dev): notify the Gateway / trigger the deferred tool call
        return approvalRepository.save(approval);
    }

    @PostMapping("/{id}/reject")
    public Approval reject(@PathVariable UUID id, @RequestParam UUID approverId) {
        Approval approval = approvalRepository.findById(id).orElseThrow();
        approval.setStatus("rejected");
        approval.setApproverId(approverId);
        approval.setResolvedAt(java.time.Instant.now());
        return approvalRepository.save(approval);
    }
}
