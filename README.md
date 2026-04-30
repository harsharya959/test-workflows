## Release Notes & Deployment Tracking

We use two files to track deployments:

- **`releases.md`** – Single source of truth for what **tag** is deployed to which **tenant**, on which **environment**, and **when**.  
  - Updated automatically when a GitHub pre-release/release is created or the `trigger-tenant-deployment` workflow runs.
  - Organized as tables per tenant.

- **`changelog.md`** – Detailed notes for **manually triggered** stage/prod deployments.  
  - Each entry includes: tag, tenant, environment, deployment time, diff from the previous tag, and the list of commits.
  - Keeps records for last 50 manual deployments.
