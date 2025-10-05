//
//  MaintenanceView.swift
//  TenantMaintenance-TCA
//
//  Created by codina on 10/5/25.
//

import SwiftUI

struct MaintenanceView: View {
    
    let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "HH:mm - dd MMMM yyyy"
        return f
    }()
    
    @State private var showNewReportSheet = false

    
    var body: some View {
        ScrollView {
            Text("Requests submitted for your Landord to review.")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            LazyVStack(spacing: 12) {
                ForEach(1...12, id: \.self) { number in
                    VStack(alignment: .leading) {
                        Text("Item \(number)")
                            .font(.headline)
                        HStack {
                            Text(dateFormatter.string(from: Date()))                                .font(.subheadline)
                            Spacer()
                            Text("Resolved")
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Maintenance")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print("New tapped")
                        showNewReportSheet = true
                    } label: {
                        Label("New", systemImage: "plus")
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .background(Capsule().fill(Color(red: 90/255, green: 69/255, blue: 254/255)))
                            .foregroundColor(.white)
                            .labelStyle(.titleAndIcon)
                    }
                    .buttonStyle(.plain)
                    .sheet(isPresented: $showNewReportSheet) {
                        NewReportView(
                            store: .init(
                                initialState: TenantReport.State(),
                                reducer: {
                                    TenantReport()._printChanges()
                                }
                            )
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    MaintenanceView()
}
