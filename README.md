# nexus-ds-event-consumer
Solace Consumer


### Export go private
export GOPRIVATE=github.com/ingka-group-digital/*

### To run the docker image locally: 
docker run -it --rm -e ENVIRONMENT=dev nexus-ds-event-consumer bin/ash

### To login and ispect the docker image:
docker run -it --rm -e ENVIRONMENT=dev --entrypoint /bin/ash nexus-ds-event-consumer

### To build the proto golang code:
protoc --go_out=paths=source_relative:. --go-grpc_out=paths=source_relative:. proto/dsm_promise_bt.proto


## Load test with K6
 - ### Install KS:
   ```shell
    brew install k6
    ```
 - ### Install KS:
   ```shell
   k6 run load_test/load_test.js
    ```

## Release Notes & Deployment Tracking

We use two files to track deployments:

- **`releases.md`** – Single source of truth for what **tag** is deployed to which **tenant**, on which **environment**, and **when**.  
  - Updated automatically when a GitHub pre-release/release is created or the `trigger-tenant-deployment` workflow runs.
  - Organized as tables per tenant.

- **`changelog.md`** – Detailed notes for **manually triggered** stage/prod deployments.  
  - Each entry includes: tag, tenant, environment, deployment time, diff from the previous tag, and the list of commits.
  - Keeps records for last 50 manual deployments.
