// Package main starts the Agent Gateway — the latency-critical service that
// sits between every agent and every tool call. It checks permissions,
// evaluates policy via OPA, and either executes the action or creates an
// approval request. See docs/ARCHITECTURE.md for the full request flow.
package main

import (
	"log"
	"net/http"
	"os"

	"github.com/go-chi/chi/v5"
	"github.com/yourorg/ai-agent-governance/gateway/internal/gateway"
)

func main() {
	port := os.Getenv("GATEWAY_PORT")
	if port == "" {
		port = "8080"
	}

	r := chi.NewRouter()
	r.Get("/healthz", func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
		w.Write([]byte("ok"))
	})
	r.Post("/gateway/execute", gateway.ExecuteHandler)

	log.Printf("gateway listening on :%s", port)
	if err := http.ListenAndServe(":"+port, r); err != nil {
		log.Fatal(err)
	}
}
