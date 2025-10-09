//
//  ReportsListView.swift
//  TenantMaintenance-TCA
//
//  Created by codina on 10/5/25.
//

import SwiftUI
import ComposableArchitecture

struct ReportsListView: View {
    @Bindable var store: StoreOf<ReportsList>
    
    var body: some View {
        ScrollView(.vertical) {
            Text("Requests submitted for your Landord to review.")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            LazyVStack(spacing: 12) {
                WithViewStore(store, observe: { $0 }) { viewStore in
                    ForEach(viewStore.reports) { report in
                        NavigationLink(state: AppFeature.Path.State.report(ReportDetail.State(report: report))) {
                            ReportSummaryView(report: report)
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
                        PurpleAddButton()
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color(UIColor.systemGroupedBackground))
        .sheet(item: $store.scope(state: \.destination?.add, action: \.destination.add)) { newReportStore in
            NavigationStack {
                NewReportFormView(store: newReportStore)
                    .navigationTitle("New Report")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                store.send(.cancelNewReportButtonTapped)
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                store.send(.saveNewReportButtonTapped)
                            }
                        }
                    }
            }
        }
    }
}
