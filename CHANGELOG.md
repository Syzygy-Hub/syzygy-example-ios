# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [1.0.0] - 2026-10-16

### Added
- Home screen showing the signed-in state and user, with buttons to open Features and to log out
- Features screen demonstrating each layer with public APIs and no keys: Foundation (`SyzygyID`), Core (`ConfigRegistry`, `FeatureFlag`), Services (`UserDefaultsStorageProvider`, `StorageServiceError`), AI (`LLMProvider` with an offline provider written in the app) and UI (`PrimaryButton`, `CardView`, `ProgressBar`)
- Offline `LLMProvider` implementation in the app (`OfflineLLMProvider`)

### Changed
- Syzygy packages pinned to exactly 3.0.0 (Foundation, Core, Services, AI, UI)
- App renamed from SyzygyBase to Syzygy Example (bundle ID `com.syzygyhub.example`, project `SyzygyExample`)

## [3.0.0] - 2026-10-06

### Added
- All 5 Syzygy layers declared as dependencies at v3.0.0 (Foundation, Core, Services, AI, UI)
- Core DI Container wiring for Logger, NetworkClient, AuthProvider, StorageProvider, StateStore, EventBus, Router, Scheduler, FeatureFlagProvider, ConfigRegistry, AppLifecycleTracker
- SyzygyThemeProvider wrapping the app root
- Hub reusable CI workflow (ios-ci.yml@main)
- SwiftLint configuration
- syzygy.yml layer manifest

### Changed
- Bundle ID renamed from com.aks.Boilerplate to com.syzygyhub.base
- App name renamed from Boilerplate to SyzygyBase
- Version set to 3.0.0

### Removed
- Inline CI workflow (ios.yml) replaced by Hub reusable workflow
- Local shadow copies of NetworkClient, APIError, KeychainManager, AppColors, AppFonts
- Hand-rolled DI singleton replaced by Core DI Container
