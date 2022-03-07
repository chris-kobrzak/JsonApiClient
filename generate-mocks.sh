#!/usr/bin/env bash

set -eu

cd "$(dirname "$0")"

swift package describe --type json > project.json

.build/checkouts/mockingbird/mockingbird generate --project project.json \
  --output-dir Tests/JwtApiClientTests/Mocks \
  --testbundle JwtApiClientTests \
  --targets JwtApiClient

exit 0
