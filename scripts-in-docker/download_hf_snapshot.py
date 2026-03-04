#!/usr/bin/env python3
import os
from huggingface_hub import snapshot_download

REPO_ID = os.environ.get("HF_REPO_ID", "Qwen/Qwen3-Coder-Next-GGUF")
LOCAL_DIR = os.environ.get("HF_LOCAL_DIR", "/models/hf/Qwen3-Coder-Next-GGUF")

# Optional: make it stricter / smaller by setting allow_patterns
ALLOW = os.environ.get("HF_ALLOW_PATTERNS")  # e.g. "*.gguf,*.json"
allow_patterns = [p.strip() for p in ALLOW.split(",")] if ALLOW else None

print(f"[hf] repo_id={REPO_ID}")
print(f"[hf] local_dir={LOCAL_DIR}")
if allow_patterns:
    print(f"[hf] allow_patterns={allow_patterns}")

snapshot_download(
    repo_id=REPO_ID,
    local_dir=LOCAL_DIR,
    local_dir_use_symlinks=False,
    allow_patterns=allow_patterns,
)

print(f"[hf] done: {LOCAL_DIR}")
