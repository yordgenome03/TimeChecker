//
//  Binding+Equatable.swift//  TimeChecker
//
//  Created by yotahara on 2024/07/04.
//

import SwiftUI

extension Binding where Value: Equatable {
    func isPresent<WrappedValue>() -> Binding<Bool> where Value == Optional<WrappedValue> {
        return Binding<Bool>(
            get: { self.wrappedValue != nil },
            set: { if !$0 { self.wrappedValue = nil } }
        )
    }
}
