//
//  MaintenanceReports.swift
//  TenantMaintenance-TCA
//
//  Created by codina on 10/5/25.
//

import ComposableArchitecture

@Reducer
struct AppFeature {
    @ObservableState
    struct State: Equatable {
        var reports: IdentifiedArrayOf<TenantReport.State> = []
        var showNewReportSheet = false
        @Presents var newReport: TenantReport.State?
    }

    enum Action {
        case addReportButtonTapped
        case dismissNewReport
        case newReport(PresentationAction<TenantReport.Action>)
        case saveReport
        case report(IdentifiedActionOf<TenantReport>)
    }

    var body: some ReducerOf<AppFeature> {
        Reduce { state, action in
            switch action {
            case .addReportButtonTapped:
                state.newReport = TenantReport.State()
                return .none
                
            case .dismissNewReport:
                state.newReport = nil
                return .none
                
            case .saveReport:
                if let report = state.newReport {
                    state.reports.append(report)
                    state.newReport = nil
                }
                return .none
                
            case .newReport:
                return .none
                
            case .report:
                return .none
            }
        }
        .ifLet(\.$newReport, action: \.newReport) {
            TenantReport()
        }
        .forEach(\.reports, action: \.report) {
            TenantReport()
        }
    }
}
