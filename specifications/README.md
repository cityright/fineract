# Apache Fineract OpenAPI snapshots

`fineract-1.15.0.json` is the authoritative, generated API contract for this
client's initial compatibility target. It was generated from the Apache
Fineract `1.15.0` tag with the upstream `:fineract-provider:resolve` task.

The legacy Mifos API documentation at
<https://demo.mifos.io/api-docs/apiLive.htm> is advisory only. It can help
explain an operation or identify historical behavior, but it does not override
the pinned OpenAPI snapshot.

## Verify the committed snapshot

Verification is offline and does not contact Fineract or any other network
service:

```sh
bin/verify-openapi
```

The command checks the SHA-256 sidecar and parses the snapshot as JSON.

## Refresh for a new upstream release

Run these steps from a clean checkout, replacing `VERSION` and `TAG` as
needed:

```sh
VERSION=1.15.0
TAG=1.15.0
git clone --depth 1 --branch "$TAG" https://github.com/apache/fineract.git /tmp/fineract-openapi-$VERSION
cd /tmp/fineract-openapi-$VERSION
./gradlew :fineract-provider:resolve --no-daemon
cp fineract-provider/build/resources/main/static/fineract.json \
  /path/to/fineract/specifications/fineract-$VERSION.json
cd /path/to/fineract
sha256sum specifications/fineract-$VERSION.json \
  > specifications/fineract-$VERSION.json.sha256
bin/verify-openapi specifications/fineract-$VERSION.json
```

Record the exact upstream tag/source URL, Fineract version, retrieval date,
generation command, and checksum in the matching `.metadata.yml` file. Review
the OpenAPI diff and update compatibility tests before changing the default
target. Normal tests and gem runtime must consume only the checked-in file;
they must never run the refresh command or fetch the network.
