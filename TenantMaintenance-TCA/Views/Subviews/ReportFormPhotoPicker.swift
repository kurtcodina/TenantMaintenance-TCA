//
//  ReportFormPhotoPicker.swift
//  TenantMaintenance-TCA
//
//  Created by codina on 10/9/25.
//

import SwiftUI
import _PhotosUI_SwiftUI
import ComposableArchitecture

struct ReportFormPhotoPicker: View {
    @Bindable var store: StoreOf<NewReportForm>
    
    var body: some View {
                
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(store.report.photos, id: \.self) { img in
                    Image(uiImage: img)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipped()
                        .cornerRadius(8)
                }
                
                PhotosPicker(
                    selection: $store.report.selectedItems,
                    maxSelectionCount: 6,
                    matching: .images
                ) {
                    AddPhotoSquareButton()
                }
                .onChange(of: store.report.selectedItems) { oldValue, newValue in
                    store.send(.pickerSelectionChanged)
                }
            }
        }
    }
}

