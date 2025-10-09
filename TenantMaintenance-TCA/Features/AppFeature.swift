//
//  MaintenanceReports.swift
//  TenantMaintenance-TCA
//
//  Created by codina on 10/5/25.
//

import ComposableArchitecture

@Reducer
struct AppFeature {
    @Reducer
    enum Path {
        case report(ReportDetail)
    }
    
    @ObservableState
    struct State: Equatable {
        var path = StackState<Path.State>()
        var reportsList = ReportsList.State()
    }
    
    enum Action {
        case path(StackActionOf<Path>)
        case reportsList(ReportsList.Action)
    }
    
    var body: some ReducerOf<AppFeature> {
        Scope(state: \.reportsList, action: \.reportsList) {
            ReportsList()
        }
        Reduce { state, action in
            switch action {
              
            case .path:
              return .none
              
            case .reportsList:
              return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

extension AppFeature.Path.State: Equatable {}
