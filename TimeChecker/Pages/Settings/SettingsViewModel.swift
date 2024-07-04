//
//  SettingsViewModel.swift
//  TimeChecker
//
//  Created by yotahara on 2024/07/04.
//

import SwiftUI

@MainActor
class SettingsViewModel: ObservableObject {
    @Published var startTime: Int = 0
    @Published var endTime: Int = 0
    @Published var targetTime: Int = 0
    
    
    func judgeAndSaveResult() {
        // TODO: 判定結果の保存処理を実装する
    }
}
