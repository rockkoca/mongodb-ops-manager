# MongoDB Ops Manager Docker image

Produces a simple docker image to run MongoDB Ops Manager. Please consult the [MongoDB documentation](https://docs.opsmanager.mongodb.com/current/) for the latest information about Ops Manager.

NOTE: the resulting container does not provide a MongoDB database for Ops Manager. A minimum
of one MongoDB instance will be required, though a replica set is recommended. More advanced
deployments are possible. Please consult [documentation](#official-documentation) for details.

### Versions

I have to manually get the versions from https://www.mongodb.com/try/download/ops-manager

These versions are managed in [.travis.yml](.travis.yml)

### Github Repo

https://github.com/ubuntu-docker/mongodb-ops-manager

### Daily Travis CI build logs

https://travis-ci.org/ubuntu-docker/mongodb-ops-manager

### Docker image tags

https://hub.docker.com/r/ubuntulinux/mongo-opsmgr/tags/

## Getting Started

* Make sure you have installed [docker-compose](https://docs.docker.com/compose/install/)
* Make sure no application is running on port 8080 in your host computer

Then you can run Mongo Ops Manager with below commands

```bash
cd ops-manager
docker-compose up -d

# check logs
docker-compose logs -f mongo
docker-compose logs -f mongo-opsmgr
```

It takes more than 5 to 10 minutes to pull the image (1.6GB+) and start the services. Until you see below logs, that means Mongo Ops Manager is ready

```
mongo-opsmgr_1  | Migrate Ops Manager data
mongo-opsmgr_1  |    Running migrations...[  OK  ]
mongo-opsmgr_1  | Starting Ops Manager server
```

Now you can access it via http://localhost:8080

You need register a new user and submit the ops manager url with your host's IP.

http://<your_host_ip>:8080

### run with new versions

update file [ops-manager/.env](ops-manager/.env) with the mongo version and ops manager version.

### Configuration

Provide your own properties file with a custom config

remove comments from below line in `docker-compose.yaml`
```bash
volumes:
  - custom-app.properties:/opt/mongodb/mms/conf/conf-mms.properties 
```

### Building the Image

```bash
docker build ops-manager/
```

### error and fix

When you saw below error logs, it is most because you re-use the mongodb container. delete and try again.

```
$ docker-compose logs -f 
tput: No value for $TERM and no -T specified
Generating new Ops Manager private key...
Starting pre-flight checks
The gen.key file at /etc/mongodb-mms/gen.key does not match the gen.key already used for this Ops Manager installation. The key file for this Ops Manager server must be copied from another server.
Pre-flight checks failed. Service can not start.
Preflight check failed.
```

Mostly, it is  because you re-use the mongodb container with new mongo ops manager. Delete all of them and try again.

```
docker-compose down
docker-compose up -d
```

### Official Documentation
- [Ops Manager Overview](https://docs.opsmanager.mongodb.com/current/application/)
- [Installation Guide](https://docs.opsmanager.mongodb.com/current/installation/)
- [Hardware and Software Requirements](https://docs.opsmanager.mongodb.com/current/core/requirements/)
- [Advanced Configuration Options](https://docs.opsmanager.mongodb.com/current/tutorial/nav/advanced-deployments/)
