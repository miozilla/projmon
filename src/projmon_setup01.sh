#!/bin/bash
# gcp-alert-policy.sh
# Script to configure Google Cloud Monitoring alerting policy via Cloud Shell

# Variables
PROJECT_ID="my-project"
EMAIL="devops@example.com"
CHANNEL_NAME="DevOps Email"
POLICY_NAME="High CPU Alert"

# 1. Create Notification Channel
echo "Creating notification channel..."
CHANNEL_ID=$(gcloud alpha monitoring channels create \
  --project="$PROJECT_ID" \
  --display-name="$CHANNEL_NAME" \
  --type=email \
  --channel-labels=email_address="$EMAIL" \
  --format="value(name)")

echo "Notification channel created: $CHANNEL_ID"

# 2. Create Alerting Policy
echo "Creating alerting policy..."
gcloud alpha monitoring policies create \
  --project="$PROJECT_ID" \
  --display-name="$POLICY_NAME" \
  --condition-display-name="CPU > 80%" \
  --condition-filter='metric.type="compute.googleapis.com/instance/cpu/utilization" AND resource.type="gce_instance"' \
  --condition-threshold-value=0.8 \
  --condition-threshold-comparison=COMPARISON_GT \
  --condition-threshold-duration=300s \
  --condition-threshold-aggregation='{"alignmentPeriod":"60s","perSeriesAligner":"ALIGN_MEAN"}' \
  --notification-channels="$CHANNEL_ID" \
  --documentation="CPU utilization exceeded 80% for 5 minutes. Investigate high load."

echo "Alerting policy created successfully!"
