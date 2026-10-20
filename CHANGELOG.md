## [Unreleased]

Changes intended for the next release will be listed here.

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
