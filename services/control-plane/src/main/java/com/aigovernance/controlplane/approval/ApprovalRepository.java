package com.aigovernance.controlplane.approval;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.UUID;

public interface ApprovalRepository extends JpaRepository<Approval, UUID> {
    List<Approval> findByOrgIdAndStatus(UUID orgId, String status);
}
