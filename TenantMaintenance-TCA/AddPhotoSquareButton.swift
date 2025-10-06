//
//  AddPhotoSquareButton.swift
//  TenantMaintenance-TCA
//
//  Created by codina on 10/6/25.
//

import SwiftUI

struct AddPhotoSquareButton: View {
    var body: some View {
        Image(systemName: "plus")
            .font(.system(size: 24, weight: .medium))
            .foregroundStyle(.secondary)
            .frame(width: 80, height: 80)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.secondary, style: StrokeStyle(lineWidth: 1, dash: [4]))
            )
    }
}
