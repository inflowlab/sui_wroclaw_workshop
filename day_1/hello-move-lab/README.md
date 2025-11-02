# 👋 Lab #1 — Hello Move

Welcome to your first hands-on with **Sui Move**. In this lab you will:

- Build a tiny Move package
- Run unit tests
- Publish the package to **Devnet**
- Call an entry function
- Inspect created objects

> Estimated time: **30–45 minutes**. Works on **Windows** and **macOS**.

---

## ✅ Prerequisites

- Sui CLI installed and configured
- Connected to **Devnet** and funded (`sui client faucet`)
- This folder checked out on your machine

Verify:
```bash
sui --version
sui client switch --env devnet
sui client active-address
sui client gas
```

---

## 📦 Project Structure

```text
hello-move-lab/
├─ Move.toml
├─ sources/
│  └─ hello.move
└─ tests/
   └─ hello_tests.move
```

- `hello.move` — minimal module with:
  - pure function `greet()` (returns a `String`)
  - `add(a,b)` pure math
  - entry `create_greeting(msg)` that creates a **Greeting** object and transfers it to the sender
- `hello_tests.move` — unit tests for pure functions

---

## 🛠️ Build

> Run inside the `hello-move-lab/` folder

```bash
sui move build
```

You should see a successful build with no errors.

---

## 🧪 Test

```bash
sui move test
```

Expected:
- Tests pass for `greet()` and `add()`
- Output shows `0 failed`

---

## 🚀 Publish to Devnet

```bash
sui client publish --gas-budget 20000000
```

Save the `PACKAGE_ID` from the output. On macOS you can export it for convenience:

```bash
export PACKAGE_ID=<PACKAGE_ID_FROM_OUTPUT>
```

On Windows PowerShell:

```powershell
$Env:PACKAGE_ID="<PACKAGE_ID_FROM_OUTPUT>"
```

---

## 📞 Call the entry function (create an object)

Create a `Greeting` object owned by your address:

**macOS / bash / zsh**
```bash
sui client call \
  --package $PACKAGE_ID \
  --module hello \
  --function create_greeting \
  --args "Hello, Sui" \
  --gas-budget 20000000
```

**Windows PowerShell**
```powershell
sui client call `
  --package $Env:PACKAGE_ID `
  --module hello `
  --function create_greeting `
  --args "Hello, Sui" `
  --gas-budget 20000000
```

---

## 🔎 Inspect your objects

List objects you own and find **Greeting**:

```bash
sui client objects $(sui client active-address)
```

Look for something like:
```text
Type: <PACKAGE_ID>::hello::Greeting
ObjectID: 0x...
Owner: <your-address>
Version: 1
```

You can also fetch one object by ID:
```bash
sui client object <OBJECT_ID>
```

---

## 🧹 Bonus: Transfer your Greeting to a friend

```bash
sui client call \
  --package $PACKAGE_ID \
  --module hello \
  --function transfer_greeting \
  --args <GREETING_OBJECT_ID> <RECIPIENT_ADDRESS> \
  --gas-budget 20000000
```

Verify the new owner with `sui client object --id <GREETING_OBJECT_ID>`.

---

## ❓ Troubleshooting

- **Faucet errors (429)** → wait 1–2 minutes and retry
- **Gas budget too low** → increase `--gas-budget` (e.g., `40000000`)
- **Wrong `PACKAGE_ID`** → republish and update the variable
- **Command not found** → ensure Sui CLI is in your PATH

---

## ✅ Lab Checklist

- [ ] Built the package
- [ ] Tests passed
- [ ] Published to Devnet and saved `PACKAGE_ID`
- [ ] Created a `Greeting` object
- [ ] Found it in `sui client objects`
- [ ] (Optional) Transferred the object

Happy hacking! 🎉
