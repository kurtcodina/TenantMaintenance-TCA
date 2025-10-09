//
//  TenantMaintenance_TCAApp.swift
//  TenantMaintenance-TCA
//
//  Created by codina on 10/5/25.
//

import SwiftUI
import ComposableArchitecture

@main
struct TenantMaintenance_TCAApp: App {
    
    static let store = Store(initialState: AppFeature.State()) {
        AppFeature()
            ._printChanges()
    } withDependencies: {
        if ProcessInfo.processInfo.environment["UITesting"] == "true" {
            $0.defaultFileStorage = .inMemory
        }
    }
    
    var body: some Scene {
        WindowGroup {
            AppView(store: Self.store)
        }
    }
}
