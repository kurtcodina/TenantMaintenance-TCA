//
//  ContentView.swift
//  TenantMaintenance-TCA
//
//  Created by codina on 10/5/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            MaintenanceView(
                store: .init(
                    initialState: AppFeature.State(),
                    reducer: {
                        AppFeature()
                    }
                )
            )
        }
    }
}

#Preview {
    ContentView()
}
