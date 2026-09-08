package com.aigovernance.controlplane.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

/**
 * Security baseline for the Control Plane. Human users authenticate via
 * OIDC (see docs/ARCHITECTURE.md — Auth section); agents authenticate to the
 * Gateway separately via signed API keys, not through this filter chain.
 *
 * TODO(dev): replace permitAll() with real OAuth2 resource-server config
 * once an OIDC provider (Auth0/WorkOS) is wired up.
 */
@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/actuator/health").permitAll()
                .anyRequest().permitAll() // TODO(dev): tighten before any real deployment
            );
        return http.build();
    }
}
