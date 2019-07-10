# elgg-localdev
Localdev for Elgg using Docker

## Introduction

This Docker environment is used to start up a local elgg development environment for the Waldbuehne Heessen Members area using Docker.

It relies on mariadb and alpine.

## Usage

Clone this repository to a local directory:

    git clone https://github.com/wabuehamm/elgg-localdev.git
    cd elgg-localdev

Export the site using the site's export script and untar the resulting export.tar.gz into this directory. Delete the file caches:

    tar xzf export.tar.gz
    rm -rf export/data/*cache*

Then run

    docker-compose up -d --build

and you will have a locally running web server on https://localhost:8443 with the current state of the member area.

To enter the container and test out things locally, run

    docker exec -it mitglieder_web_1 sh

To see all apache logs run

    docker logs -f mitglieder_web_1

To stop and remove it again, run

    docker-compose down
