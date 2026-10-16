[![iOS](https://img.shields.io/badge/iOS-Swift-7F77DD?style=flat)](https://developer.apple.com/ios/) [![Swift](https://img.shields.io/badge/Swift-6.0-1D9E75?logo=swift&logoColor=white&style=flat)](https://swift.org) [![CI](https://img.shields.io/github/actions/workflow/status/Syzygy-Hub/syzygy-example-ios/ci.yml?label=ci&style=flat)](https://github.com/Syzygy-Hub/syzygy-example-ios/actions/workflows/ci.yml) [![Version](https://img.shields.io/badge/version-1.0.0-D85A30?style=flat)](https://github.com/Syzygy-Hub/syzygy-example-ios/releases) [![License](https://img.shields.io/badge/License-MIT-green?style=flat)](LICENSE)

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/Syzygy-Hub/.github/main/brand/assets/banners/syzygy-banner-dark-1200.png">
  <img src="https://raw.githubusercontent.com/Syzygy-Hub/.github/main/brand/assets/banners/syzygy-banner-light-1200.png" alt="Syzygy" width="600">
</picture>

# syzygy-example-ios

An iOS example app that composes all five Syzygy layers and Base through one Core DI Container, with a demo login.

> This is an example application. It is **not published** to any package registry. Its only release artefact is a GitHub Release.

## Purpose

This example shows how to compose the Syzygy layers in a SwiftUI app: one DI container, one navigation stack and a demo login that lets a reader reach every screen without a backend. It is a reference for wiring Foundation, Core, Services, AI and UI together on iOS.

## Layers demonstrated

| Layer | Where it is shown | Status |
|---|---|---|
| Foundation | Features screen: `SyzygyID<T>.generate()` | Implemented |
| UI | Features screen: `PrimaryButton`, `CardView`, `ProgressBar`. Theme: `SyzygyThemeProvider` | Implemented |
| Core | Features screen: `ConfigRegistry.get(ConfigKey)`, `InMemoryFeatureFlagProvider.value(for:)`. Container: `AppDependencies.swift` | Implemented |
| Services | Features screen: `UserDefaultsStorageProvider.set` / `getOrThrow`, `StorageServiceError`. Network and auth providers registered in `AppDependencies.swift` | Implemented |
| AI | Features screen: `LLMProvider.complete`, `LLMRequest`, `LLMResponse`, `AIError`, with an offline provider in the app | Implemented |
| Base | Composition root in `AppDependencies.swift` and navigation in `SyzygyExampleApp.swift` | Implemented |

## Example screens

Login, Home and Features share one `NavigationStack`.

- **Login** signs in with the demo account (see Demo login). Wrong credentials show an error.
- **Home** shows the signed-in user's email, with **Open Features** and **Log out**.
- **Features** demonstrates each layer with public APIs only and no API keys. The AI demo uses the offline provider at `SyzygyExample/Features/Features/Data/OfflineLLMProvider.swift`.
- **Log out** clears the session and returns to Login.

## Demo login

This example is not connected to a backend, so it signs in with an offline demo account by default.

| Field | Value |
|---|---|
| Email | `demo@syzygy.example` |
| Password | `demo-password` |

These are demo values only, not secrets. The flag is `AppDependencies.useDemoLogin` in `SyzygyExample/App/AppDependencies.swift`. Its default is `true`, which selects the demo login.

## Not included

- A backend. Login uses the demo account only. Registration, token refresh and real API calls are not implemented.
- A production AI provider. The AI demo answers from the offline provider in the app.
- UI tests. This release runs only unit tests.

## Requirements

- iOS 26.5 or later, the deployment target in `SyzygyExample.xcodeproj`
- Swift 6.0 or later
- Xcode 16 or later

## How to run

1. Clone the repository:
   ```sh
   git clone https://github.com/Syzygy-Hub/syzygy-example-ios.git
   cd syzygy-example-ios
   ```
2. Preview the rename. This is a dry run and changes nothing:
   ```sh
   ./setup.sh
   ```
3. Apply the rename. It sets the app name to `Syzygy Example` and the identifier to `com.syzygyhub.example`. Commit your changes before this step:
   ```sh
   ./setup.sh --apply
   ```
4. Open `SyzygyExample.xcodeproj` in Xcode. The five Syzygy packages are already referenced at exactly 3.0.0.
5. Run the `SyzygyExample` scheme on an iOS Simulator.
6. Run the unit tests:
   ```sh
   xcodebuild -project SyzygyExample.xcodeproj -scheme SyzygyExample -destination 'platform=iOS Simulator,name=iPhone 18 Pro' -only-testing:SyzygyExampleTests test
   ```

## Library compatibility

This release is built against Syzygy 3.0.0. The five layers are pinned to exactly 3.0.0 in `SyzygyExample.xcodeproj`. The `depends_on` constraints in `syzygy.yml` are `>=3.0.0`. The compatibility table is in [example-apps-standard.md](https://github.com/Syzygy-Hub/.github/blob/main/engineering/standards/example-apps-standard.md#4-compatibility-table).

## Versioning and release

This example versions independently of the Syzygy libraries. Releases are tagged with bare strict semver, for example `1.0.0`, with no `v` prefix. Each tag creates a GitHub Release from the matching CHANGELOG section. Nothing is published to a registry.

## Contributing

Follow the [Syzygy contribution guide](https://github.com/Syzygy-Hub/.github/blob/main/CONTRIBUTING.md). Open a pull request against `main`.

## Security

Report security issues through the [Syzygy security policy](https://github.com/Syzygy-Hub/.github/blob/main/SECURITY.md).

## License

MIT. Copyright (c) 2026 Ayush Kumar Sethi. See [LICENSE](LICENSE).
