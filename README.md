# Solidity Advanced Core

A Solidity-first repository focused on **advanced, production-oriented Solidity** code, patterns, and libraries.
Most of the logic is written in Solidity with minimal JavaScript — suitable for protocol engineers and auditors.

## What you'll find
- Upgradeability (UUPS proxy example)
- ERC20 + ERC4626-like vault pattern (storage optimized)
- Gas-optimized utilities (SafeTransferLib, Math, Storage packing)
- Assembly helpers and low-level patterns
- Example protocols: SimpleVault, Strategy interface
- Foundry-style Solidity tests (examples)
- Design docs: storage layout & gas notes

> This repo is for learning and demonstration. Do **not** use code in production without audit.

## Quickstart (local)
This repo is Solidity-first. To run tests (Foundry recommended):
```bash
# if using Foundry:
forge init   # if you want to migrate to a foundry project
# otherwise use Hardhat if you prefer JS stack (not included here)
```

Files of interest:
- `contracts/` — main contracts (Upgradeable, Vault, ERC20 storage token, utils)
- `tests/` — Foundry-style Solidity tests showing usage and invariants
- `docs/` — design notes and storage layout explanations
