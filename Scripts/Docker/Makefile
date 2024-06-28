.PHONY: all migrate fixtures

all: migrate fixtures

migrate:
	php bin/console d:m:m -n

fixtures:
	php bin/console hautelook:fixtures:load -n
