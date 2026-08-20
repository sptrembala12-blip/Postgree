# Lounge System — GitHub ZIP → Render (Postgres)

Neste plano do Render **não há MySQL**. Use **Postgres**.

## Repo no GitHub deve ter

```text
lounge-system-v1.zip
Dockerfile
render.yaml
README.md
```

O Dockerfile **descompacta o ZIP no build**.

## No Render (sua tela + New)

### 1) Postgres
New → **Postgres** → Create  
Aguarde Available.

### 2) Web Service
New → **Web Service** → conecte o GitHub  
- Runtime: **Docker**
- Root Directory: vazio
- Health Check: `/up`

### 3) Environment

```env
APP_NAME=Lounge System
APP_ENV=production
APP_DEBUG=false
APP_URL=https://SEU-SERVICO.onrender.com
APP_KEY=          # gere e cole (base64:...)
APP_TIMEZONE=America/Sao_Paulo

DB_CONNECTION=pgsql
DB_HOST=...       # do Postgres
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

Dica: no Postgres do Render, em **Connect**, copie Internal Database URL / host etc.

### 4) Deploy
Espere build (unzip + composer).

### 5) Shell (1x)
```bash
php artisan db:seed --force
php artisan storage:link
```

Depois: `RUN_MIGRATIONS=false`

### Login demo
- admin@lounge.local / password
- atendente@lounge.local / password
