# Lounge System — GitHub ZIP → Render (Postgres + PHP 8.4)

## Repo no GitHub

```text
lounge-system-v1.zip
Dockerfile
render.yaml
README.md
```

Dockerfile usa **PHP 8.4** (obrigatório por causa do composer.lock).

## Render

1. **New → Postgres**
2. **New → Web Service** → Docker → seu repo
3. Env (exemplo):

```env
APP_NAME=Lounge System
APP_ENV=production
APP_DEBUG=false
APP_URL=https://SEU-APP.onrender.com
APP_KEY=base64:...

APP_TIMEZONE=America/Sao_Paulo

DB_CONNECTION=pgsql
DB_HOST=...
DB_PORT=5432
DB_DATABASE=...
DB_USERNAME=...
DB_PASSWORD=...

LOG_CHANNEL=stderr
SESSION_DRIVER=database
CACHE_STORE=database
QUEUE_CONNECTION=database
FILESYSTEM_DISK=public
BROADCAST_CONNECTION=log
PAYMENT_GATEWAY=manual
RUN_MIGRATIONS=true
```

4. Deploy
5. Shell:
```bash
php artisan db:seed --force
php artisan storage:link
```
6. `RUN_MIGRATIONS=false`

Login: admin@lounge.local / password
