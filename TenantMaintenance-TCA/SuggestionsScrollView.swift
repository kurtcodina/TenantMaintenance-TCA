//
//  SuggestionsScrollView.swift
//  TenantMaintenance-TCA
//
//  Created by codina on 10/6/25.
//

import SwiftUI

struct SuggestionsScrollView: View {
    private let suggestions = ["No Hot Water 💧", "Broken Oven 🔨", "Cracked Window 🪟", "Electrical ⚡️"]
    
    let action: (String) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(suggestions, id: \.self) { suggestion in
                    Button(
                        action: {
                            action(suggestion)
                        }) {
                            Text(suggestion)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .foregroundStyle(Color.accentColor)
                                .background(Color.accentColor.quinary)
                                .cornerRadius(16)
                        }
                }
            }
            .padding(.horizontal)
        }
        .padding(.horizontal, -16)
    }
}
