//
//  SwiftUIDemoAppApp.swift
//  SwiftUIDemoApp
//
//  Created by Viktor Prikolota on 18.03.2024.
//

import SwiftUI

@main
struct SwiftUIDemoAppApp: App {
    var body: some Scene {
        WindowGroup {
            AuthorizationView(viewModel: AuthorizationViewModel())
        }
    }
}
