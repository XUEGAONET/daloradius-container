# Daloradius Container Image

## About

* Docker image for Daloradius based on latest Ubuntu LTS
* includes Apache, php, MariaDB-client
* needs a separate MariaDB and FreeRadius
* access under `your-ip-or-url/`
* User: `administrator` Password: `radius`
* With rolling upgrade  support

## Cli usage

Both docker and podman are working properly.

```bash
docker run -d -it --name daloradius --restart=always \
  --network=<network name> \
  --ip=<ip address> \
  -e MYSQL_DATABASE=<database name> \
  -e MYSQL_PORT=<database port> \
  -e MYSQL_USER=<database user> \
  -e MYSQL_PASSWORD=<database password> \
  -e MYSQL_HOST=<database host> \
  -e TZ=<timezone> \
  a980883231/daloradius-container
```

## Environment variables

### MYSQL_USER
standard value: *radius*
### MYSQL_PASSWORD
standard value: *dalodbpass*
### MYSQL_HOST
standard value: *localhost*
### MYSQL_PORT
standard value: *3306*
### MYSQL_DATABASE
standard value: *radius*
### TZ
standard value: *Europe/Berlin* - [see List of tz time zones](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)

