all: init build

init:
	mkdir assets_flexget

build: build_flexget build_transmission

build_flexget:
	docker build -t kpacha/flexget flexget

build_transmission:
	docker build -t kpacha/transmission transmission

run: run_transmission run_flexget

run_transmission:
	docker run --name transmission -d -p 9091:9091 -p 51413:51413 -p 51413:51413/udp kpacha/transmission

run_flexget:
	docker run --name flexget -d --volumes-from transmission -v "${PATH_TO_SHOWS}:/shows" \
	    -v "${PWD}/assets_flexget:/root/.flexget" \
	    -e "RSS_URL=${RSS_URL}" \
	    -e "SUBTITLE_LANGUAGE=${SUBTITLE_LANGUAGE}" \
	    --link "transmission:transmission" \
	    -p 5050:5050 \
	    kpacha/flexget

restart:
	docker start transmission flexget
