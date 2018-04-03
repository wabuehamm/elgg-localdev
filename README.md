# elgg-localdev
Localdev for Elgg using Docker

## Introduction

This Docker environment is used to start up a local elgg development environment for the Waldbuehne Heessen Members area using Docker.

It relies on greyltc/lamp

## Usage

Export the site using the site's export script and untar the resulting export.tar.gz into this directory. Then run

    docker-compose up -d

and you will have a locally running web server on https://localhost:8443 with the current state of the member area.
