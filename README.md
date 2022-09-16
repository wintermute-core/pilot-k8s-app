# K8S deployable app

Go application packaged and deployable in K8S

App logic:
 * Insert test data in DB by request over HTTP
 * List inserted data as response to HTTP request
 * Report health on separated endpoint
 * Return "index" page

Tech stack:
 * Go 1.18 (Pq, Fiber)
 * Postgres 14
 * Docker
 * Kubernetes(GKE)
 * Helm
 * Terraform
 

## Development

Application is located in `app` directory.

Local database deployment:
```
docker run -p 5432:5432 -it -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=123456 postgres:14.5-bullseye
```
Local build:
```
make build
```
Local run:
```
make run-local
```

### Requests

Health check
```
curl -v http://127.0.0.1:8000/health
```

Root page loading
```
curl -v http://127.0.0.1:8000/
```

Query to insert test data
```
curl -v http://127.0.0.1:8000/select
```

## Deployment

Infrastructure deployment files are located in `infra` directory.

