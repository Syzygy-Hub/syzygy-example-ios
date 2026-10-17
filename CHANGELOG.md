# Changelog

All notable changes to `syzygy-example-ios` are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.0.0] - 2026-10-18

### Added
- Release workflow `.github/workflows/release.yml` from the Hub's app release template. It fires on strict bare-semver tags and calls `app-release.yml@main`.
- Library compatibility table in the README.
- The demo login is documented as shipping in all build types, including release builds.

### Changed
- CI caller aligned with the Hub's iOS app CI template. Triggers are push-only with tags excluded, matching the libraries. Xcode version is left to the runner default because no installed Xcode path could be confirmed for the iOS 26.5 target.
- README rewritten to the v3.0.0 facts. The one-time rename steps are removed.
- `MARKETING_VERSION` set to 3.0.0. `CURRENT_PROJECT_VERSION` stays at 1.

## [1.0.0] - 2026-10-16

### Added
- Home screen showing the signed-in state and user, with buttons to open Features and to log out
- Features screen demonstrating each layer with public APIs and no keys: Foundation (`SyzygyID`), Core (`ConfigRegistry`, `FeatureFlag`), Services (`UserDefaultsStorageProvider`, `StorageServiceError`), AI (`LLMProvider` with an offline provider written in the app) and UI (`PrimaryButton`, `CardView`, `ProgressBar`)
- Offline `LLMProvider` implementation in the app (`OfflineLLMProvider`)

### Changed
- Syzygy packages pinned to exactly 3.0.0 (Foundation, Core, Services, AI, UI)
- App renamed from SyzygyBase to Syzygy Example (bundle ID `com.syzygyhub.example`, project `SyzygyExample`)

