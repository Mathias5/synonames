
all: shell

build: parse pairs synonyms

pairs:
	python3 src/pairs.py

synonyms: pairs
	python3 src/synonyms.py

/data/latest-truthy.nt.bz2:
	wget -O /data/latest-truthy.nt.bz2 https://dumps.wikimedia.org/wikidatawiki/entities/latest-truthy.nt.bz2

parse:
	curl -s https://dumps.wikimedia.org/wikidatawiki/entities/latest-truthy.nt.bz2 | bzcat | python3 src/parser.py

parse-local: /data/latest-truthy.nt.bz2
	bzcat /data/latest-truthy.nt.bz2 | python3 src/parser.py

build:
	docker-compose build

shell:
	docker-compose run --rm worker bash

down:
	docker-compose down