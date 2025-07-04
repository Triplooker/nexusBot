#!/bin/bash

# === nexus.sh ===
# Starts multiple Nexus nodes in separate screen sessions

BASHRC="$HOME/.bashrc"
CARGO_ENV="$HOME/.cargo/env"

# Load environment safely
if [[ -f "$BASHRC" ]]; then
  source "$BASHRC"
fi

if [[ -f "$CARGO_ENV" ]]; then
  source "$CARGO_ENV"
fi

# Install Nexus CLI if missing
if ! command -v nexus-network &> /dev/null; then
  echo "🛠️ Installing Nexus CLI..."
  curl -s https://cli.nexus.xyz/ | sh
  source "$BASHRC"
fi

# Check node.txt file
if [[ ! -f "node.txt" ]]; then
  echo "❌ node.txt not found! Add one NODE_ID per line."
  exit 1
fi

# Read and launch nodes
index=1
while IFS= read -r NODE_ID || [[ -n "$NODE_ID" ]]; do
  if [[ ! -z "$NODE_ID" ]]; then
    SCREEN_NAME="nexus_$index"
    LOG_FILE="node_${index}_log.txt"

    echo "🚀 Launching Node ID $NODE_ID in screen [$SCREEN_NAME] — Logging to $LOG_FILE"

    screen -dmS "$SCREEN_NAME" bash -c "
      echo '▶️ Node $NODE_ID started at \$(date)' | tee $LOG_FILE
      source $BASHRC
      if [[ -f \"$CARGO_ENV\" ]]; then
        source \"$CARGO_ENV\"
      fi
      nexus-network start --node-id $NODE_ID 2>&1 | tee -a $LOG_FILE
    "

    ((index++))
  fi
done < node.txt

echo "✅ All node sessions launched. Use 'screen -ls' to list them."
