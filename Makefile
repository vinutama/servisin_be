.PHONY: build-dev up-dev down-dev logs-dev shell-dev cnetwork init-rails-app fresh-start-dev bundle-install bundle-add

build-dev:
	docker compose build

up-dev:
	docker compose up -d

down-dev:
	docker compose down

logs-dev:
	docker compose logs -f --tail 100

shell-dev:
	docker compose exec servisin-app-be bash

cnetwork:
	docker network create servisin-network

new-migration:
	docker compose exec servisin-app-be bundle exec rails generate migration $(name)

migrate-up:
	docker compose exec servisin-app-be bundle exec rails db:migrate

migrate-rollback:
	docker compose exec servisin-app-be bundle exec rails db:rollback

bundle-install:
	docker compose exec servisin-app-be bundle install

bundle-add:
	docker compose exec servisin-app-be bundle add $(gem_name)

init-rails-app:
	docker run --rm \
		-v "$(CURDIR):/app" \
		-w /app \
		-e DEBIAN_FRONTEND=noninteractive \
		ruby:3.3.6-slim \
		bash -c "apt-get update -qq && \
			apt-get install -y --no-install-recommends build-essential libpq-dev curl git && \
			curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
			apt-get install -y --no-install-recommends nodejs && \
			gem install rails -v '~> 7.1' && \
			rails new . --force \
				--database=postgresql \
				--skip-test \
				--skip-jbuilder \
				--skip-git \
				--asset-pipeline=propshaft \
				--javascript=esbuild"

fresh-start-dev:
	make build-dev && \
	make up-dev && \
	make logs-dev