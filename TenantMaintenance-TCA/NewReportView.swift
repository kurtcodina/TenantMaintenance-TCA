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

    private let suggestions = ["No hot water", "Heating", "Leaking", "Broken window", "Electrical"]
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        
                        // Title field
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Short title")
                                .font(.headline)
                            TextField(
                                "No hot water · Broken oven · Window stuck",
                                text: viewStore.binding(
                                    get: \.title,
                                    send: {
                                        .titleChanged($0)
                                    }
                                )
                            )
                            .textFieldStyle(.roundedBorder)
                            HStack {
                                Text("\(viewStore.state.title.count)")
                                    .font(.footnote)
                                    .foregroundColor(viewStore.state.title.isEmpty ? .red : .secondary)
                                Spacer()
                            }
                            if viewStore.state.title.isEmpty {
                                Text("Title cannot be empty")
                                    .font(.footnote)
                                    .foregroundColor(.red)
                            }
                        }
                        
                        // Quick suggestion chips
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(suggestions, id: \.self) { suggestion in
                                    Button(
                                        action: {
                                            viewStore.send(.titleChanged(suggestion))
                                        }) {
                                            Text(suggestion)
                                                .padding(.horizontal, 12)
                                                .padding(.vertical, 6)
                                                .background(Color.gray.opacity(0.2))
                                                .cornerRadius(16)
                                        }
                                }
                            }
                        }
                        
                        // Details TextEditor
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Details (optional)")
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
                        
                        // Photos picker
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Photos (optional)")
                                .font(.headline)
                            PhotosPicker(
                                selection: viewStore.binding(get: \.selectedItems, send: {
                                    .photosPickerSelectionChanged($0)
                                }),
                                maxSelectionCount: 6,
                                matching: .images
                            ) {
                                Text("Add Photos")
                                    .padding(.horizontal)
                                    .padding(.vertical, 8)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            
                            if !viewStore.state.photos.isEmpty {
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
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    .padding()
                }
                .navigationTitle("New Report")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { dismiss() }
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
