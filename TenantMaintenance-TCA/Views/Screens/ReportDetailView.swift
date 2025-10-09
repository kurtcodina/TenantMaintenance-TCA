//
//  ReportDetailView.swift
//  TenantMaintenance-TCA
//
//  Created by codina on 10/5/25.
//

import SwiftUI
import ComposableArchitecture

struct ReportDetailView: View {

    let store: StoreOf<ReportDetail>

    let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "dd MMM yyyy"
        return f
    }()

    var body: some View {
        EmptyView()
        WithViewStore(store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        LabeledContent {
                            Text(dateFormatter.string(from: viewStore.state.report.createdAt))
                                .foregroundColor(.primary)
                        } label: {
                            Text("Creation date")
                                .foregroundColor(.secondary)
                        }
                        LabeledContent {
                            Text(viewStore.state.report.status.rawValue)
                                .foregroundColor(viewStore.state.report.status.color)
                        } label: {
                            Text("Status")
                                .foregroundColor(.secondary)
                        }
                        .onTapGesture {
                            print("tapped resolved")
                            viewStore.send(.statusTapped)
                        }
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemGroupedBackground))
                    .cornerRadius(10)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Title")
                            .font(.headline)
                        Text(viewStore.state.report.title)
                            .font(.body)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color(UIColor.secondarySystemGroupedBackground))
                            .cornerRadius(10)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    ReportDetailDescriptionView(report: viewStore.report)
                    ReportDetailPhotosView(report:viewStore.report)

                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            .scrollContentBackground(.hidden)
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("Report Details")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        store.send(.backTapped)
                    } label: {
                        Image(systemName: "arrow.left")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "flag")
                    }
                }
            }
        }
        
    }
}
