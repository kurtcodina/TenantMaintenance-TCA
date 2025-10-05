//
//  TenantReport.swift
//  TenantMaintenance-TCA
//
//  Created by codina on 10/5/25.
//

import ComposableArchitecture
import _PhotosUI_SwiftUI


struct TenantReport: Reducer {
    struct State: Equatable {
        var title: String = ""
        var description: String = ""
        var selectedItems: [PhotosPickerItem] = []
        var photos: [UIImage] = []
    }
    
    enum Action: Equatable {
        case titleChanged(String)
        case descriptionChanged(String)
        case photoSelectionChanged([PhotosPickerItem])
        case photosLoaded([UIImage])
    }
    
    var body: some ReducerOf<TenantReport> {
        Reduce { state, action in
            switch action {
                
            case .titleChanged(let newTitle):
                state.title = newTitle
                return .none

            case .descriptionChanged(let newDescription):
                state.description = newDescription
                return .none

            case .photoSelectionChanged(let selection):
                state.selectedItems = selection
                return .run { [selection] send in
                    var images: [UIImage] = []
                    for item in selection {
                        if let data = try? await item.loadTransferable(type: Data.self),
                           let image = UIImage(data: data) {
                            images.append(image)
                        }
                    }
                    await send(.photosLoaded(images))
                }

            case .photosLoaded(let photos):
                state.photos = photos
                return .none
            }
        }
    }
}
