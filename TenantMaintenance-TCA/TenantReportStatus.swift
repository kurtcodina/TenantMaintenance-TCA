//
//  TenantReportStatus.swift
//  TenantMaintenance-TCA
//
//  Created by codina on 10/6/25.
//


import SwiftUI

enum TenantReportStatus: String, CaseIterable {
    case open = "Open"
    case resolved = "Resolved"

    var color: Color {
        switch self {
        case .open:
            return .accentColor
        case .resolved:
            return .green
        }
    }
}
