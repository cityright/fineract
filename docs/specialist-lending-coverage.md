# Specialist lending coverage

The client targets the pinned Apache Fineract 1.15.0 OpenAPI snapshot.

Idiomatic resources are available for loan collateral, loan guarantors, post-dated checks, client collateral, collateral management, credit bureau/report workflows, GLIM, GSIM, external asset ownership, working-capital loan products, and working-capital loan lifecycle operations.

The complete endpoint inventory is generated in `reports/endpoint-coverage.json`. Operations not given a dedicated helper remain available through `Client#call` using their catalog operation ID. This is intentional for endpoints whose contract is internal (`/internal/...`), duplicated by ID and external ID, upload-only, or whose command payload is an unstructured object/string in OpenAPI. They are not silently omitted.
