//
//  HomeViewModel.swift
//  TimeChecker
//
//  Created by yotahara on 2024/07/04.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    enum AlertType: Identifiable, Equatable {
        case deleteSelected
        case deleteAll
        case newResult(TimeCheckResult)
        
        var id: UUID { UUID() }
    }
    
    @Published var testResults: [TimeCheckResult] = []
    @Published var selection = Set<UUID>()
    @Published var editMode: EditMode = .inactive
    @Published var alertType: AlertType?
    @Published var showSettingsView = false
    @Published var showDescription = true

    private let repository: TimeCheckResultRepositoryInterface
    
    init(repository: TimeCheckResultRepositoryInterface = TimeCheckResultRepository()) {
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
    func didSaveTestResult(_ result: TimeCheckResult) {
        fetchTestResults()
        alertType = .newResult(result)
    }
}
