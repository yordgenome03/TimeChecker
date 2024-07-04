//
//  IconTextButton.swift
//  TimeChecker
//
//  Created by yotahara on 2024/07/04.
//

import SwiftUI

struct IconTextButton: View {
    let title: String
    let systemImage: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 4) {
                Image(systemName: systemImage)
                Text(title)
            }
            .font(.caption.bold())
            .foregroundColor(color)
        }
    }
}

#Preview {
    IconTextButton(title: "タイトル", systemImage: "circle.fill", color: .red) {
        print("button tapped")
    }
    .padding()
}
