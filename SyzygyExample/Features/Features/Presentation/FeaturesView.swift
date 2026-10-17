//
//  FeaturesView.swift
//  SyzygyExample
//

import SwiftUI
import SyzygyFoundation
import SyzygyCore
import SyzygyServices
import SyzygyAI
import syzygy_ui_ios

/// A small demonstration of each Syzygy layer, using only public APIs and no keys.
struct FeaturesView: View {

    private struct DemoItem {}

    @State private var foundationID = ""
    @State private var coreGreeting = ""
    @State private var coreFlagEnabled = false
    @State private var servicesStatus = ""
    @State private var aiReply = ""
    @State private var aiStatus = ""
    @State private var progress = 0.0

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                layerCard(title: "Foundation", detail: "SyzygyID<DemoItem>.generate()", result: foundationID)
                layerCard(
                    title: "Core",
                    detail: "ConfigRegistry.get and FeatureFlag with a default",
                    result: "\(coreGreeting) | flag: \(coreFlagEnabled ? "on" : "off")"
                )
                layerCard(
                    title: "Services",
                    detail: "UserDefaultsStorageProvider.getOrThrow",
                    result: servicesStatus
                )
                layerCard(
                    title: "AI",
                    detail: "LLMProvider.complete with the offline provider",
                    result: aiStatus.isEmpty ? aiReply : "\(aiReply) \(aiStatus)"
                )
                CardView {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("UI").font(AppFonts.title)
                        Text("PrimaryButton, CardView and ProgressBar from syzygy-ui-ios")
                            .font(AppFonts.caption)
                            .foregroundStyle(AppColors.secondaryText)
                        ProgressBar(progress: progress)
                        PrimaryButton("Run the layer demos") {
                            Task { await runDemos() }
                        }
                    }
                    .padding()
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
        }
        .background(AppColors.background)
        .navigationTitle("Features")
        .navigationBarTitleDisplayMode(.inline)
        .task { await runDemos() }
    }

    private func layerCard(title: String, detail: String, result: String) -> some View {
        CardView {
            VStack(alignment: .leading, spacing: 8) {
                Text(title).font(AppFonts.title)
                Text(detail)
                    .font(AppFonts.caption)
                    .foregroundStyle(AppColors.secondaryText)
                Text(result.isEmpty ? "Not run yet" : result)
                    .font(AppFonts.body)
                    .foregroundStyle(AppColors.text)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
    }

    @MainActor
    private func runDemos() async {
        progress = 0.0

        // Foundation: a typed identifier.
        foundationID = SyzygyID<DemoItem>.generate().description
        progress = 0.2

        // Core: a config value and a feature flag, each with a default.
        do {
            let registry = try await AppDependencies.container.resolve(ConfigRegistry.self)
            coreGreeting = registry.get(ConfigKey(name: "example.greeting", defaultValue: "Hello from Core"))
            let flags = try await AppDependencies.container.resolve(InMemoryFeatureFlagProvider.self)
            coreFlagEnabled = flags.value(
                for: FeatureFlag(key: "example.showAIDemo", defaultValue: true, description: "Shows the AI demo")
            )
        } catch {
            coreGreeting = "Core registry unavailable: \(error.localizedDescription)"
        }
        progress = 0.4

        // Services: storage write and read, handling StorageServiceError.
        do {
            let storage = try await AppDependencies.container.resolve(UserDefaultsStorageProvider.self)
            let key = StorageKey<String>(identifier: "example.lastRun")
            storage.set(Date().formatted(date: .abbreviated, time: .standard), for: key)
            let stored = try storage.getOrThrow(key)
            servicesStatus = "Stored: \(stored ?? "nothing")"
        } catch let error as StorageServiceError {
            servicesStatus = "Storage error: \(error.message)"
        } catch {
            servicesStatus = "Storage unavailable: \(error.localizedDescription)"
        }
        progress = 0.6

        // AI: one call through the LLMProvider contract with the offline provider.
        let provider: any LLMProvider = OfflineLLMProvider()
        let request = LLMRequest(
            messages: [LLMMessage(role: .user, content: "Hello Syzygy")],
            model: "offline-demo"
        )
        do {
            let response = try await provider.complete(request)
            aiReply = response.content
            aiStatus = "(\(response.providerName ?? "unknown"))"
        } catch let error as AIError {
            aiReply = "AI error"
            aiStatus = "\(error)"
        } catch {
            aiReply = "AI unavailable: \(error.localizedDescription)"
            aiStatus = ""
        }
        progress = 1.0
    }
}

#Preview {
    NavigationStack {
        FeaturesView()
    }
}
