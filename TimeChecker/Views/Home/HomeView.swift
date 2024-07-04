//
//  HomeView.swift
//  TimeChecker
//
//  Created by yotahara on 2024/07/04.
//

import SwiftUI

struct HomeView: View {
    enum AlertType: Identifiable {
        case deleteSelected
        case deleteAll
        
        var id: Int { hashValue }
    }
    
    @State private var testResults: [TestResult] = []
    @State private var selection = Set<UUID>()
    @State private var editMode: EditMode = .inactive
    @State private var alertType: AlertType?
    @State private var showSettingsView = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button {
                    showSettingsView.toggle()
                } label: {
                    Text("条件を設定して時刻を判定する")
                        .font(.body.bold())
                        .foregroundColor(Color.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundColor(Color.accentColor)
                        )
                }
                .padding()
                
                HStack {
                    Text("判定結果の履歴")
                        .font(.headline)
                    
                    Spacer()
                    
                    if !testResults.isEmpty {
                        EditHistoryButtons
                    }
                    
                }
                .padding()
                
                if testResults.isEmpty {
                    Text("表示する判定結果がありません。")
                } else {
                    List(selection: $selection) {
                        ForEach(testResults, id: \.id) { result in
                            ResultView(result)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .listStyle(.plain)
                }
                
                Spacer()
            }
            .navigationTitle("Time Checker")
            .environment(\.editMode, $editMode)
            .alert(item: $alertType) { alertType in
                switch alertType {
                case .deleteSelected:
                    return AlertForDeleteSelected
                case .deleteAll:
                    return AlertForDeleteAll
                }
            }
            .sheet(isPresented: $showSettingsView, content: {
                // TODO: 設定画面表示
                EmptyView()
            })
            .onAppear {
                // TODO: 履歴取得処理と差し替える
                testResults = TestResult.mockArray
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
        if editMode == .inactive {
            HStack(spacing: 16) {
                Button {
                    alertType = .deleteAll
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "trash.fill")
                        Text("すべて削除する")
                    }
                    .foregroundColor(.red)
                }
                
                Button {
                    withAnimation {
                        editMode = .active
                    }
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "square.and.pencil")
                        Text("編集")
                    }
                }
            }
        } else if editMode == .active {
            HStack(spacing: 16) {
                Button {
                    alertType = .deleteSelected
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "trash")
                        Text("削除")
                    }
                    .foregroundColor(.red)
                }
                .disabled(selection.isEmpty)
                .opacity(selection.isEmpty ? 0.5 : 1.0)
                
                Button {
                    withAnimation {
                        editMode = .inactive
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
            // TODO: 履歴のリストからすべての履歴を削除する
            DispatchQueue.main.async {
                withAnimation {
                    self.editMode = .inactive
                }
            }
        },
              secondaryButton: .default(Text("キャンセル")))
    }
    
    private var AlertForDeleteSelected: Alert {
        Alert(title: Text("確認"),
              message: Text("選択した履歴を削除してよろしいですか？"),
              primaryButton: .destructive(Text("削除する")) {
            // TODO: 履歴のリストから選択した履歴を削除する
            DispatchQueue.main.async {
                withAnimation {
                    self.editMode = .inactive
                }
            }
        },
              secondaryButton: .default(Text("キャンセル")))
    }
}

#Preview {
    HomeView()
}
