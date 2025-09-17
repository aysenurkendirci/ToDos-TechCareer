//
//  ToDosAppApp.swift
//  ToDosApp
//
//  Created by Kasım on 4.09.2025.
//

import SwiftUI

@main
struct ToDosAppApp: App {
    var body: some Scene {
        WindowGroup {
            MainScreen().environment(\.font, .custom("oswald", size: 18))
        }
    }
}
