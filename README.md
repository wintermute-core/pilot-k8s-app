# K8S deployable app

Go application packaged and deployable in K8S

App logic:
 * Insert test data in DB by request over HTTP
 * List inserted data as response to HTTP request
 * Report health on separated endpoint
 * Return "index" page

Tech stack:
 * Go 1.18 (Pq, Fiber)
 * Postgres 14+
 * Docker 20.04+
 * Kubernetes 1.22+ (GKE)
 * Helm 3+
 * Terraform 1.11+
 
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

Infrastructure deployment files are located in `infra` directory:
 * `gke` - terraform scripts to deploy GKE cluster
 * `postgres` - deployment of postgres in GKE

Infrastructure deployment steps:
 * deploy GKE
 * deploy Postgres
 * deploy App

To K8S application is deployed as a Helm chart located in `helm` directory, custom values used during deployment are located
in file `helm-values.yaml` deployment is automated through Gitlab CI or can be done through make command `deploy-k8s`.

Live deployment can be accessed through: ``
