package com.aigovernance.controlplane.audit;

import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.UUID;

/** Backs the dashboard's Audit Explorer. Read-only — audit_logs is append-only. */
@RestController
@RequestMapping("/api/audit-logs")
public class AuditLogController {

    private final AuditLogRepository auditLogRepository;

    public AuditLogController(AuditLogRepository auditLogRepository) {
        this.auditLogRepository = auditLogRepository;
    }

    @GetMapping
    public List<AuditLog> recent(@RequestParam UUID orgId) {
        return auditLogRepository.findTop100ByOrgIdOrderByCreatedAtDesc(orgId);
    }
}
