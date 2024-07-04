//
//  SettingsView.swift
//  TimeChecker
//
//  Created by yotahara on 2024/07/04.
//

import SwiftUI

struct SettingsView: View {
    @State private var startTime: Int = 0
    @State private var endTime: Int = 0
    @State private var targetTime: Int = 0
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 32) {
                    VStack {
                        Text("時間範囲の設定")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        timeSettingComponent(title: "開始時刻", value: $startTime)
                        
                        timeSettingComponent(title: "終了時刻", value: $endTime)
                    }
                    
                    VStack {
                        Text("時間範囲内かどうかを判定する対象の時刻の設定")
                            .lineLimit(2)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        timeSettingComponent(title: "判定する対象の時刻", value: $targetTime)
                    }
                    
                    PrimaryButton(title: "判定開始") {
                        // TODO: 判定処理・履歴保存処理を実装
                        dismiss()
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Settings")
        }
    }
}

extension SettingsView {
    private func timeSettingComponent(title: String, value: Binding<Int>) -> some View {
        VStack {
            Text(title)
                .font(.title3.bold())
                .frame(maxWidth: .infinity, alignment: .center)
            HStack(spacing: 8) {
                HStack(spacing: 8) {
                    TextField("", value: value, formatter: NumberFormatter())
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .padding(4)
                        .background(
                            Rectangle()
                                .frame(height: 1)
                                .frame(maxHeight: .infinity, alignment: .bottom)
                        )
                    Text("時")
                }
                .frame(width: 88)
                
                Stepper(value: value, in: 0...23) {
                    Text("")
                }
                .labelsHidden()
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.lightGray))
        )
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    SettingsView()
}
