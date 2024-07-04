//
//  HomeViewModel.swift
//  TimeChecker
//
//  Created by yotahara on 2024/07/04.
//

import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    enum AlertType: Identifiable {
        case deleteSelected
        case deleteAll
        
        var id: Int { hashValue }
    }
    
    @Published var testResults: [TestResult] = []
    @Published var selection = Set<UUID>()
    @Published var editMode: EditMode = .inactive
    @Published var alertType: AlertType?
    @Published var showSettingsView = false
    
    func fetchTestResults() {
        // TODO: 履歴取得処理を実装する
        testResults = TestResult.mockArray
    }
    
    func deleteSelectedResults() {
        // TODO: 選択した履歴を削除する処理を実装する
        withAnimation {
            editMode = .inactive
        }
    }
    
    func deleteAllResults() {
        // TODO: すべての履歴を削除する処理を実装する
        withAnimation {
            editMode = .inactive
        }
    }
}
