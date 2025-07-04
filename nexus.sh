#!/bin/bash

# File: nexus.sh
# Purpose: Run all Nexus nodes listed in node.txt in separate screen sessions

# Load environment variables
source ~/.bashrc
source $HOME/.cargo/env

# Check if Nexus CLI is installed
if ! command -v nexus-network &> /dev/null; then
  echo "🛠️ Installing Nexus CLI..."
  curl https://cli.nexus.xyz/ | sh
  source ~/.bashrc
fi

# Check node.txt exists
if [[ ! -f "node.txt" ]]; then
  echo "❌ node.txt not found! Please create it with one NODE_ID per line."
  exit 1
fi

# Launch each node in a separate screen session
index=1
while IFS= read -r NODE_ID || [[ -n "$NODE_ID" ]]; do
  if [[ -n "$NODE_ID" ]]; then
    SCREEN_NAME="nexus_$index"
    echo "🚀 Launching Node ID $NODE_ID in screen session: $SCREEN_NAME"

    screen -dmS "$SCREEN_NAME" bash -c "
      source ~/.bashrc
      source $HOME/.cargo/env
      nexus-network start --node-id $NODE_ID
    "

    ((index++))
  fi
done < node.txt

echo "✅ All nodes are now running in background screen sessions."
