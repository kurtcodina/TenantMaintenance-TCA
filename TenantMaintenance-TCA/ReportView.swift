//
//  ReportView.swift
//  TenantMaintenance-TCA
//
//  Created by codina on 10/5/25.
//

import SwiftUI
import ComposableArchitecture

struct ReportView: View {
    @Environment(\.dismiss) private var dismiss

    let store: StoreOf<TenantReport>

    let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "dd MMM yyyy"
        return f
    }()

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        LabeledContent {
                            Text(dateFormatter.string(from: viewStore.state.createdAt))
                                .foregroundColor(.primary)
                        } label: {
                            Text("Creation date")
                                .foregroundColor(.secondary)
                        }
                        LabeledContent {
                                Text(viewStore.state.status.rawValue)
                                    .foregroundColor(viewStore.state.status.color)
                        } label: {
                            Text("Status")
                                .foregroundColor(.secondary)
                        }
                        .onTapGesture {
                            print("tapped resolved")
                            viewStore.send(.resolved)
                        }
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemGroupedBackground))
                    .cornerRadius(10)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Title")
                            .font(.headline)
                        Text(viewStore.state.title)
                            .font(.body)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color(UIColor.secondarySystemGroupedBackground))
                            .cornerRadius(10)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    if !viewStore.state.description.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Description")
                                .font(.headline)
                            Text(viewStore.state.description)
                                .font(.body)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(Color(UIColor.secondarySystemGroupedBackground))
                                .cornerRadius(10)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    if !viewStore.state.photos.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Photos")
                                .font(.headline)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(viewStore.state.photos, id: \.self) { img in
                                        Image(uiImage: img)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 80, height: 80)
                                            .clipped()
                                            .cornerRadius(8)
                                    }
                                }
                                .padding()
                            }
                            .background(Color(UIColor.secondarySystemGroupedBackground))
                            .cornerRadius(10)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }

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
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // Flag action
                    } label: {
                        Image(systemName: "flag")
                    }
                }
            }
        }
        
    }
}

#Preview {
    ReportView(
        store: .init(
            initialState: TenantReport.State(),
            reducer: {
                TenantReport()
            }
        )
    )
}
