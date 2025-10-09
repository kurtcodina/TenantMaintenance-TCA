//
//  ReportsList.swift
//  TenantMaintenance-TCA
//
//  Created by codina on 10/9/25.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct ReportsList {
    @Reducer
    enum Destination {
        case add(NewReportForm)
    }
    
    @ObservableState
    struct State: Equatable {
        @Presents var destination: Destination.State?
        var reports: [Report] = []
    }
    
    enum Action {
        case addReportButtonTapped
        case saveNewReportButtonTapped
        case cancelNewReportButtonTapped
        
        case destination(PresentationAction<Destination.Action>)
    }

        
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addReportButtonTapped:
                state.destination = .add(.init(report: .init()))
                return .none
                
            case .saveNewReportButtonTapped:
                guard case let .some(.add(editState)) = state.destination
                else { return .none }
                let report = editState.report

                state.reports.append(report)
                state.destination = nil
                return .none
                
            case .cancelNewReportButtonTapped:
                state.destination = nil
                return .none
                
            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

extension ReportsList.Destination.State: Equatable { }
