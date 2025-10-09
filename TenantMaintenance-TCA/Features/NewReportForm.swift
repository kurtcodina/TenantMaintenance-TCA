//
//  TenantReportForm.swift
//  TenantMaintenance-TCA
//
//  Created by codina on 10/9/25.
//

import Foundation
import ComposableArchitecture
import PhotosUI
import SwiftUI

@Reducer
struct NewReportForm {
    @ObservableState
    struct State: Equatable, Sendable {
        var report: Report
        var focus: Field? = .title
        
        enum Field: Hashable {
            case title
            case description
        }
        
        init(report: Report, focus: Field? = .title) {
            self.report = report
            self.focus = focus
        }
    }
    
    enum Action: BindableAction, Equatable, Sendable {
        case titleSuggestionTapped(String)
        case addPhotoButtonTapped
        case pickerSelectionChanged
        case photosLoaded([UIImage])
        case binding(BindingAction<State>)

    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {

            case .titleSuggestionTapped(let suggestion):
                state.report.title = suggestion
                return .none

            case .addPhotoButtonTapped:
                return .none

            case .pickerSelectionChanged:
                let selectedItems = state.report.selectedItems
                return .run { send in
                    var images: [UIImage] = []
                    for item in selectedItems {
                        if let data = try? await item.loadTransferable(type: Data.self),
                           let image = UIImage(data: data) {
                            images.append(image)
                        }
                    }
                    await send(.photosLoaded(images))
                }

            case .photosLoaded(let images):
                state.report.photos = images
                return .none

            case .binding(_):
                 return .none
            }
            
        }
    }
}

