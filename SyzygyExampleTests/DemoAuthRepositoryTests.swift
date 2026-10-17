import XCTest
@testable import SyzygyExample

@MainActor
final class DemoAuthRepositoryTests: XCTestCase {

    func testValidDemoLoginSignsIn() async throws {
        let repository = DemoAuthRepository()

        let user = try await repository.login(
            email: DemoAuthRepository.email,
            password: DemoAuthRepository.password
        )

        XCTAssertEqual(user.email, DemoAuthRepository.email)
        let signedIn = await repository.isAuthenticated()
        XCTAssertTrue(signedIn)
    }

    func testWrongPasswordIsRejectedAndStaysSignedOut() async {
        let repository = DemoAuthRepository()

        do {
            _ = try await repository.login(email: DemoAuthRepository.email, password: "not-the-password")
            XCTFail("Expected the wrong password to be rejected")
        } catch {
            XCTAssertEqual(error as? DemoAuthError, .invalidCredentials)
        }

        let signedIn = await repository.isAuthenticated()
        XCTAssertFalse(signedIn)
    }

    func testLogoutClearsTheDemoSession() async throws {
        let repository = DemoAuthRepository()
        _ = try await repository.login(
            email: DemoAuthRepository.email,
            password: DemoAuthRepository.password
        )

        try await repository.logout()

        let signedIn = await repository.isAuthenticated()
        XCTAssertFalse(signedIn)
        let currentUser = try await repository.getCurrentUser()
        XCTAssertNil(currentUser)
    }
}
