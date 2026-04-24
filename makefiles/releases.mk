# ─── release notes ──────────────────────────────────
RELEASES_FILE := RELEASES.md
DATE          := $(shell date -u +"%Y-%m-%d %H:%M UTC")
DEPLOYED_BY   ?= $(error DEPLOYED_BY is required)
ENV           ?= $(error ENV is required)
TAG           ?= $(error TAG is required)
TENANT        ?=

VALID_TENANTS := ingka inter
TENANTS_TO_UPDATE := $(if $(strip $(TENANT)),$(TENANT),$(VALID_TENANTS))
COMMIT_TENANT_SUMMARY := $(foreach t,$(TENANTS_TO_UPDATE),[$(t)=$(TAG)])

ifneq ($(strip $(TENANT)),)
	ifeq ($(filter $(TENANT),$(VALID_TENANTS)),)
		$(error Invalid TENANT value: $(TENANT). Must be one of: $(VALID_TENANTS))
	endif
endif

deploy: update-releases
	@git add $(RELEASES_FILE)
	@git commit -m "chore: update release notes [env=$(ENV)] $(COMMIT_TENANT_SUMMARY)"
	@git push

update-releases:
	@if ! grep -q "^## Tenant Deployments$$" $(RELEASES_FILE) 2>/dev/null; then \
		printf '## Tenant Deployments\n' >> $(RELEASES_FILE); \
	fi
	@for tenant in $(TENANTS_TO_UPDATE); do \
		$(MAKE) ensure-tenant-table TENANT=$$tenant; \
		$(MAKE) update-row TENANT=$$tenant TAG=$(TAG); \
	done
	@echo "Updated $(RELEASES_FILE)"

# Create one table per tenant with stage/prod rows (if missing).
ensure-tenant-table:
	@if ! grep -q "^### $(TENANT)$$" $(RELEASES_FILE) 2>/dev/null; then \
		printf '\n### %s\n\n| Environment | Version | Deployed By | Deployed At |\n|-------------|---------|-------------|-------------|\n| stage | - | - | - |\n| prod | - | - | - |\n' "$(TENANT)" >> $(RELEASES_FILE); \
	fi

# Update only the current ENV row inside the tenant table.
update-row:
	@row="| $(ENV) | $(TAG) | $(DEPLOYED_BY) | $(DATE) |"; \
	awk -v tenant="$(TENANT)" -v env="$(ENV)" -v row="$$row" '$$0 == "### " tenant { in_section = 1; print; next } in_section && /^### / { in_section = 0 } in_section && $$0 ~ ("^\\|[[:space:]]*" env "[[:space:]]*\\|") { print row; replaced = 1; next } { print } END { if (!replaced) print row }' $(RELEASES_FILE) > $(RELEASES_FILE).tmp && mv $(RELEASES_FILE).tmp $(RELEASES_FILE)

