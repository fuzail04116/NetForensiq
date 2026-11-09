#!/bin/sh
# SPDX-License-Identifier: MIT
# Copyright (c) 2026 A Muhammed Fuzail — NetForensiq (https://github.com/fuzail04116/NetForensiq)

set -e

# Ensure a stable SECRET_KEY is set in environment so all gunicorn workers share it
if [ -z "$SECRET_KEY" ]; then
    KEY_FILE="/app/data/.secret_key"
    if [ -f "$KEY_FILE" ]; then
        SECRET_KEY=$(cat "$KEY_FILE")
    else
        SECRET_KEY=$(python3 -c "import secrets; print(secrets.token_urlsafe(50))")
        echo "$SECRET_KEY" > "$KEY_FILE" 2>/dev/null || true
    fi
    export SECRET_KEY
fi

echo "==> Running database migrations..."
python3 manage.py migrate --noinput

echo "==> Seeding demo accounts..."
python3 manage.py seed_demo --synthetic-only --force || true

PORT_TO_BIND="${PORT:-8000}"
echo "==> Starting Gunicorn on port ${PORT_TO_BIND}..."
exec gunicorn netforensiq_backend.wsgi:application \
    --bind "0.0.0.0:${PORT_TO_BIND}" \
    --workers 2 \
    --timeout 1800 \
    --access-logfile -

