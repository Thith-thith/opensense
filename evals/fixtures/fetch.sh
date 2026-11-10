#!/usr/bin/env bash
# Stage the eval fixtures in .cache/ (idempotent).
set -euo pipefail
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SHA=e16c87f213a5ba5e45964e9b67c792105ec74d26
APP="$REPO/.cache/app"
EXPO="$REPO/.cache/expo"
mkdir -p "$REPO/.cache"

if [ ! -d "$APP/.git" ]; then
  rm -rf "$APP"
  git clone https://github.com/satnaing/shadcn-admin.git "$APP"
fi
if [ "$(git -C "$APP" rev-parse HEAD)" != "$SHA" ]; then
  git -C "$APP" fetch origin "$SHA" 2>/dev/null || git -C "$APP" fetch origin
  git -C "$APP" checkout --quiet --detach "$SHA"
fi
(cd "$APP" && pnpm install --frozen-lockfile)

if [ ! -f "$EXPO/package.json" ]; then
  rm -rf "$EXPO" "$REPO/.cache/expo-tmp"
  # "expo" is a reserved app name, so create under another name and rename
  (cd "$REPO/.cache" && CI=1 npx -y create-expo-app@5.0.0 expo-tmp --template blank-typescript --no-install </dev/null)
  mv "$REPO/.cache/expo-tmp" "$EXPO"
fi
(cd "$EXPO" && npm install --no-audit --no-fund && npx expo install react-dom react-native-web @expo/metro-runtime)
echo "fixtures ready: $APP $EXPO"
