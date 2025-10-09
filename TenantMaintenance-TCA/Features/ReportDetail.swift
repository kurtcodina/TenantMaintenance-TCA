//
//  ReportDetail.swift
//  TenantMaintenance-TCA
//
//  Created by codina on 10/9/25.
//

import ComposableArchitecture
import _PhotosUI_SwiftUI

@Reducer
struct ReportDetail {
    @ObservableState
    struct State: Equatable {
        var report: Report
    }
    
    enum Action: Equatable {
        case statusTapped
        case backTapped
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .statusTapped:
                state.report.status = .resolved
                return .none
                
            case .backTapped:
                return .run { _ in await dismiss()
                    
                }
            }
        }
    }
}
