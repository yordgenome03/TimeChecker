//
//  UserDefaultsStore.swift
//  TimeChecker
//
//  Created by yotahara on 2024/07/04.
//

import Foundation

class UserDefaultsService {
    func save(results: [TimeCheckResult]) {
        if let data = try? JSONEncoder().encode(results) {
            UserDefaults.standard.set(data, forKey: Keys.timeCheckResults)
        }
    }
    
    func fetchResults() -> [TimeCheckResult] {
        if let data = UserDefaults.standard.data(forKey: Keys.timeCheckResults),
           let results = try? JSONDecoder().decode([TimeCheckResult].self, from: data) {
            return results
        }
        return []
    }
    
    func delete(results: [TimeCheckResult]) {
        let currentResults = fetchResults().filter { !results.contains($0) }
        save(results: currentResults)
    }
    
    func deleteAllResults() {
        UserDefaults.standard.removeObject(forKey: Keys.timeCheckResults)
    }
}
