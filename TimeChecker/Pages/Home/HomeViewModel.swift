//
//  HomeViewModel.swift
//  TimeChecker
//
//  Created by yotahara on 2024/07/04.
//

import SwiftUI

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
    
    private let repository: TestResultRepositoryInterface
    
    init(repository: TestResultRepositoryInterface = TestResultRepository()) {
        self.repository = repository
    }
    
    @MainActor
    func fetchTestResults() {
        testResults = repository.fetchResults()
    }
    
    @MainActor
    func deleteSelectedResults() {
        let selectedResults = testResults.filter { selection.contains($0.id) }
        repository.deleteResults(selectedResults)
        withAnimation {
            testResults = repository.fetchResults()
            editMode = .inactive
        }
    }
    
    @MainActor
    func deleteAllResults() {
        repository.deleteAllResults()
        withAnimation {
            testResults = []
            editMode = .inactive
        }
    }
}

// MARK: - SettingsViewModelDelegate

extension HomeViewModel: SettingsViewModelDelegate {
    
    @MainActor
    func didSaveTestResult(_ result: TestResult) {
        fetchTestResults()
    }
}
