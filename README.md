flexget-docker
====

# Requirements

+ docker
+ rss feed
+ git (optional)

# Get it

## From Docker hub

Pull the images

	$ docker pull kpacha/transimission:latest
	$ docker pull kpacha/flexget:latest

Create a folder for the flexget config

	$ mkdir assets_flexget

## From Github

Clone the repo and build the images

	$ git clone
	$ cd flexget-docker
	$ make

# Run it for the first time

Run the transmission container

	$ docker run --name transmission -d \
	    -p 9091:9091 -p 51413:51413 -p 51413:51413/udp \
	    kpacha/transmission

Run the transmission container (see below for config details)

	$ docker run --name flexget -d \
	    --volumes-from transmission \
	    -v ${PATH_TO_SHOWS}:/shows \
	    -v "${PWD}/assets_flexget:/root/.flexget" \
	    -e "RSS_URL=${RSS_URL}" \
	    -e "SUBTITLE_LANGUAGE=${SUBTITLE_LANGUAGE}" \
	    --link "transmission:transmission" \
	    -p 5050:5050 \
	    kpacha/flexget

Alternativaly, if you cloned the repo and built the images locally, you could also run both containers at the same time with this simple oneliner:

	$ SUBTITLE_LANGUAGE=es RSS_URL=some_url PATH_TO_SHOWS="/path/to/shows/folder" make run

In both cases, you need to define 3 env vars:

+ `SUBTITLE_LANGUAGE`: wanted language (ISO 639-1 two chars) for the subtitles (fr, en, ja, ...)
+ `RSS_URL`: the url of the rss feed
+ `PATH_TO_SHOWS`: path to the folder where all the files will be stored

If you are running the flexget container directly, remember to set the `/root/.flexget` volume properly.

# Stop it

	$ docker stop flexget transmission

# Run it again

	$ docker start transmission flexget
