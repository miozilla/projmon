#!/bin/bash
# gcp-alert-policy-json.sh
# Script to configure Google Cloud Monitoring alerting policy using policy.json

# Variables
PROJECT_ID="my-project"
EMAIL="devops@example.com"
CHANNEL_NAME="DevOps Email"
POLICY_FILE="policy.json"

# 1. Create Notification Channel
echo "Creating notification channel..."
CHANNEL_ID=$(gcloud alpha monitoring channels create \
  --project="$PROJECT_ID" \
  --display-name="$CHANNEL_NAME" \
  --type=email \
  --channel-labels=email_address="$EMAIL" \
  --format="value(name)")

echo "Notification channel created: $CHANNEL_ID"

# 2. Create Alerting Policy from JSON file
echo "Creating alerting policy from $POLICY_FILE..."
gcloud monitoring policies create \
  --project="$PROJECT_ID" \
  --policy-from-file="$POLICY_FILE"

echo "Alerting policy created successfully!"
