//
//  UserDefaultsStore.swift
//  TimeChecker
//
//  Created by yotahara on 2024/07/04.
//

import Foundation

class UserDefaultsService {
    func save(results: [TestResult]) {
        if let data = try? JSONEncoder().encode(results) {
            UserDefaults.standard.set(data, forKey: Keys.testResults)
        }
    }
    
    func fetch() -> [TestResult] {
        if let data = UserDefaults.standard.data(forKey: Keys.testResults),
           let results = try? JSONDecoder().decode([TestResult].self, from: data) {
            return results
        }
        return []
    }
}
