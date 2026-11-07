#!/bin/sh
# SPDX-License-Identifier: MIT
# Copyright (c) 2026 A Muhammed Fuzail — NetForensiq (https://github.com/fuzail04116/NetForensiq)

set -e

echo "==> Running database migrations..."
python manage.py migrate --noinput

echo "==> Seeding demo accounts..."
python manage.py seed_demo --synthetic-only --force || true

PORT_TO_BIND="${PORT:-8000}"
echo "==> Starting Gunicorn on port ${PORT_TO_BIND}..."
exec gunicorn netforensiq_backend.wsgi:application \
    --bind "0.0.0.0:${PORT_TO_BIND}" \
    --workers 2 \
    --timeout 1800 \
    --access-logfile -
