//
//  HomeView.swift
//  TimeChecker
//
//  Created by yotahara on 2024/07/04.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                PrimaryButton(title: "条件を設定して時刻を判定する") {
                    viewModel.showSettingsView.toggle()
                }
                .padding()
                
                HStack {
                    Text("判定結果の履歴")
                        .font(.headline)
                    
                    Spacer()
                    
                    if !viewModel.testResults.isEmpty {
                        EditHistoryButtons
                    }
                    
                }
                .padding()
                
                if viewModel.testResults.isEmpty {
                    Text("表示する判定結果がありません。")
                } else {
                    List(selection: $viewModel.selection) {
                        ForEach(viewModel.testResults, id: \.id) { result in
                            ResultView(result)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .listStyle(.plain)
                }
                
                Spacer()
            }
            .navigationTitle("Time Checker")
            .environment(\.editMode, $viewModel.editMode)
            .alert(item: $viewModel.alertType) { alertType in
                switch alertType {
                case .deleteSelected:
                    return AlertForDeleteSelected
                case .deleteAll:
                    return AlertForDeleteAll
                case .newResult(let result):
                    return AlertForNewResult(result)
                }
            }
            .sheet(isPresented: $viewModel.showSettingsView, content: {
                SettingsView(delegate: viewModel)
            })
            .onAppear {
                viewModel.fetchTestResults()
            }
        }
    }
}

extension HomeView {
    private func ResultView(_ result: TestResult) -> some View {
        HStack {
            VStack {
                Text("判定結果")
                    .font(.footnote)
                
                Text(result.isContained ? "OK" : "NG")
                    .font(.title3)
                    .foregroundColor(result.isContained ? .blue : .red)
            }
            
            Rectangle()
                .frame(width: 1)
            
            VStack {
                HStack {
                    Text("時間範囲：")
                        .font(.footnote)
                    
                    Text("\(result.timeRange.start)時 〜 \(result.timeRange.end)時")
                        .font(.callout.bold())
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text("判定対象時刻：")
                        .font(.footnote)
                    
                    Text("\(result.target)時")
                        .font(.callout.bold())
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
        .background(result.isContained ? Color.blue.opacity(0.1) : Color.red.opacity(0.1))
    }
    
    @ViewBuilder
    private var EditHistoryButtons: some View {
        if viewModel.editMode == .inactive {
            HStack(spacing: 16) {
                Button {
                    viewModel.alertType = .deleteAll
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "trash.fill")
                        Text("すべて削除する")
                    }
                    .foregroundColor(.red)
                }
                
                Button {
                    withAnimation {
                        viewModel.editMode = .active
                    }
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "square.and.pencil")
                        Text("編集")
                    }
                }
            }
        } else if viewModel.editMode == .active {
            HStack(spacing: 16) {
                Button {
                    viewModel.alertType = .deleteSelected
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "trash")
                        Text("削除")
                    }
                    .foregroundColor(.red)
                }
                .disabled(viewModel.selection.isEmpty)
                .opacity(viewModel.selection.isEmpty ? 0.5 : 1.0)
                
                Button {
                    withAnimation {
                        viewModel.editMode = .inactive
                    }
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "xmark")
                        Text("編集を中止")
                    }
                }
            }
        }
    }
    
    private var AlertForDeleteAll: Alert {
        Alert(title: Text("確認"),
              message: Text("すべての履歴を削除してよろしいですか？"),
              primaryButton: .destructive(Text("削除する")) {
            DispatchQueue.main.async {
                withAnimation {
                    self.viewModel.deleteAllResults()
                    self.viewModel.editMode = .inactive
                }
            }
        },
              secondaryButton: .default(Text("キャンセル")))
    }
    
    private var AlertForDeleteSelected: Alert {
        Alert(title: Text("確認"),
              message: Text("選択した履歴を削除してよろしいですか？"),
              primaryButton: .destructive(Text("削除する")) {
            DispatchQueue.main.async {
                withAnimation {
                    self.viewModel.deleteSelectedResults()
                    self.viewModel.editMode = .inactive
                }
            }
        },
              secondaryButton: .default(Text("キャンセル")))
    }
    
    private func AlertForNewResult(_ result: TestResult) -> Alert {
        let title = "結果: \(result.isContained ? "OK" : "NG")"
        let message = "時間範囲：\(result.timeRange.start)時 ~ \(result.timeRange.end)時\n判定対象時刻：\(result.target)時"
        return Alert(title: Text(title),
                     message: Text(message),
                     dismissButton: .default(Text("OK")))
    }
}

#Preview {
    HomeView()
}
