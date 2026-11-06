# SPDX-License-Identifier: MIT
# Copyright (c) 2026 A Muhammed Fuzail — NetForensiq (https://github.com/fuzail04116/NetForensiq)
"""
ASGI config for netforensiq_backend project.

It exposes the ASGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/6.0/howto/deployment/asgi/
"""

import os

from django.core.asgi import get_asgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'netforensiq_backend.settings')

application = get_asgi_application()
