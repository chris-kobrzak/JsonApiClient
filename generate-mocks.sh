#!/usr/bin/env bash

set -eu

cd "$(dirname "$0")"

swift package describe --type json > project.json

.build/checkouts/mockingbird/mockingbird generate --project project.json \
  --output-dir Sources/JwtApiClient/Mocks \
  --testbundle JwtApiClientTests \
  --targets JwtApiClient

exit 0
