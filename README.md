# 🚀 NexusBot — Multi-Node Launcher for Nexus Testnet III

A simple automation script to run **multiple Nexus Prover Nodes** using `screen` and `node.txt`. Designed to reduce manual work and keep all nodes running in parallel on background sessions with logs.

---

## 📦 Requirements

- Ubuntu/Debian system
- `screen` installed (usually pre-installed)
- Nexus CLI installed (auto-installs via script if missing)
- Your Node IDs saved in `node.txt`

---

## 📁 Files

| File             | Purpose                                      |
|------------------|----------------------------------------------|
| `nexus.sh`       | Main launcher script (auto-creates sessions) |
| `node.txt`       | List of Node IDs (one per line)              |
| `node_X_log.txt` | Auto-generated logs for each node session    |

---

## 📄 node.txt Format

Put each Node ID (from Nexus Dashboard) in a new line like:

```
12792333
12792338
12792340
```

---

## ⚙️ Setup Instructions

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Triplooker/nexusBot.git
   cd nexusBot
   ```

2. **Make script executable**:
   ```bash
   chmod +x nexus.sh
   ```

3. **Fix CLI path (if needed)**:
   ```bash
   echo 'export PATH="$HOME/.nexus/bin:$PATH"' >> ~/.bashrc
   source ~/.bashrc
   ```

4. **Run the launcher**:
   ```bash
   ./nexus.sh
   ```

---

## 🖥️ Managing Screen Sessions

- **List running nodes**:
  ```bash
  screen -ls
  ```

- **Attach to a specific session**:
  ```bash
  screen -r nexus_1
  ```

- **Exit screen but keep node running**:  
  Press `Ctrl + A`, then `D` to detach

- **Check logs**:
  ```bash
  tail -f node_1_log.txt
  ```

---

## 🛠 Troubleshooting

- If CLI not found:  
  Make sure Nexus CLI is installed to `~/.nexus/bin`, and your `PATH` is set.

- If screens are not appearing:  
  Run `nexus-network start --node-id <your-node-id>` manually to check for errors.

---

## 💡 Tips

- You can add up to 10–15 node IDs depending on your system resources.
- Add a systemd service or `crontab` to restart `nexus.sh` on reboot.
- Monitor logs regularly with `tail -f`.

---

## 🙌 Credits

Created by [@itsmesatyavir](https://github.com/itsmesatyavir)  
Based on the official [Nexus Testnet III](https://docs.nexus.xyz/) documentation.

---

## 🧪 Disclaimer

This tool is provided "as-is" and is intended for educational/testnet use only. Not affiliated with Nexus officially.
