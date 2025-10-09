//
//  PurpleAddButton.swift
//  TenantMaintenance-TCA
//
//  Created by codina on 10/9/25.
//

import SwiftUI

struct PurpleAddButton: View {
    var body: some View {
        Label("New", systemImage: "plus")
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .background(Capsule().fill(Color.accentColor))
            .foregroundColor(.white)
            .labelStyle(.titleAndIcon)
    }
}

#Preview {
    PurpleAddButton()
}
