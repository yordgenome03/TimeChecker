//
//  HomeView.swift
//  TimeChecker
//
//  Created by yotahara on 2024/07/04.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var alertType: HomeViewModel.AlertType?
    var body: some View {
        NavigationView {
            VStack {
                Button {
                    withAnimation {
                        viewModel.showDescription.toggle()
                    }
                } label: {
                    HStack {
                        Image(systemName: "quote.bubble")
                            .font(.title)
                    }
                }
                .padding(.top, 16)
                
                if viewModel.showDescription {
                    ScrollView {
                        VStack(spacing: 24) {
                            Text("【概要】\nこのアプリは、開始時刻と終了時刻、判定対象時刻を入力し、判定対象時刻が指定した時刻の範囲にあるかどうかを判定します。")
                            
                            Text("【ルール】\n・範囲指定は、開始時刻を含み、終了時刻は含まない。\n・ただし開始時刻と終了時刻が同じ場合は含むと判断する。\n・開始時刻が22時で終了時刻が5時、というような指定の場合、終了時刻を翌5時と判定する。\n・判定結果OK；対象時刻が指定範囲内。\n・判定結果NG：対象時刻が指定範囲外。")
                        }
                        .fixedSize(horizontal: false, vertical: true)
                        .padding()
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.accentColor, lineWidth: 2)
                    )
                    .padding()
                }
                PrimaryButton(title: "条件を設定して時刻を判定する") {
                    withAnimation {
                        viewModel.editMode = .inactive
                    }
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
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .padding()
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
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("Time Checker")
            .environment(\.editMode, $viewModel.editMode)
            .alert(item: $alertType) { alertType in
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
            .onReceive(viewModel.$alertType) { newAlertType in
                alertType = newAlertType
            }
        }
    }
}

extension HomeView {
    private func ResultView(_ result: TimeCheckResult) -> some View {
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
                    Text("対象時刻：")
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
                IconTextButton(title: "すべて削除する", systemImage: "trash.fill", color: .red) {
                    viewModel.alertType = .deleteAll
                }
                
                IconTextButton(title: "編集", systemImage: "square.and.pencil", color: .accentColor) {
                    withAnimation {
                        viewModel.editMode = .active
                    }
                }
            }
        } else if viewModel.editMode == .active {
            HStack(spacing: 16) {
                IconTextButton(title: "削除", systemImage: "trash", color: .red) {
                    viewModel.alertType = .deleteSelected
                }
                .disabled(viewModel.selection.isEmpty)
                .opacity(viewModel.selection.isEmpty ? 0.5 : 1.0)
                
                IconTextButton(title: "編集を中止", systemImage: "xmark", color: .accentColor) {
                    withAnimation {
                        viewModel.editMode = .inactive
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
    
    private func AlertForNewResult(_ result: TimeCheckResult) -> Alert {
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
