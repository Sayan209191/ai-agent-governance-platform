package com.aigovernance.controlplane;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Entry point for the Control Plane service: agent registry, permissions
 * administration, policy management, and the human approval queue.
 * The latency-critical enforcement path lives in the separate Go Gateway
 * service — see services/gateway and docs/ARCHITECTURE.md.
 */
@SpringBootApplication
public class ControlPlaneApplication {
    public static void main(String[] args) {
        SpringApplication.run(ControlPlaneApplication.class, args);
    }
}
