//
//  TenantReport.swift
//  TenantMaintenance-TCA
//
//  Created by codina on 10/9/25.
//

import Foundation
import _PhotosUI_SwiftUI

struct Report: Identifiable, Equatable {
    let id: UUID = UUID()
    let createdAt: Date = .now
    var title: String = ""
    var description: String = ""
    var status: ReportStatus = .open
    var selectedItems: [PhotosPickerItem] = []
    var photos: [UIImage] = []
    
    static func == (lhs: Report, rhs: Report) -> Bool {
        lhs.id == rhs.id &&
        lhs.createdAt == rhs.createdAt &&
        lhs.title == rhs.title &&
        lhs.description == rhs.description &&
        lhs.status == rhs.status &&
        lhs.selectedItems.map { $0.itemIdentifier ?? "" } ==
               rhs.selectedItems.map { $0.itemIdentifier ?? "" }
    }
}

