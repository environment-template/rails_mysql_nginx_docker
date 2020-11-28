APP_CONTAINER_ID = `docker ps --filter publish=3000 -q`
DB_CONTAINER_ID  = `docker ps --filter publish=5432 -q`

build:
	docker-compose build

setup:
	docker-compose run --rm rails sh -c "bundle install && bundle exec rake db:create db:migrate db:seed_fu"

bash:
	docker-compose run --rm rails /bin/bash

dbcreate:
	docker-compose run --rm rails bundle exec rake db:create

dbmigrate:
	docker-compose run --rm rails bundle exec rake db:migrate

dbreset:
	docker-compose run --rm rails bundle exec rake db:migrate:reset db:seed_fu

seed:
	docker-compose exec rails bundle exec rake db:seed_fu

restart: down up

up:
	rm -f tmp/pids/server.pid
	# docker-compose run --rm rails bundle exec puma -C config/puma.rb
	docker-compose up

down:
	docker-compose down

lint:
	docker-compose run --rm rails sh -c "rubocop -a && erblint app/**/*.html{+*,}.erb -a"

attach:
	docker attach ${APP_CONTAINER_ID}

