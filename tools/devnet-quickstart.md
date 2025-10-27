# 🧭 Kick-off & Setup Check (15 min)

Goal: Ensure SUI CLI works on **Devnet** and everyone has coins for gas.

---

## 1️⃣ Install tools (before class)
- **Git:** https://git-scm.com/downloads
- **Rust toolchain:** https://rustup.rs  
  ```bash
  rustup install stable && rustup update
  ```
- **VS Code** + **Move Analyzer** extension: https://marketplace.visualstudio.com/items?itemName=move.move-analyzer

---

## 2️⃣ Install SUI CLI
**macOS**
```bash
brew install sui
sui --version
```

**Windows (PowerShell)**
1) Download latest ZIP: https://github.com/MystenLabs/sui/releases  
2) Extract; add folder to PATH  
3) Verify:
```powershell
sui --version
```

Expected: prints a version (e.g., `sui 1.xx.x`).

---

## 3️⃣ Initialize SUI client config
```bash
sui client
```
Creates config at:
- macOS: `~/.sui/`
- Windows: `C:\Users\<you>\.sui\`

---

## 4️⃣ Switch to Devnet
```bash
sui client switch --env devnet
sui client envs    # expect: * devnet (active)
```

---

## 5️⃣ Create or select an address
```bash
sui client new-address ed25519
sui client addresses
# if needed:
sui client switch --address <ADDRESS>
```

---

## 6️⃣ Fund from faucet (Devnet)
```bash
sui client faucet
sui client gas     # expect non-zero balance (MIST)
```
If rate-limited, wait ~30s and retry.

---

## 7️⃣ Quick health check
```bash
sui --version
sui client active-address
sui client gas
sui move build    # OK if it says “No Move.toml” (not in a package yet)
```

---

## 8️⃣ Clone the workshop repo (after setup)
```bash
git clone https://github.com/<instructor-org>/sui-move-workshop.git
cd sui-move-workshop
```
You should see:
```
day1/
day2/
tools/
```

---

## ✅ Instructor verification checklist (project on screen)
- [ ] `sui --version` prints a version
- [ ] `sui client switch --env devnet` succeeds
- [ ] `sui client new-address ed25519` (or existing active address)
- [ ] `sui client faucet` succeeds
- [ ] `sui client gas` shows non-zero balance

---

## 🛠️ Troubleshooting (quick fixes)
| Symptom | Likely cause | Fix |
|---|---|---|
| `sui: command not found` | PATH missing/old binary | Reinstall SUI or fix PATH |
| Faucet `429 Too Many Requests` | Throttled | Wait 1–2 min and retry |
| `cannot reach gateway` | Network/firewall/VPN | Try different network or disable VPN |
| No Move highlighting in VS Code | Missing extension | Install **Move Analyzer** and reload |
| Wrong CLI version used | Multiple SUI in PATH | Remove old binary; check `which sui` / `Get-Command sui` |

---

## ▶️ Next
Proceed to **Day 1 – Lab #1 “Hello Move”** (build, test, publish).
