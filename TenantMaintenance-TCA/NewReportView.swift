//
//  NewReportView.swift
//  TenantMaintenance-TCA
//
//  Created by codina on 10/5/25.
//

import SwiftUI
import PhotosUI
import ComposableArchitecture

struct NewReportView: View {
    @Environment(\.dismiss) private var dismiss
    
    let store: StoreOf<TenantReport>
    let onSave: () -> Void
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Short title")
                                .font(.headline)
                            TextField(
                                "What needs maintenance?",
                                text: viewStore.binding(
                                    get: \.title,
                                    send: {
                                        .titleChanged($0)
                                    }
                                )
                            )
                            .textFieldStyle(.roundedBorder)
                        }
                        SuggestionsScrollView { suggestion in
                            viewStore.send(.titleChanged(suggestion))
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Description (optional)")
                                .font(.headline)
                            TextEditor(text: viewStore.binding(get: \.description, send: {
                                .descriptionChanged($0)
                            }))
                            .frame(minHeight: 100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.5))
                            )
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Photos (optional)")
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
                                    
                                    PhotosPicker(
                                        selection: viewStore.binding(get: \.selectedItems, send: {
                                            .photosPickerSelectionChanged($0)
                                        }),
                                        maxSelectionCount: 6,
                                        matching: .images
                                    ) {
                                        AddPhotoSquareButton()
                                    }
                                }
                            }
                            
                        }
                        Spacer()
                    }
                    .padding()
                }
                .navigationTitle("New Report")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            viewStore.send(.dismissButtonTapped)
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            onSave()
                            dismiss()
                        }
                        .disabled(viewStore.state.title.isEmpty)
                    }
                }
            }
        }
    }
}

#Preview {
    NewReportView(
        store: .init(
            initialState: TenantReport.State(),
            reducer: {
                TenantReport()
            }
        ),
        onSave: {}
    )
}
