//
//  SettingsView.swift
//  TimeChecker
//
//  Created by yotahara on 2024/07/04.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 32) {
                    VStack {
                        Text("時間範囲の設定")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        timeSettingComponent(title: "開始時刻", value: $viewModel.startTime)
                        
                        timeSettingComponent(title: "終了時刻", value: $viewModel.endTime)
                    }
                    
                    VStack {
                        Text("時間範囲内かどうかを判定する対象の時刻の設定")
                            .lineLimit(2)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        timeSettingComponent(title: "判定する対象の時刻", value: $viewModel.targetTime)
                    }
                    
                    PrimaryButton(title: "判定開始") {
                        viewModel.judgeAndSaveResult()
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
