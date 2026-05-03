#!/bin/sh
set -eu

FRONTEND_PORT="${PORT:-3000}"
BACKEND_PORT="${BACKEND_PORT:-5001}"

# Allow Vite to accept Railway's generated public hostname.
if [ -n "${RAILWAY_PUBLIC_DOMAIN:-}" ]; then
  export __VITE_ADDITIONAL_SERVER_ALLOWED_HOSTS="${RAILWAY_PUBLIC_DOMAIN}"
fi

cd /app

FLASK_DEBUG=False FLASK_HOST=0.0.0.0 FLASK_PORT="${BACKEND_PORT}" uv run python backend/run.py &
backend_pid=$!

cd /app/frontend
npm run dev -- --host 0.0.0.0 --port "${FRONTEND_PORT}" --strictPort &
frontend_pid=$!

terminate() {
  kill "${backend_pid}" "${frontend_pid}" 2>/dev/null || true
}

trap terminate INT TERM

# If either process exits, shut down the other and terminate container.
while kill -0 "${backend_pid}" 2>/dev/null && kill -0 "${frontend_pid}" 2>/dev/null; do
  sleep 1
done

terminate
wait "${backend_pid}" "${frontend_pid}" 2>/dev/null || true
exit 1
