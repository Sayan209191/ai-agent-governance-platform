package governance.refund

# Example policy referenced throughout the docs: routes a refund action to
# auto-approval, manager approval, or finance approval based on amount.
#
# Input shape expected from the Gateway:
# {
#   "action": "refund",
#   "amount": 750,
#   "agent_id": "..."
# }

default decision := "manager"

decision := "auto" if {
    input.action == "refund"
    input.amount < 1000
}

decision := "manager" if {
    input.action == "refund"
    input.amount >= 1000
    input.amount < 10000
}

decision := "finance" if {
    input.action == "refund"
    input.amount >= 10000
}
