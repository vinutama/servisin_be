#!/bin/bash
set -e

rm -f /app/tmp/pids/server.pid

until pg_isready -h "${DB_HOST:-servisin-db}" -p 5432 -U "${POSTGRES_USER:-postgres}" -q; do
  echo "Waiting for postgres..."
  sleep 1
done

echo "Preparing database..."
bundle exec rails db:prepare

exec "$@"