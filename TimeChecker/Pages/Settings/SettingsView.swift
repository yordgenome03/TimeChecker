//
//  SettingsView.swift
//  TimeChecker
//
//  Created by yotahara on 2024/07/04.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showKeyboard = false

    let delegate: SettingsViewModelDelegate

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 32) {
                    VStack {
                        Text("時間範囲の設定")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        TimeSettingComponent(title: "開始時刻", value: $viewModel.startTime)
                        
                        TimeSettingComponent(title: "終了時刻", value: $viewModel.endTime)
                    }
                    
                    VStack {
                        Text("時間範囲内かどうかを判定する対象の時刻の設定")
                            .lineLimit(2)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        TimeSettingComponent(title: "判定する対象の時刻", value: $viewModel.targetTime)
                    }
                    
                    PrimaryButton(title: "判定開始") {
                        do {
                            try viewModel.judgeAndSaveResult()
                            presentationMode.wrappedValue.dismiss()
                        } catch {
                            if let error = error as? TimeRangeError {
                                viewModel.error = error
                            } else {
                                viewModel.error = TimeRangeError.unknown
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Settings")
            .alert(item: $viewModel.error) { error in
                Alert(title: Text("エラー"),
                      message: Text(error.description),
                             dismissButton: .default(Text("OK")))
            }
            .onAppear {
                viewModel.delegate = delegate
            }
        }
    }
}

extension SettingsView {
    private func TimeSettingComponent(title: String, value: Binding<Int>) -> some View {
        VStack {
            Text(title)
                .font(.title3.bold())
                .frame(maxWidth: .infinity, alignment: .center)
            HStack(spacing: 16) {
                HStack(spacing: 8) {
                    ClosableNumberField(value: value,
                                        placeholder: "",
                                        maxWidth: 40)
                    .frame(width: 40)
                    .padding(4)
                    .background(
                        Rectangle()
                            .frame(height: 1)
                            .frame(maxHeight: .infinity, alignment: .bottom)
                    )
                    
                    Text("時")
                }
                .frame(width: 80)

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
    SettingsView(delegate: HomeViewModel())
}
