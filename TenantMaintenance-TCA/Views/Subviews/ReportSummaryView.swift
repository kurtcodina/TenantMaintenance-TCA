//
//  ReportSummaryView.swift
//  TenantMaintenance-TCA
//
//  Created by codina on 10/9/25.
//

import SwiftUI

struct ReportSummaryView: View {
    let report: Report
    
    let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "HH:mm - dd MMMM yyyy"
        return f
    }()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(report.title)
                .font(.headline)
                .foregroundStyle(Color.primary)
            
            HStack {
                Text(dateFormatter.string(from: report.createdAt))
                    .font(.subheadline)
                    .foregroundStyle(Color.secondary)
                Spacer()
                Text(report.status.rawValue)
                    .font(.subheadline)
                    .foregroundStyle(report.status.color)
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
}
