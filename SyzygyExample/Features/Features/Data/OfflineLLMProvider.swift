//
//  OfflineLLMProvider.swift
//  SyzygyExample
//

import Foundation
import SyzygyAI

/// An offline `LLMProvider` for the example. It answers locally, needs no API key
/// and makes no network call. Replace it with a real provider to talk to a model.
nonisolated struct OfflineLLMProvider: LLMProvider {

    let providerName = "offline"

    func complete(_ request: LLMRequest) async throws -> LLMResponse {
        guard let prompt = request.messages.last(where: { $0.role == .user })?.content,
              !prompt.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw AIError.invalidRequest("The prompt is empty.")
        }
        return LLMResponse(
            content: "Offline reply to: \(prompt)",
            finishReason: .stop,
            providerName: providerName,
            modelName: request.model
        )
    }

    func stream(_ request: LLMRequest) -> AsyncThrowingStream<LLMChunk, Error> {
        AsyncThrowingStream { continuation in
            Task {
                do {
                    let response = try await complete(request)
                    continuation.yield(LLMChunk(
                        content: response.content,
                        providerName: providerName,
                        modelName: request.model
                    ))
                    continuation.yield(LLMChunk(finishReason: .stop, providerName: providerName))
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
}
