# Load DB_URL from .env
include .env
export $(shell sed 's/=.*//' .env)

MIGRATE_CMD = docker-compose run --rm migrate
MIGRATE_PATH = -path=./migrations
MIGRATE_DB = -database="mysql://$(DB_USER):$(DB_PASSWORD)@tcp(db:$(DB_PORT))/$(DB_NAME)?tls=false"

DB_CONTAINER = my_mysql_db
SQL_DIR = seeds
DB_CLI = docker exec -i $(DB_CONTAINER) mysql -u$(DB_USER) -p$(DB_PASSWORD) $(DB_NAME)


.PHONY: docker-build docker-up migrate-up migrate-down migrate-version migrate-force migrate-create seed-all seed-one

docker-build:
	docker-compose build

docker-up:
	docker-compose up -d

migrate-up:
	@echo "Running migration UP..."
	$(MIGRATE_CMD) $(MIGRATE_PATH) $(MIGRATE_DB) up

migrate-down:
	@echo "Rolling back last migration..."
	$(MIGRATE_CMD) $(MIGRATE_PATH) $(MIGRATE_DB) down

migrate-version:
	@echo "Current migration version:"
	$(MIGRATE_CMD) $(MIGRATE_PATH) $(MIGRATE_DB) version

migrate-force:
	@echo "Forcing migration to version $(version)..."; \
	if [ -z "$(version)" ]; then \
		echo "Please provide version: make migrate-force version=<number>"; \
		exit 1; \
	else \
		echo "Running force to version $(version)"; \
		$(MIGRATE_CMD) $(MIGRATE_PATH) $(MIGRATE_DB) force $(version); \
	fi

migrate-create:
	@echo "Creating migration: $(name)"; \
	if [ -z "$(name)" ]; then \
		echo "Please provide a migration name: make migrate-create name=your_name"; \
		exit 1; \
	else \
		$(MIGRATE_CMD) create -ext sql -dir ./migrations -seq $(name); \
		echo "Migration '$(name)' created successfully."; \
	fi

## Seed all .sql files in seeds/
seed-all:
	@echo "Seeding all .sql files in '$(SQL_DIR)'"; \
	rm -f seed-error.log; \
	total=0; \
	for file in $(shell ls $(SQL_DIR)/*.sql | sort); do \
		echo "Seeding $$file..."; \
		start=$$(date +%s); \
		$(DB_CLI) < $$file 2> tmp_err.log || { \
			echo "ERROR in $$file" | tee -a seed-error.log; \
			cat tmp_err.log | tee -a seed-error.log; \
		}; \
		end=$$(date +%s); \
		duration=$$((end - start)); \
		total=$$((total + duration)); \
		echo "Executed $$file in $$duration seconds"; \
	done; \
	rm -f tmp_err.log; \
	echo "Total Executed time: $$((total)) seconds"; \
	echo "All seeding completed. Check 'seed-error.log' if any issues."

## Seed a single file: make seed-one file=seeds/01_users.sql
seed-one:
	@if [ -z "$(file)" ]; then \
		echo "Please provide file=seeds/your_file.sql"; \
		exit 1; \
	fi; \
	echo "Seeding $(file)..."; \
	start=$$(date +%s); \
	$(DB_CLI) < $(file) 2> tmp_err.log || { \
		echo "ERROR in $(file)" | tee -a seed-error.log; \
		cat tmp_err.log | tee -a seed-error.log; \
		rm -f tmp_err.log; \
		exit 1; \
	}; \
	end=$$(date +%s); \
	duration=$$((end - start)); \
	rm -f tmp_err.log; \
	echo "Seeding $(file) completed in $$duration seconds."