# MiroFish Railway Template

Template-only repository for deploying **MiroFish** on Railway using the prebuilt image:

- `rezadevil/mirofish:latest`

This repo does not include MiroFish application source code.

## Files in this template

- `Dockerfile`: uses the published GHCR image
- `railway/start.sh`: starts backend + frontend with Railway-compatible ports
- `railway.json`: Railway build/deploy config
- `.env.example`: required runtime environment variables

## Deploy on Railway

1. Fork this repository.
2. In Railway, create a new project from your GitHub repo.
3. Railway will detect `railway.json` and build with `Dockerfile`.
4. Set required environment variables.

## Required variables

```env
LLM_API_KEY=your_api_key
LLM_BASE_URL=https://dashscope.aliyuncs.com/compatible-mode/v1
LLM_MODEL_NAME=qwen-plus
ZEP_API_KEY=your_zep_api_key
```

Optional:

```env
BACKEND_PORT=5001
```

## Runtime behavior

- Railway injects `PORT`; frontend listens on that port.
- Backend runs on internal port `5001` (or `BACKEND_PORT`).
- For persistent uploads/simulation data, mount a Railway Volume at `/app/backend/uploads`.

## Upstream project

MiroFish source project:

- https://github.com/666ghj/MiroFish
