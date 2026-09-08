package com.aigovernance.controlplane.agent;

import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.UUID;

/**
 * Agent registry admin API — register, list, enable/disable agents.
 * Consumed by the frontend dashboard's Agent Registry view.
 */
@RestController
@RequestMapping("/api/agents")
public class AgentController {

    private final AgentRepository agentRepository;

    public AgentController(AgentRepository agentRepository) {
        this.agentRepository = agentRepository;
    }

    @GetMapping
    public List<Agent> list(@RequestParam UUID orgId) {
        return agentRepository.findByOrgId(orgId);
    }

    @PostMapping
    public Agent register(@RequestBody Agent agent) {
        // TODO(dev): generate + hash an API key into agent_identities here
        return agentRepository.save(agent);
    }
}
