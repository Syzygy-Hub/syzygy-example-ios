//
//  SyzygyExampleApp.swift
//  SyzygyExample
//

import SwiftUI
import SyzygyAI
import syzygy_ui_ios

@main
struct SyzygyExampleApp: App {
    var body: some Scene {
        WindowGroup {
            SyzygyThemeProvider(theme: .default) { _ in
                LoginView(viewModel: AppDependencies.makeLoginViewModel())
            }
        }
    }
}
