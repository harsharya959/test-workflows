## Release Notes & Deployment Tracking

To maintain clear and consistent release information for **stage** and **production** deployments, this repository uses two files:

- `releases.md`
- `changelog.md`

Both files are updated after each deployment to stage or production.

---

### `releases.md`

**Purpose**

`releases.md` is the single source of truth for:

- Which **tag version** is deployed
- To which **tenant**
- On which **environment** (stage/production)
- At what **time**

**How It’s Updated**

`releases.md` is updated automatically when:

- A **pre-release** or **release** is drafted via the GitHub UI, or  
- A manual deployment is triggered via the `trigger-tenant-deployment` workflow.

A final job in the relevant workflow updates the `releases.md` file.

**Structure**

- The file contains **separate tables per tenant**.
- Each table entry includes:
  - Deployed tag version
  - Target environment (stage/prod)
  - Deployment time

This provides an at-a-glance view of the current and historical deployment state per tenant.

---

### `changelog.md`

**Purpose**

`changelog.md` contains the **release notes / changelog details** for **manually triggered** deployments to stage and production.

**How It’s Updated**

- When a manual deployment to **stage** or **production** is triggered, a workflow step appends a new entry to `changelog.md`.

**Content of Each Entry**

Each changelog entry includes:

- **Tag version** deployed
- **Tenant**
- **Environment** (stage/production)
- **Deployment time**
- **Diff** between:
  - Previously deployed tag, and
  - Currently deployed tag
- **List of all commits** included in that diff

This provides a detailed, auditable history of the changes included in each deployment.
