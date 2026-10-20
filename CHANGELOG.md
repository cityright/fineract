## [Unreleased]

Changes intended for the next release will be listed here.

- Adds `bin/smoke-test` (`rake smoke`) and a CI job that builds, installs, and
  loads the gem from a temporary gem home.
- Removes pre-1.0 `Fineract::Api::*` endpoint classes and RSpec files that were
  reintroduced after the 1.0 rewrite; they were not loadable and were packaged
  in the gem.

### Notable changes

- Documents the runtime dependency tree: Zeitwerk is a transitive dependency of
  the dry-rb gems and is not used by this gem for autoloading.

## [1.0.0] - 2026-09-15

The first stable, resource-oriented release.

- Targets the Apache Fineract `1.15.0` API contract.
- Adds explicit configuration, tenant headers, Basic, pre-encoded Basic, Bearer,
  and custom authentication strategies.
- Adds typed `Success`/`Failure` results, structured API errors, validation,
  serialization, transport errors, retries, multipart uploads, and binary
  downloads.
- Replaces the pre-1.0 Flexirest endpoint wrappers with the public resource API
  exposed by `Fineract::Client`.
- Publishes RBS signatures for the supported public API.

The OpenAPI snapshot and its checksum are checked in under `specifications/`.
See `specifications/README.md` for the refresh procedure.

## [0.1.0] - 2022-05-30

- Initial release
