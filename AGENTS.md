# NixOS System Configuration

This repo contains the full NixOS system configuration for a desktop workstation (x86_64, Intel CPU, NVIDIA GPU with 24 GB VRAM). It is deployed via `sudo nixos-rebuild switch --flake .` or `sudo nixos-rebuild switch` from `/home/dan/.config/nixos`.

## Repo structure

Each `.nix` file is a self-contained NixOS module imported by `configuration.nix`:

- `configuration.nix` — top-level wiring: imports, bootloader, locale, nixpkgs settings
- `hardware-configuration.nix` — **auto-generated, do not edit** (disks, kernel modules, CPU)
- `nvidia.nix` — NVIDIA proprietary driver, modesetting, 32-bit graphics
- `docker.nix` — Podman (rootless), nvidia-container-toolkit for GPU passthrough
- `llm.nix` — Ollama (CUDA) + Open WebUI; both are manual-start (`systemctl start ollama`)
- `packages.nix` — system-wide packages and OBS Studio config
- `hyprland.nix` — Hyprland window manager
- `networking.nix` — hostname, NetworkManager, firewall
- `audio.nix` — PipeWire audio stack
- `services.nix` — printing, Avahi, gvfs, udisks2, polkit
- `programs.nix` — misc program enables (Firefox, Steam, etc.)
- `zsh.nix` — Zsh shell config and plugins
- `users.nix` — user accounts and groups
- `cleanup.nix` — automatic Nix GC and store optimization
- Other: `certs.nix`, `controllers.nix`, `fonts.nix`, `keyring.nix`, `nautilus.nix`, `opensnitch.nix`, `yubikey.nix`

## Conventions

- One concern per `.nix` file. New features get their own module.
- Module signature: `{ config, pkgs, lib, ... }:` (include `lib` even if unused — keeps diffs minimal when adding `mkForce` etc. later).
- Section headers use `############################` comment blocks.
- Services that are expensive (GPU, large models) use `wantedBy = lib.mkForce [];` so they don't start at boot.
- `allowUnfree = true` is set globally in `configuration.nix`.

## Rebuild workflow

```bash
sudo nixos-rebuild switch          # apply changes (no flake)
sudo nixos-rebuild test            # apply without adding to bootloader
sudo nixos-rebuild build           # build only, don't activate
```

After editing any `.nix` file, run `switch` (or `test`) and check `journalctl -xe` for errors.

## GPU container workloads (Podman)

`docker.nix` enables Podman with NVIDIA GPU passthrough via `nvidia-container-toolkit`. Containers use `--device nvidia.com/gpu=all --network host` to access the GPU and host services (e.g. Ollama on `:11434`).

Key runtime flags:
```bash
podman run --rm \
  --device nvidia.com/gpu=all \
  --network host \
  -e HF_TOKEN="$HF_TOKEN" \
  -v /path:/mount \
  image-name [args]
```

## Meeting pipeline

A containerized Python pipeline lives outside this repo (built as `meeting-pipeline` image). It processes audio files into structured meeting notes:

**Flow:** audio → WhisperX (transcribe + diarize, CUDA) → Ollama (qwen2.5:14b, JSON mode) → structured output

**Inputs:** audio file path, optional `--speakers N`. Env vars: `HF_TOKEN` (required), `OLLAMA_URL`, `OLLAMA_MODEL`.

**Outputs** (written next to input file):
- `*.transcript.txt` — `[MM:SS] SPEAKER_NN: text`
- `*.notes.json` — structured JSON with keys: `summary`, `decisions[]`, `action_items[]` (each `{owner, task, due}`), `open_questions[]`, `follow_ups[]`
- `*.notes.md` — human-readable Markdown

**Agent integration:** consume `*.notes.json` — it is stable and parseable. The `action_items` array maps directly to task creation (each item has `owner`, `task`, and `due` fields; `due` is `null` when no deadline was stated).

### Prerequisites (one-time)
1. NixOS config includes `docker.nix` (Podman + nvidia-container-toolkit) — already wired
2. HuggingFace token with pyannote model terms accepted (speaker-diarization-3.1 + segmentation-3.0)
3. `ollama pull qwen2.5:14b` on the host
4. `podman build -t meeting-pipeline .` from the pipeline source directory
