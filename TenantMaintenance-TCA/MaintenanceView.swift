//
//  MaintenanceView.swift
//  TenantMaintenance-TCA
//
//  Created by codina on 10/5/25.
//

import SwiftUI
import ComposableArchitecture

struct MaintenanceView: View {
    @Bindable var store: StoreOf<MaintenanceReports>

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
                ForEach(store.reports) { report in
                    VStack(alignment: .leading) {
                        Text(report.title.isEmpty ? "Untitled" : report.title)
                            .font(.headline)
                        HStack {
                            Text(dateFormatter.string(from: Date()))
                                .font(.subheadline)
                            Spacer()
                            Text("Pending")
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Maintenance")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        store.send(.addReportButtonTapped)
                    } label: {
                        Label("New", systemImage: "plus")
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .background(Capsule().fill(Color(red: 90/255, green: 69/255, blue: 254/255)))
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
    }
}

#Preview {
    MaintenanceView(
        store: Store(initialState: MaintenanceReports.State()) {
            MaintenanceReports()
        }
    )
}
