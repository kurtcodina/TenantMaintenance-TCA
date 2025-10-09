//
//  AppView.swift
//  TenantMaintenance-TCA
//
//  Created by codina on 10/9/25.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {
    @Bindable var store: StoreOf<AppFeature>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            ReportsListView(store: store.scope(state: \.reportsList, action: \.reportsList))
        } destination: { store in
            switch store.case {
            case let .report(store):
                ReportDetailView(store: store)
            }
        }
    }
}
