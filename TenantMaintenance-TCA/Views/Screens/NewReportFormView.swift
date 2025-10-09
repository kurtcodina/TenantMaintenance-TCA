//
//  NewReportFormView.swift
//  TenantMaintenance-TCA
//
//  Created by codina on 10/5/25.
//

import SwiftUI
import PhotosUI
import ComposableArchitecture

struct NewReportFormView: View {
    @Bindable var store: StoreOf<NewReportForm>
    @FocusState var focus: NewReportForm.State.Field?
        
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Short title")
                            .font(.headline)
                        TextField("What needs maintenance?", text: $store.report.title)
                        .textFieldStyle(.roundedBorder)
                    }
                    SuggestionsScrollView (title: $store.report.title)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Description (optional)")
                            .font(.headline)
                        TextEditor(text: $store.report.description)
                        .frame(minHeight: 100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5))
                        )
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Photos (optional)")
                            .font(.headline)
                        
                        ReportFormPhotoPicker(store: store)
                        
                    }
                    Spacer()
                }
                .padding()
            }
        }
        
    }
}
