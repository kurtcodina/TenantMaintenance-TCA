//
//  ReportDetailDescriptionView.swift
//  TenantMaintenance-TCA
//
//  Created by codina on 10/9/25.
//

import SwiftUI

struct ReportDetailDescriptionView: View {
    let report: Report
    
    var body: some View {
        if !report.description.isEmpty {
            VStack(alignment: .leading, spacing: 8) {
                Text("Description")
                    .font(.headline)
                Text(report.description)
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(UIColor.secondarySystemGroupedBackground))
                    .cornerRadius(10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        } else {
            EmptyView()
        }
    }
}
