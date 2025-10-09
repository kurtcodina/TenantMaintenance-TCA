//
//  ReportDetailPhotosView.swift
//  TenantMaintenance-TCA
//
//  Created by codina on 10/9/25.
//

import SwiftUI

struct ReportDetailPhotosView: View {
    let report: Report
    
    var body: some View {
        if !report.photos.isEmpty {
            VStack(alignment: .leading, spacing: 8) {
                Text("Photos")
                    .font(.headline)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(report.photos, id: \.self) { img in
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
    }
}
