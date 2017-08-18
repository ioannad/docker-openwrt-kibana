# Kibana docker image from mcreations/openwrt-java:8

Based on instructions for a local install, found in:
https://www.elastic.co/guide/en/kibana/current/index.html, where "current" is now 5.5.x.

## Requirements

[Docker](https://www.docker.com/)

## Installation

Download or clone the repository and from inside the repository's directory execute: 

```
docker build . -t docker-openwrt-kibana:5.5.0
```

## Usage

To run a detached (-d) instance of Kibana, transmitting on `localhost:5601` (-p 5601:5601)  execute:

```
docker run -d -p 5601:5601 docker-openwrt-kibana:5.5.0 
```

This will look for elasticsearch indices on `http://elasticsearch:9200`. 
 
To change the location of elasticsearch to `http://some.other.host:XXXX` execute:

```
docker run -d -e ELASTICSEARCH_URL=http://some.other.host:XXXX -p 5601:5601 docker-openwrt-kibana:5.5.0
```
