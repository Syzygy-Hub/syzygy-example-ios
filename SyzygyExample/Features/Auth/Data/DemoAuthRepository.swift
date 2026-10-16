//
//  DemoAuthRepository.swift
//  SyzygyExample
//

import Foundation

/// Offline login for an example app that is not connected to a backend.
///
/// Accepts only ``DemoAuthRepository/email`` and ``DemoAuthRepository/password``.
/// Those are demo values only, not secrets, and they grant access to nothing
/// but this example app. The session lives in memory and makes no network
/// calls. Selected in `AppDependencies.makeLoginViewModel()` by
/// `AppDependencies.useDemoLogin`.
actor DemoAuthRepository: AuthRepositoryProtocol {

    nonisolated static let email = "demo@syzygy.example"
    nonisolated static let password = "demo-password"

    private var currentUser: User?

    func login(email: String, password: String) async throws -> User {
        let normalizedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let matches = normalizedEmail == Self.email && password == Self.password
        guard matches else {
            throw DemoAuthError.invalidCredentials
        }
        let user = User(id: "demo-user", email: Self.email, name: "Demo User")
        currentUser = user
        return user
    }

    func logout() async throws {
        currentUser = nil
    }

    func getCurrentUser() async throws -> User? {
        currentUser
    }

    func isAuthenticated() async -> Bool {
        currentUser != nil
    }
}

/// Failure raised by ``DemoAuthRepository`` when the demo credentials do not match.
enum DemoAuthError: LocalizedError, Sendable, Equatable {
    case invalidCredentials

    var errorDescription: String? {
        "Invalid email or password."
    }
}
