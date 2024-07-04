//
//  PrimaryButton.swift
//  TimeChecker
//
//  Created by yotahara on 2024/07/04.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.body.bold())
                .foregroundColor(Color.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(Color.accentColor)
                )
        }
    }
}

#Preview {
    PrimaryButton(title: "タイトル") {
        print("button tapped")
    }
    .padding()
}
