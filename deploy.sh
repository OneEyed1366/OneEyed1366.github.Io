#!/usr/bin/env sh

set -e
npm run build
cd dist
git push -f git@github.com:OneEyed1366/OneEyed1366.github.io.git master
cd -