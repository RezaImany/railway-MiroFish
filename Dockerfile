FROM rezadevil/mirofish

CMD ["sh","-lc","VITE_API_BASE_URL=${VITE_API_BASE_URL:-http://localhost:${BACKEND_PORT:-5001}} npm --prefix frontend run build && cd /app/backend && uv run --with gunicorn gunicorn -w ${BACKEND_WORKERS:-2} -b 0.0.0.0:${BACKEND_PORT:-5001} 'app:create_app()' & BACK_PID=$!; cd /app; npm --prefix frontend run preview -- --host 0.0.0.0 --port ${PORT:-3000} --strictPort & FRONT_PID=$!; trap 'kill $BACK_PID $FRONT_PID 2>/dev/null || true' INT TERM; wait $BACK_PID $FRONT_PID"]
