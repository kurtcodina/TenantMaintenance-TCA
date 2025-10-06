//
//  MaintenanceView.swift
//  TenantMaintenance-TCA
//
//  Created by codina on 10/5/25.
//

import SwiftUI
import ComposableArchitecture

struct MaintenanceView: View {
    @Bindable var store: StoreOf<AppFeature>

    let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "HH:mm - dd MMMM yyyy"
        return f
    }()

    var body: some View {
        ScrollView {
            Text("Requests submitted for your Landord to review.")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            LazyVStack(spacing: 12) {
                ForEachStore(store.scope(state: \.reports, action: \.report)) { reportStore in
                    NavigationLink {
                        ReportView(store: reportStore)
                            .toolbarRole(.editor)
                    } label: {
                        WithViewStore(reportStore, observe: { $0 }) { viewStore in
                            //                ForEach(store.reports) { report in
                            VStack(alignment: .leading) {
                                Text(viewStore.state.title)
                                    .font(.headline)
                                    .foregroundStyle(Color.primary)

                                HStack {
                                    Text(dateFormatter.string(from: viewStore.state.createdAt))
                                        .font(.subheadline)
                                        .foregroundStyle(Color.secondary)
                                    Spacer()
                                    Text(viewStore.state.status.rawValue)
                                        .font(.subheadline)
                                        .foregroundStyle(viewStore.state.status.color)
                                }
                            }
                            .padding()
                            .background(Color(UIColor.secondarySystemGroupedBackground))
                            .cornerRadius(10)
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Maintenance")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        store.send(.addReportButtonTapped)
                    } label: {
                        Label("New", systemImage: "plus")
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .background(Capsule().fill(Color.accentColor))
                            .foregroundColor(.white)
                            .labelStyle(.titleAndIcon)
                    }
                    .buttonStyle(.plain)
                    .sheet(item: $store.scope(state: \.newReport, action: \.newReport)) { newReportStore in
                        NewReportView(store: newReportStore, onSave: {
                            store.send(.saveReport)
                        })
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color(UIColor.systemGroupedBackground))
    }
}

#Preview {
    MaintenanceView(
        store: Store(initialState: AppFeature.State()) {
            AppFeature()
        }
    )
}
